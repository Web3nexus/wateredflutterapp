import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/consultation/providers/booking_providers.dart';
import 'package:Watered/features/consultation/services/booking_service.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/features/consultation/models/consultation_type.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsultationScreen extends ConsumerStatefulWidget {
  const ConsultationScreen({super.key});

  @override
  ConsumerState<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends ConsumerState<ConsultationScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Guidance', 'Emotional', 'Spiritual', 'Ancestral', 'Healing'];
  int? _selectedTypeId;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isLoading = false;
  final _notesController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final user = ref.read(authProvider).user;
    if (_selectedTypeId == null || _selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a type, date, and time.')),
      );
      return;
    }

    if (_phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your phone number.')),
      );
      return;
    }

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to book a consultation.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final startTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      final response = await ref.read(bookingServiceProvider).createBooking(
        consultationTypeId: _selectedTypeId!,
        scheduledAt: startTime,
        fullName: user.name,
        email: user.email,
        phone: _phoneController.text.trim(),
        notes: _notesController.text,
      );

      final paymentUrl = response['payment_url'];

      if (paymentUrl != null && mounted) {
        final uri = Uri.parse(paymentUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please complete payment in your browser.')),
            );
            Navigator.of(context).pop();
          }
        } else {
          throw 'Could not launch payment URL';
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final typesAsync = ref.watch(consultationTypesProvider(_selectedCategory == 'All' ? null : _selectedCategory));

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Book Consultation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filter by Category', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat;
                  return Center(
                    child: FilterChip(
                      label: Text(cat, style: const TextStyle(fontSize: 12)),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = cat;
                          _selectedTypeId = null; // Reset selection when category changes
                        });
                      },
                      backgroundColor: theme.cardTheme.color,
                      selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text('Select Consultation Type', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            typesAsync.when(
              data: (types) => DropdownButtonFormField<int>(
                value: _selectedTypeId,
                dropdownColor: theme.cardTheme.color,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: theme.cardTheme.color,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                hint: const Text('Choose a consultation type'),
                items: types.map((type) {
                  return DropdownMenuItem<int>(
                    value: type.id,
                    child: Text(
                      '${type.name} - \$${type.price}',
                      style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedTypeId = value);
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Text('Error loading types: $e'),
            ),
            const SizedBox(height: 32),

            Text('Your Phone Number', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                filled: true,
                fillColor: theme.cardTheme.color,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                hintText: 'Enter your phone number',
              ),
            ),
            const SizedBox(height: 32),
            
            Text('Select Date & Time', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            ListTile(
              tileColor: theme.cardTheme.color,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              title: Text(
                _selectedDate == null 
                  ? 'Pick Date' 
                  : DateFormat('MMM d, yyyy').format(_selectedDate!),
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                 final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 90)),
                 );
                 if (date != null) setState(() => _selectedDate = date);
              },
            ),
            const SizedBox(height: 12),
             ListTile(
              tileColor: theme.cardTheme.color,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              title: Text(
                _selectedTime == null 
                  ? 'Pick Time' 
                  : _selectedTime!.format(context),
              ),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                 final time = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 10, minute: 0),
                 );
                 if (time != null) setState(() => _selectedTime = time);
              },
            ),
            const SizedBox(height: 32),

            Text('Notes', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: theme.cardTheme.color,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                hintText: 'Any specific questions?',
              ),
            ),

            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('REQUEST BOOKING'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

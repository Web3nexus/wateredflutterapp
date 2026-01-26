import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/consultation/providers/booking_providers.dart';
import 'package:Watered/features/consultation/services/booking_service.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsultationScreen extends ConsumerStatefulWidget {
  const ConsultationScreen({super.key});

  @override
  ConsumerState<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends ConsumerState<ConsultationScreen> {
  int? _selectedTypeId;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isLoading = false;
  final _notesController = TextEditingController();

  Future<void> _submit() async {
    if (_selectedTypeId == null || _selectedDate == null || _selectedTime == null) return;

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
        _selectedTypeId!,
        startTime,
        _notesController.text,
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
    final typesAsync = ref.watch(consultationTypesProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Book Consultation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Consultation Type', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            typesAsync.when(
              data: (types) => Wrap(
                spacing: 12,
                runSpacing: 12,
                children: types.map((type) {
                   final isSelected = _selectedTypeId == type.id;
                   return ChoiceChip(
                     label: Text('${type.name} - \$${type.price}'),
                     selected: isSelected,
                     onSelected: (selected) {
                       setState(() => _selectedTypeId = selected ? type.id : null);
                     },
                     selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                     backgroundColor: theme.cardTheme.color,
                     labelStyle: TextStyle(
                       color: isSelected ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color,
                     ),
                   );
                }).toList(),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (e, s) => Text('Error loading types: $e'),
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

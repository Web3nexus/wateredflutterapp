import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/consultation/models/consultation_type.dart';
import 'package:Watered/features/consultation/services/booking_service.dart';
import 'package:intl/intl.dart';

class BookingFormScreen extends ConsumerStatefulWidget {
  final ConsultationType type;
  const BookingFormScreen({super.key, required this.type});

  @override
  ConsumerState<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends ConsumerState<BookingFormScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final _notesController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.black,
              surface: const Color(0xFF1E293B),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
       builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.black,
              surface: const Color(0xFF1E293B),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  Future<void> _submit() async {
    if (_selectedDate == null || _selectedTime == null || _nameController.text.isEmpty || _emailController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill in all required fields.')));
      return;
    }

    setState(() => _isLoading = true);
    
    final scheduledAt = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    try {
      await ref.read(bookingServiceProvider).createBooking(
        consultationTypeId: widget.type.id,
        scheduledAt: scheduledAt,
        fullName: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        notes: _notesController.text,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Booking request sent successfully!')));
        Navigator.pop(context); // Close form
        Navigator.pop(context); // Close list (optional, maybe stay)
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: Text('BOOK ${widget.type.name.toUpperCase()}'),
        backgroundColor: const Color(0xFF0F172A),
         iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Date & Time',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _pickDate,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            _selectedDate == null ? 'Select Date' : DateFormat('MMM dd, yyyy').format(_selectedDate!),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: _pickTime,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            _selectedTime == null ? 'Select Time' : _selectedTime!.format(context),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'Contact Information',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E293B),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                hintText: 'Full Name',
                hintStyle: const TextStyle(color: Colors.white24),
                prefixIcon: const Icon(Icons.person_outline, color: Colors.white24),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E293B),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                hintText: 'Email Address',
                hintStyle: const TextStyle(color: Colors.white24),
                prefixIcon: const Icon(Icons.email_outlined, color: Colors.white24),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E293B),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                hintText: 'Phone Number',
                hintStyle: const TextStyle(color: Colors.white24),
                prefixIcon: const Icon(Icons.phone_outlined, color: Colors.white24),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Notes (Optional)',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _notesController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E293B),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                hintText: 'Any specific questions or topics...',
                hintStyle: const TextStyle(color: Colors.white24),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading 
                  ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black)) 
                  : const Text('CONFIRM BOOKING', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

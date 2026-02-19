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
      selectableDayPredicate: (DateTime day) {
        if (widget.type.category == 'lord_uzih') {
          return [2, 3, 5].contains(day.weekday);
        }
        return true; // Temple visits are every day
      },
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
      setState(() {
        _selectedDate = picked;
        _selectedTime = null; // Reset time when date changes
      });
    }
  }

  List<TimeOfDay> _getAvailableTimes(DateTime date) {
    final List<TimeOfDay> times = [];
    final day = date.weekday;
    int startHour = 10;
    int endHour = 16;

    if (widget.type.category == 'temple_visit') {
      if ([4, 6].contains(day)) {
        startHour = 7;
        endHour = 18;
      }
    } else if (widget.type.category == 'lord_uzih') {
      // Already restricted by date picker, but double check
      if (![2, 3, 5].contains(day)) return [];
    }

    for (int h = startHour; h < endHour; h++) {
      times.add(TimeOfDay(hour: h, minute: 0));
      times.add(TimeOfDay(hour: h, minute: 30));
    }
    if (widget.type.category == 'temple_visit' && [4, 6].contains(day)) {
        times.add(const TimeOfDay(hour: 18, minute: 0));
    } else {
        times.add(const TimeOfDay(hour: 16, minute: 0));
    }
    
    return times;
  }



  bool _isAvailable() {
    if (_selectedDate == null || _selectedTime == null) return true;
    
    final day = _selectedDate!.weekday; // 1-7 (Mon-Sun)
    final hour = _selectedTime!.hour;
    final minute = _selectedTime!.minute;
    final timeInt = hour * 100 + minute;

    if (widget.type.category == 'temple_visit') {
      if ([1, 2, 3, 5, 7].contains(day)) {
        return timeInt >= 1000 && timeInt <= 1600;
      } else if ([4, 6].contains(day)) {
        return timeInt >= 700 && timeInt <= 1800;
      }
    } else if (widget.type.category == 'lord_uzih') {
      if (![2, 3, 5].contains(day)) return false;
      return timeInt >= 1000 && timeInt <= 1600;
    }
    return true;
  }

  Future<void> _submit() async {
    if (_selectedDate == null || _selectedTime == null || _nameController.text.isEmpty || _emailController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill in all required fields.')));
      return;
    }

    if (!_isAvailable()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The selected time is not available for this appointment type.')));
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
      final response = await ref.read(bookingServiceProvider).createBooking(
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
              ],
            ),
            if (_selectedDate != null) ...[
              const SizedBox(height: 24),
              const Text(
                'Select Available Time',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _getAvailableTimes(_selectedDate!).map((time) {
                  final isSelected = _selectedTime == time;
                  return InkWell(
                    onTap: () => setState(() => _selectedTime = time),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Theme.of(context).colorScheme.primary : const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: isSelected ? Colors.transparent : Colors.white10),
                      ),
                      child: Text(
                        time.format(context),
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            if (widget.type.category == 'temple_visit')
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Visitors may not meet Lord Uzih the priest during temple visits.',
                          style: TextStyle(color: Colors.white70, fontSize: 13, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 24),
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
                  : Text(widget.type.price > 0 ? 'CONFIRM & PAY' : 'CONFIRM BOOKING', style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

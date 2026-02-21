import 'package:flutter/material.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/orders/models/order_model.dart';
import 'package:Watered/features/orders/models/order_form_field_model.dart';
import 'package:Watered/features/orders/services/order_application_service.dart';
import 'package:provider/provider.dart';

class ApplicationFormScreen extends StatefulWidget {
  final Order order;

  const ApplicationFormScreen({super.key, required this.order});

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<int, dynamic> _answers = {};
  bool _isSubmitting = false;

  late OrderApplicationService _orderService;

  @override
  void initState() {
    super.initState();
    _orderService = OrderApplicationService(context.read<ApiClient>());
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    setState(() => _isSubmitting = true);

    try {
      // Format answers for API: use labels or IDs as keys. 
      // The backend expects a JSON object. We'll use labels for readability in admin.
      final formattedAnswers = <String, dynamic>{};
      for (var field in widget.order.formFields!) {
        formattedAnswers[field.label] = _answers[field.id];
      }

      await _orderService.submitApplication(widget.order.id, formattedAnswers);

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Application Submitted'),
            content: const Text('Your application has been received successfully. You will be notified via email once reviewed.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // dialog
                  Navigator.of(context).pop(); // form screen
                  Navigator.of(context).pop(); // detail screen
                },
                child: const Text('Back to Orders'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Submission failed: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formFields = widget.order.formFields ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Apply: ${widget.order.title}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please provide the following information to begin your journey.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 24),
              ...formFields.map((field) => _buildField(field)).toList(),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator()
                      : const Text('Submit Application', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(OrderFormField field) {
    switch (field.fieldType) {
      case 'textarea':
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: field.label,
              hintText: field.placeholder,
              border: const OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            maxLines: 4,
            validator: field.isRequired ? (v) => v!.isEmpty ? 'Required' : null : null,
            onSaved: (v) => _answers[field.id] = v,
          ),
        );
      case 'select':
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: field.label,
              hintText: field.placeholder,
              border: const OutlineInputBorder(),
            ),
            items: field.options?.map((opt) => DropdownMenuItem(
              value: opt.value,
              child: Text(opt.label),
            )).toList(),
            validator: field.isRequired ? (v) => v == null ? 'Required' : null : null,
            onChanged: (v) => _answers[field.id] = v,
            onSaved: (v) => _answers[field.id] = v,
          ),
        );
      case 'checkbox':
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CheckboxListTile(
            title: Text(field.label),
            subtitle: field.placeholder != null ? Text(field.placeholder!) : null,
            value: _answers[field.id] ?? false,
            onChanged: (v) => setState(() => _answers[field.id] = v),
          ),
        );
      case 'email':
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: field.label,
              hintText: field.placeholder,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (field.isRequired && v!.isEmpty) return 'Required';
              if (v!.isNotEmpty && !v.contains('@')) return 'Invalid email';
              return null;
            },
            onSaved: (v) => _answers[field.id] = v,
          ),
        );
      default: // text, phone, etc
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: field.label,
              hintText: field.placeholder,
              border: const OutlineInputBorder(),
            ),
            keyboardType: field.fieldType == 'phone' ? TextInputType.phone : TextInputType.text,
            validator: field.isRequired ? (v) => v!.isEmpty ? 'Required' : null : null,
            onSaved: (v) => _answers[field.id] = v,
          ),
        );
    }
  }
}

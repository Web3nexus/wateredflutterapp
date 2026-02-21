class OrderFormField {
  final int id;
  final int orderId;
  final String label;
  final String fieldType; // text, textarea, email, phone, select, checkbox
  final String? placeholder;
  final List<OrderFormFieldOption>? options;
  final bool isRequired;
  final int sortOrder;

  OrderFormField({
    required this.id,
    required this.orderId,
    required this.label,
    required this.fieldType,
    this.placeholder,
    this.options,
    required this.isRequired,
    required this.sortOrder,
  });

  factory OrderFormField.fromJson(Map<String, dynamic> json) {
    return OrderFormField(
      id: json['id'],
      orderId: json['order_id'],
      label: json['label'],
      fieldType: json['field_type'],
      placeholder: json['placeholder'],
      options: json['options'] != null
          ? (json['options'] as List)
              .map((o) => OrderFormFieldOption.fromJson(o))
              .toList()
          : null,
      isRequired: json['is_required'] == 1 || json['is_required'] == true,
      sortOrder: json['sort_order'] ?? 0,
    );
  }
}

class OrderFormFieldOption {
  final String label;
  final String value;

  OrderFormFieldOption({required this.label, required this.value});

  factory OrderFormFieldOption.fromJson(Map<String, dynamic> json) {
    return OrderFormFieldOption(
      label: json['label'] ?? '',
      value: json['value'] ?? '',
    );
  }
}

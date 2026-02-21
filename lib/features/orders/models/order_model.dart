import 'package:Watered/features/orders/models/order_form_field_model.dart';

class Order {
  final int id;
  final String title;
  final String? description;
  final String status; // open, closed, invite_only
  final String ctaText;
  final String? ctaLink;
  final String actionType; // external_link, internal_route, application_form
  final String? imageUrl;
  final int orderLevel;
  final bool isActive;
  final List<OrderFormField>? formFields;

  Order({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.ctaText,
    this.ctaLink,
    required this.actionType,
    this.imageUrl,
    required this.orderLevel,
    required this.isActive,
    this.formFields,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'] ?? 'open',
      ctaText: json['cta_text'] ?? 'Apply Now',
      ctaLink: json['cta_link'],
      actionType: json['action_type'] ?? 'application_form',
      imageUrl: json['image_url'],
      orderLevel: json['order_level'] ?? 1,
      isActive: json['is_active'] == 1 || json['is_active'] == true,
      formFields: json['form_fields'] != null
          ? (json['form_fields'] as List)
              .map((f) => OrderFormField.fromJson(f))
              .toList()
          : null,
    );
  }
}

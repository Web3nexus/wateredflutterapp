import 'package:Watered/features/orders/models/order_model.dart';

class OrderApplication {
  final int id;
  final int orderId;
  final int userId;
  final Map<String, dynamic> answers;
  final String status; // pending, approved, rejected
  final String? adminNotes;
  final DateTime submittedAt;
  final Order? order;

  OrderApplication({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.answers,
    required this.status,
    this.adminNotes,
    required this.submittedAt,
    this.order,
  });

  factory OrderApplication.fromJson(Map<String, dynamic> json) {
    return OrderApplication(
      id: json['id'],
      orderId: json['order_id'],
      userId: json['user_id'],
      answers: json['answers'] ?? {},
      status: json['status'] ?? 'pending',
      adminNotes: json['admin_notes'],
      submittedAt: DateTime.parse(json['submitted_at']),
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
    );
  }
}

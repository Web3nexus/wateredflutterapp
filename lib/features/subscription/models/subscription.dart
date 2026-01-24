class Subscription {
  final int? id;
  final String? planId;
  final String? status;
  final DateTime? startsAt;
  final DateTime? expiresAt;
  final bool isPremium;

  Subscription({
    this.id,
    this.planId,
    this.status,
    this.startsAt,
    this.expiresAt,
    this.isPremium = false,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    final sub = json['subscription'];
    final bool isPremium = json['is_premium'] ?? false;
    
    if (sub == null) {
      return Subscription(isPremium: isPremium);
    }

    return Subscription(
      id: sub['id'],
      planId: sub['plan_id'],
      status: sub['status'],
      startsAt: sub['starts_at'] != null ? DateTime.parse(sub['starts_at']) : null,
      expiresAt: sub['expires_at'] != null ? DateTime.parse(sub['expires_at']) : null,
      isPremium: isPremium,
    );
  }
}

class RechargePlanModel {
  final String? planId;
  final String? planName;
  final String? amount;
  final String? coins;
  final String? description;

  RechargePlanModel({
    this.planId,
    this.planName,
    this.amount,
    this.coins,
    this.description,
  });

  factory RechargePlanModel.fromJson(Map<String, dynamic> json) {
    return RechargePlanModel(
      planId: json['plan_id']?.toString() ?? json['id']?.toString(),
      planName: json['plan_name']?.toString() ?? json['title']?.toString(),
      amount: json['amount']?.toString() ?? json['price']?.toString(),
      coins: json['coins']?.toString(),
      description: json['description']?.toString(),
    );
  }
}

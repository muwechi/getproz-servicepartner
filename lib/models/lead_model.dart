class LeadModel {
  final String? bookingId;
  final String? categoryName;
  final String? serviceName;
  final String? price;
  final String? coins;
  final String? status;
  final String? date;
  final String? time;
  final String? userName;
  final String? userPhone;
  final String? address;

  LeadModel({
    this.bookingId,
    this.categoryName,
    this.serviceName,
    this.price,
    this.coins,
    this.status,
    this.date,
    this.time,
    this.userName,
    this.userPhone,
    this.address,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      bookingId: json['booking_id']?.toString() ?? json['id']?.toString(),
      categoryName: json['category_name']?.toString() ?? json['cat_name']?.toString(),
      serviceName: json['service_name']?.toString() ?? json['title']?.toString(),
      price: json['price']?.toString() ?? json['total_price']?.toString(),
      coins: json['coins']?.toString() ?? json['coins_required']?.toString(),
      status: json['status']?.toString(),
      date: json['date']?.toString() ?? json['booking_date']?.toString(),
      time: json['time']?.toString() ?? json['booking_time']?.toString(),
      userName: json['user_name']?.toString(),
      userPhone: json['user_phone']?.toString() ?? json['user_mobile']?.toString(),
      address: json['address']?.toString(),
    );
  }
}

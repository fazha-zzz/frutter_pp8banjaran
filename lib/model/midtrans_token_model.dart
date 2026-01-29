class MidtransTokenModel {
  final String snapToken;
  final String orderId;
  final int total;

  MidtransTokenModel({
    required this.snapToken,
     required this.orderId,
    required this.total,
  });

  factory MidtransTokenModel.fromJson(Map<String, dynamic> json) {
    return MidtransTokenModel(
      snapToken: json['snap_token'],
      orderId: json['data']['order_id'],
      total: json['data']['total'],
    );
  }
}

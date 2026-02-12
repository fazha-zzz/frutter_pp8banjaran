class MidtransTokenModel {
  final String snapToken; // WAJIB
  final String? orderId; // ⬅️ nullable
  final int total;
  final int denda;
  final int totalFinal;

  MidtransTokenModel({
    required this.snapToken,
    this.orderId,
    required this.total,
    required this.denda,
    required this.totalFinal,
  });

  factory MidtransTokenModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return MidtransTokenModel(
      snapToken: data['snap_token'], // WAJIB ADA
      orderId: data['order_id'], // BOLEH NULL
      total: data['total'] ?? 0,
      denda: data['denda'] ?? 0,
      totalFinal: (data['total'] ?? 0) + (data['denda'] ?? 0),
    );
  }
}

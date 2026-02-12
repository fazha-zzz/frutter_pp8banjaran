class RiwayatModel {
  final int id;
  final int total;
  final String status;
  final DateTime tanggal;
  final int denda;

  RiwayatModel({
    required this.id,
    required this.total,
    required this.status,
    required this.tanggal,
    this.denda = 0,
  });

  factory RiwayatModel.fromJson(Map<String, dynamic> json) {
    return RiwayatModel(
      id: json['id'],
      total: json['total'],
      status: json['status'],
      tanggal: DateTime.parse(json['tanggal']),
      denda: json['denda'] ?? 0,
    );
  }
}

class SaranModel {
  final int id;
  final String isi;
  final DateTime createdAt;

  SaranModel({
    required this.id,
    required this.isi,
    required this.createdAt,
  });

  factory SaranModel.fromJson(Map<String, dynamic> json) {
    return SaranModel(
      id: json['id'],
      isi: json['isi'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

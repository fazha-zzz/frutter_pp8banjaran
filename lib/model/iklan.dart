class IklanModel {
  final int id;
  final String judul;
  final String deskripsi;
  final String gambar;

  IklanModel({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.gambar,
  });

  factory IklanModel.fromJson(Map<String, dynamic> json) {
    return IklanModel(
      id: json['id'],
      judul: json['judul'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      gambar: json['gambar'] ?? '',
    );
  }
}

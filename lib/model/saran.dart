class Saran {
  final int id;
  final String isi;
  final String createdAt;
  final String? balasan;
  final List<Attachment> attachments;

  Saran({
    required this.id,
    required this.isi,
    required this.createdAt,
    this.balasan,
    required this.attachments,
  });

  factory Saran.fromJson(Map<String, dynamic> json) {
    return Saran(
      id: json['id'],
      isi: json['isi'],
      createdAt: json['created_at'],
      balasan: json['balasan'],
      attachments: json['attachments'] == null
          ? []
          : List<Attachment>.from(
              json['attachments'].map((x) => Attachment.fromJson(x)),
            ),
    );
  }

  List<Attachment> get userFiles =>
      attachments.where((e) => e.type != 'admin').toList();

  List<Attachment> get adminFiles =>
      attachments.where((e) => e.type == 'admin').toList();
}

class Attachment {
  final String fileName;
  final String filePath;
  final String type;

  Attachment({
    required this.fileName,
    required this.filePath,
    required this.type,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      fileName: json['file_name'],
      filePath: json['file_path'],
      type: json['type'],
    );
  }

  String get fullUrl => 'http://127.0.0.1:8000/storage/$filePath';
}

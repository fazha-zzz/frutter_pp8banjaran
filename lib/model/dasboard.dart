class DashboardModel {
  List<Pengumuman>? pengumuman;
  Tagihan? tagihan;
  List<Rekening>? rekenings;
  String? totalPembayaran;
  List<Iklan>? iklans;

  DashboardModel({
    this.pengumuman,
    this.tagihan,
    this.rekenings,
    this.totalPembayaran,
    this.iklans,
  });

  static Future<DashboardModel?> fromJson(jsonData) async {}
}

class Iklan {
  int? id;
  int? idUser;
  String? judul;
  String? deskripsi;
  String? gambar;
  DateTime? createdAt;
  DateTime? updatedAt;

  Iklan({
    this.id,
    this.idUser,
    this.judul,
    this.deskripsi,
    this.gambar,
    this.createdAt,
    this.updatedAt,
  });
}

class Pengumuman {
  int? id;
  String? judul;
  String? isi;
  DateTime? tanggal;
  String? gambar;
  DateTime? createdAt;
  DateTime? updatedAt;

  Pengumuman({
    this.id,
    this.judul,
    this.isi,
    this.tanggal,
    this.gambar,
    this.createdAt,
    this.updatedAt,
  });
}

class Rekening {
  int? id;
  String? bankName;
  String? number;
  DateTime? createdAt;
  DateTime? updatedAt;

  Rekening({
    this.id,
    this.bankName,
    this.number,
    this.createdAt,
    this.updatedAt,
  });
}

class Tagihan {
  int? id;
  int? idUser;
  int? keamanan;
  int? kebersihan;
  DateTime? tanggal;
  dynamic tanggalTagih;
  DateTime? tanggalJatuhTempo;
  String? status;
  dynamic dibayarId;
  int? total;
  DateTime? createdAt;
  DateTime? updatedAt;

  Tagihan({
    this.id,
    this.idUser,
    this.keamanan,
    this.kebersihan,
    this.tanggal,
    this.tanggalTagih,
    this.tanggalJatuhTempo,
    this.status,
    this.dibayarId,
    this.total,
    this.createdAt,
    this.updatedAt,
  });
}

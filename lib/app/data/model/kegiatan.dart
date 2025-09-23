class KegiatanModel {
  bool? success;
  String? message;
  Data? data;

  KegiatanModel({this.success, this.message, this.data});

  static Future<KegiatanModel?> fromJson(jsonData) async {}
}

class Data {
  int? currentPage;
  List<Kegiatan>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });
}

class Kegiatan {
  int? id;
  String? namaKegiatan;
  String? deskripsi;
  String? lokasi;
  String? gambar;
  DateTime? tanggal;
  DateTime? createdAt;
  DateTime? updatedAt;

  Kegiatan({
    this.id,
    this.namaKegiatan,
    this.deskripsi,
    this.lokasi,
    this.gambar,
    this.tanggal,
    this.createdAt,
    this.updatedAt,
  });
}

class Link {
  String? url;
  String? label;
  int? page;
  bool? active;

  Link({this.url, this.label, this.page, this.active});
}

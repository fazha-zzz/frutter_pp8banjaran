class KegiatanModel {
  bool? success;
  String? message;
  Data? data;

  KegiatanModel({this.success, this.message, this.data});

  factory KegiatanModel.fromJson(Map<String, dynamic> json) {
    return KegiatanModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
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

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      currentPage: json['current_page'],
      data: json['data'] != null
          ? List<Kegiatan>.from(json['data'].map((x) => Kegiatan.fromJson(x)))
          : [],
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: json['links'] != null
          ? List<Link>.from(json['links'].map((x) => Link.fromJson(x)))
          : [],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

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

  factory Kegiatan.fromJson(Map<String, dynamic> json) {
    return Kegiatan(
      id: json['id'],
      namaKegiatan: json['nama_kegiatan'],
      deskripsi: json['deskripsi'],
      lokasi: json['lokasi'],
      gambar: json['gambar'],
      tanggal: json['tanggal'] != null ? DateTime.parse(json['tanggal']) : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

class Link {
  String? url;
  String? label;
  int? page;
  bool? active;

  Link({this.url, this.label, this.page, this.active});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'],
      page: json['page'],
      active: json['active'],
    );
  }
}

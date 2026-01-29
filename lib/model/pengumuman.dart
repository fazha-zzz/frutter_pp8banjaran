class PengumumanModel {
  bool? success;
  String? message;
  Data? data;

  PengumumanModel({
    this.success,
    this.message,
    this.data,
  });

  factory PengumumanModel.fromJson(Map<String, dynamic> json) {
    return PengumumanModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? Data.fromJson(json['data'])
          : null,
    );
  }
}

class Data {
  int? currentPage;
  List<Pengumuman>? data;
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
          ? List<Pengumuman>.from(
              json['data'].map((x) => Pengumuman.fromJson(x)),)
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

  factory Pengumuman.fromJson(Map<String, dynamic> json) {
    return Pengumuman(
      id: json['id'],
      judul: json['judul'],
      isi: json['isi'],
      tanggal: json['tanggal'] != null ? DateTime.parse(json['tanggal']) : null,
      gambar: json['gambar'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
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

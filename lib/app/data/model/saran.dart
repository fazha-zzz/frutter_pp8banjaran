class SaranModel {
  bool? success;
  String? message;
  List<Saran>? data;

  SaranModel({this.success, this.message, this.data});

  factory SaranModel.fromJson(Map<String, dynamic> json) {
    return SaranModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? List<Saran>.from(json['data'].map((x) => Saran.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}

class Saran {
  int? id;
  int? idUser;
  String? isi;
  DateTime? createdAt;
  DateTime? updatedAt;

  Saran({this.id, this.idUser, this.isi, this.createdAt, this.updatedAt});

  factory Saran.fromJson(Map<String, dynamic> json) {
    return Saran(
      id: json['id'],
      idUser: json['id_user'],
      isi: json['isi'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_user': idUser,
      'isi': isi,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

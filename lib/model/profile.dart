class profileModel {
  bool? success;
  String? message;
  Data? data;

  profileModel({this.success, this.message, this.data});

  profileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? createdAt;
  int? iklanCount;
  int? kritikCount;

  Data({
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.iklanCount,
    this.kritikCount,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    createdAt = json['created_at'];
    iklanCount = json['iklan_count'];
    kritikCount = json['kritik_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['iklan_count'] = this.iklanCount;
    data['kritik_count'] = this.kritikCount;
    return data;
  }
}

class DashboardModel {
  final dynamic tagihan;
  final List pengumuman;
  final List iklans;
  final int totalDibayar;

  DashboardModel({
    required this.tagihan,
    required this.pengumuman,
    required this.iklans,
    required this.totalDibayar,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      tagihan: json['tagihan'],
      pengumuman: json['pengumuman'] ?? [],
      iklans: json['iklans'] ?? [],
      totalDibayar: json['total_dibayar'] ?? 0,
    );
  }
}

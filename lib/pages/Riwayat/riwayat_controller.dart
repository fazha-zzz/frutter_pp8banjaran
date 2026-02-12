import 'package:get/get.dart';
import '../../model/riwayat.dart';
import '../../services/riwayat_services.dart';

class RiwayatController extends GetxController {
  var tunggakan = <RiwayatModel>[].obs;
  var histori = <RiwayatModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPembayaran();
  }

  void fetchPembayaran() async {
    try {
      isLoading(true);

      final data = await RiwayatServices.fetchPembayaran();

      print('📊 Data RAW dari API: $data');

      tunggakan.value = (data['tunggakan'] as List)
          .map((e) => RiwayatModel.fromJson(e))
          .toList();

      histori.value = (data['histori'] as List)
          .map((e) => RiwayatModel.fromJson(e))
          .toList();

      print('✅ Tunggakan: ${tunggakan.length}');
      print('✅ Histori: ${histori.length}');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// Optional: reload setelah bayar semua
  void reload() => fetchPembayaran();
}

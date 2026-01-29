import 'package:get/get.dart';
import '../../model/riwayat.dart';
import '../../services/riwayat_services.dart';

class RiwayatController extends GetxController {
  var tunggakan = <RiwayatModel>[].obs;
  var histori = <RiwayatModel>[].obs;
  var isLoading = false.obs;

  get riwayatList => null;

  @override
  void onInit() {
    fetchPembayaran();
    super.onInit();
  }

  void fetchPembayaran() async {
    try {
      isLoading(true);

      final data = await RiwayatServices.fetchPembayaran();

      tunggakan.value = (data['tunggakan'] as List)
          .map((e) => RiwayatModel.fromJson(e))
          .toList();

      histori.value = (data['histori'] as List)
          .map((e) => RiwayatModel.fromJson(e))
          .toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}

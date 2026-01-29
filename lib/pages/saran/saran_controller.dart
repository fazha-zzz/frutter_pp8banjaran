import 'package:get/get.dart';
import '../../model/saran.dart';
import '../../services/saran_services.dart';

class SaranController extends GetxController {
  var isLoading = false.obs;
  var saranList = <SaranModel>[].obs;

  @override
  void onInit() {
    fetchSaran();
    super.onInit();
  }

  void fetchSaran() async {
    try {
      isLoading.value = true;
      saranList.value = await SaranService.fetchSaran();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> kirim(String isi) async {
    await SaranService.kirimSaran(isi);
    fetchSaran();
  }
}

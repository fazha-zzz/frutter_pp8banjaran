import 'package:get/get.dart';
import '../../model/riwayat.dart';
import '../../services/riwayat_services.dart';

class RiwayatController extends GetxController {
  var isLoading = true.obs;
  var riwayatList = <RiwayatModel>[].obs;

  @override
  void onInit() {
    fetchRiwayat();
    super.onInit();
  }

  void fetchRiwayat() async {
    try {
      isLoading(true);
      riwayatList.value = await RiwayatServices.fetchRiwayat();
    } finally {
      isLoading(false);
    }
  }
}

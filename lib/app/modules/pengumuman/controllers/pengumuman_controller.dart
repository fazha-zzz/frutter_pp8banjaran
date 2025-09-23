import 'package:get/get.dart';
import 'package:pp8banjaran/app/data/model/pengumuman.dart';
import 'package:pp8banjaran/app/services/pengumuman_services.dart';


class PengumumanController extends GetxController {
  var isLoading = false.obs;
  var pengumumanList = <Datum>[].obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;

  final PengumumanService _service = PengumumanService();

  @override
  void onInit() {
    super.onInit();
    fetchPengumuman();
  }

  Future<void> fetchPengumuman({int page = 1}) async {
    try {
      isLoading.value = true;
      final result = await _service.getPengumuman(page: page);

      if (result != null && result.data != null) {
        pengumumanList.value = result.data!.data ?? [];
        currentPage.value = result.data!.currentPage ?? 1;
        lastPage.value = result.data!.lastPage ?? 1;
      }
    } finally {
      isLoading.value = false;
    }
  }

  void nextPage() {
    if (currentPage.value < lastPage.value) {
      fetchPengumuman(page: currentPage.value + 1);
    }
  }

  void prevPage() {
    if (currentPage.value > 1) {
      fetchPengumuman(page: currentPage.value - 1);
    }
  }
}

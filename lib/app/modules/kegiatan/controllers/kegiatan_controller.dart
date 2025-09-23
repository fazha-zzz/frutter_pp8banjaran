import 'package:get/get.dart';
import 'package:pp8banjaran/app/data/model/kegiatan.dart';
import 'package:pp8banjaran/app/services/kegiatan_services.dart';


class KegiatanController extends GetxController {
  var isLoading = false.obs;
  var kegiatanList = <Kegiatan>[].obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;

  final KegiatanService _service = KegiatanService();

  @override
  void onInit() {
    super.onInit();
    fetchKegiatan();
  }

  Future<void> fetchKegiatan({int page = 1}) async {
    try {
      isLoading.value = true;
      final result = await _service.getKegiatan(page: page);

      if (result != null && result.data != null) {
        kegiatanList.value = result.data!.data ?? [];
        currentPage.value = result.data!.currentPage ?? 1;
        lastPage.value = result.data!.lastPage ?? 1;
      }
    } finally {
      isLoading.value = false;
    }
  }

  void nextPage() {
    if (currentPage.value < lastPage.value) {
      fetchKegiatan(page: currentPage.value + 1);
    }
  }

  void prevPage() {
    if (currentPage.value > 1) {
      fetchKegiatan(page: currentPage.value - 1);
    }
  }
}

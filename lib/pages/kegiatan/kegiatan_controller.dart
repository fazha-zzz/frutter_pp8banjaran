import 'package:get/get.dart';
import '../../model/kegiatan.dart';
import '../../services/kegiatan_services.dart';

class KegiatanController extends GetxController {
  final KegiatanService _service = KegiatanService();

  var isLoading = false.obs;
  var kegiatanList = <Kegiatan>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchKegiatan();
  }
  Future<void> fetchKegiatan() async {
    try {
      isLoading(true);

      final result = await _service.fetchKegiatan();
      if (result != null &&
          result.success == true &&
          result.data?.data != null) {
        kegiatanList.assignAll(result.data!.data!);

      } else {
        kegiatanList.clear();
      }
    } finally {
      isLoading(false);
    }
  }
}

import 'package:get/get.dart';
import '../../model/pengumuman.dart';
import '../../services/pengumuman_services.dart';

class PengumumanController extends GetxController {
  final PengumumanService _service = PengumumanService();

  var isLoading = false.obs;
  var pengumumanList = <Pengumuman>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchpengumuman();
  }

  Future<void> fetchpengumuman() async {
    print('TOTAL pengumuman: ${pengumumanList.length}');

    try {
      isLoading(true);

      final result = await _service.fetchPengumuman();

      print('SUCCESS: ${result?.success}');
      print('DATA RAW: ${result?.data?.data}');

      if (result != null &&
          result.success == true &&
          result.data?.data != null) {
        pengumumanList.assignAll(result.data!.data!);

        print('TOTAL pengumuman: ${pengumumanList.length}');
      } else {
        pengumumanList.clear();
      }
    } finally {
      isLoading(false);
    }
  }
}

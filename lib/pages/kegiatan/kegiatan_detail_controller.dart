import 'package:get/get.dart';
import '../../model/kegiatan.dart';
import '../../services/kegiatan_services.dart';

class KegiatanDetailController extends GetxController {
  final KegiatanService _service = KegiatanService();

  var isLoading = false.obs;
  var kegiatan = Rxn<Kegiatan>();

  void fetchDetail(int id) async {
    try {
      isLoading(true);
      final result = await _service.fetchDetail(id);
      kegiatan.value = result;
    } finally {
      isLoading(false);
    }
  }
}

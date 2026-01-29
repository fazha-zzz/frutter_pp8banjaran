import 'package:get/get.dart';
import '../../model/Pengumuman.dart';
import '../../services/Pengumuman_services.dart';

class PengumumanDetailController extends GetxController {
  final PengumumanService _service = PengumumanService();

  var isLoading = false.obs;
  var pengumuman = Rxn<Pengumuman>();

  void fetchPengumumanDetail(int id) async {
    try {
      isLoading(true);
      final result = await _service.fetchPengumumanDetail(id);
      pengumuman.value = result as Pengumuman?;
    } finally {
      isLoading(false);
    }
  }
}

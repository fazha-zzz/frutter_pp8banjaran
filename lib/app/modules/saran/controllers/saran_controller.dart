import 'package:get/get.dart';
import 'package:pp8banjaran/app/data/model/saran.dart';
import 'package:pp8banjaran/app/services/saran_services.dart';


class SaranController extends GetxController {
  var isLoading = false.obs;
  var saranList = <Saran>[].obs;

  final SaranService _saranService = SaranService();

  /// Ambil semua saran
  Future<void> fetchSaran() async {
    isLoading.value = true;
    final result = await _saranService.getAllSaran();
    if (result != null && result.data != null) {
      saranList.assignAll(result.data!);
    }
    isLoading.value = false;
  }

  /// Tambah saran baru
  Future<bool> addSaran(int idUser, String isi) async {
    isLoading.value = true;
    final success = await _saranService.createSaran(idUser, isi);
    if (success) {
      await fetchSaran(); // refresh list setelah tambah
    }
    isLoading.value = false;
    return success;
  }
}

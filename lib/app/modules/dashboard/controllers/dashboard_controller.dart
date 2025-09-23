import 'dart:io';
import 'package:get/get.dart';
import 'package:pp8banjaran/app/services/dashboart_services.dart';


class PembayaranController extends GetxController {
  var isLoading = false.obs;
  final PembayaranService _service = PembayaranService();

  Future<void> createPembayaran(
    int idTagihan,
    int rekeningId,
    File? bukti,
  ) async {
    isLoading.value = true;
    final success = await _service.createPembayaran(
      idTagihan: idTagihan,
      rekeningId: rekeningId,
      buktiPembayaran: bukti,
    );

    if (success) {
      Get.snackbar("Sukses", "Bukti pembayaran berhasil dikirim.");
    } else {
      Get.snackbar("Error", "Gagal mengirim pembayaran.");
    }

    isLoading.value = false;
  }
}

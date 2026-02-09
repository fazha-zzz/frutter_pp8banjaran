import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import '../../model/saran.dart';
import '../../services/saran_services.dart';
import 'package:file_picker/file_picker.dart';

class SaranController extends GetxController {
  var files = <PlatformFile>[].obs;
  var list = <Saran>[].obs;
  var isLoading = false.obs;



  /// ✅ SIMPAN DI SINI
  Future<void> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true, // WAJIB UNTUK WEB
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'pdf',
        'doc',
        'docx',
        'xls',
        'xlsx',
        'zip',
      ],
    );

    if (result != null) {
      files.assignAll(result.files);
    }
  }

 Future<void> kirimSaran(String isi) async {
    try {
      await SaranService.kirimSaran(
        isi,
        files, // ⬅️ KIRIM PlatformFile LANGSUNG
      );

      files.clear();
      await fetchData();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengirim saran');
    }
  }

@override
  void onInit() {
    super.onInit();
    fetchData(); // ⬅️ otomatis ambil data saat halaman dibuka
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final data = await SaranService.fetchSaran();
      list.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }
}

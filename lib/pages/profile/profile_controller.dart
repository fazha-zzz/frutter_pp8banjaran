import 'package:get/get.dart';
import 'package:pp8banjaran/services/profile_services.dart';
import '../../model/profile.dart';
import '../../services/auth_services.dart';


class ProfileController extends GetxController {
  final ProfileService _profileService = ProfileService();
  final AuthService _authService = AuthService();

  var isLoading = false.obs;
  var profile = Rxn<profileModel>();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {

    
    try {

      
      isLoading(true);

      final result = await _profileService.fetchProfile();

      if (result != null && result.success == true) {
        profile.value = result;
      } else {
        Get.snackbar('Error', 'Gagal memuat data profile');
      }
    } finally {
      isLoading(false);
    }
    
  }

  Future<void> logout() async {
    _authService.logout();
    Get.offAllNamed('/login');
  }
}

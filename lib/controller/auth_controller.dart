import 'package:flutter_application_1/views/customs/custom_snackbar.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final AuthService _authService = Get.find<AuthService>();
  var isAuthenticated = false.obs;

  var email = ''.obs;
  var password = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await checkAuthStatus(); // Check authentication on app start
  }

  bool hasAuthenticated() {
    bool hasAuth = isAuthenticated.value;
    return hasAuth;
  }

  Future<void> checkAuthStatus() async {
    String? token = await _authService.getToken();
    print("Check token is = ${token != null} \n $token");
    isAuthenticated.value = token != null; // Update reactive state
  }

  Future<void> signIn() async {
    isLoading(true);
    bool success = await _authService.login(email.value, password.value);
    clearText();
    isLoading(false);

    if (success) {
      CustomSnackbar.showSuccess(
          title: "Successfully.", description: "SignIn successfully.");
      Get.offAllNamed('/home');
    } else {
      CustomSnackbar.showError(
          title: "SignIn failed", description: "Incorrect email or password.");
    }
  }

  Future<void> signUp() async {
    isLoading(true);
    bool success = await _authService.signUp(email.value, password.value);
    isLoading(false);

    if (success) {
      Get.offAllNamed('/signin');
    } else {
      Get.snackbar("Error", "Signup failed");
    }
  }

  Future<void> signOut() async {
    _authService.logout().then((_) {
      isAuthenticated.value = false; // Update state after logout
      Get.offAllNamed('/signin'); // Navigate to sign-in page
    });
  }

  Future<void> clearText() async {
    email.value = '';
    password.value = '';
  }
}

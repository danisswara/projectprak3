import 'package:get/get.dart';
import 'package:quick_note/modules/login/controllers/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    // Menggunakan Get.lazyPut untuk menginisialisasi LoginController secara lazy
    Get.lazyPut(() => LoginController());
  }
}

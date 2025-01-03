import 'package:get/get.dart';
import 'package:quick_note/modules/register/controllers/register_controller.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}

import 'package:get/get.dart';
import 'package:lilac_flutter_machine_test/business_logic/auth/controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}

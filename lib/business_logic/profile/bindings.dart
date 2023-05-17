import 'package:get/get.dart';
import 'package:lilac_flutter_machine_test/business_logic/profile/controller.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

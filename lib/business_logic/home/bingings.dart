import 'package:get/get.dart';
import 'package:lilac_flutter_machine_test/business_logic/home/controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

import 'package:get/get.dart';
import 'package:lilac_flutter_machine_test/business_logic/home/bingings.dart';
import 'package:lilac_flutter_machine_test/presentation/home/home_page.dart';
import 'package:lilac_flutter_machine_test/routes/route_names.dart';

class AppPages {
  static List<GetPage<dynamic>> getPages = [
    // HomePage
    GetPage(
      name: AppRouteNames.initial,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}

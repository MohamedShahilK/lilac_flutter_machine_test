import 'package:get/get.dart';
import 'package:lilac_flutter_machine_test/business_logic/auth/binding.dart';
import 'package:lilac_flutter_machine_test/business_logic/home/bingings.dart';
import 'package:lilac_flutter_machine_test/middleware/redirecting.dart';
import 'package:lilac_flutter_machine_test/presentation/auth/login.dart';
import 'package:lilac_flutter_machine_test/presentation/home/home_page.dart';
import 'package:lilac_flutter_machine_test/routes/route_names.dart';

class AppPages {
  static List<GetPage<dynamic>> getPages = [
    // HomePage
    GetPage(
      name: AppRouteNames.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),

    // Login Page
    GetPage(
      name: AppRouteNames.initial,
      page: () => const AuthPage(),
      binding: AuthBindings(),
      middlewares: [RedirectingMiddleWare(priority: 1)],
    ),
  ];
}

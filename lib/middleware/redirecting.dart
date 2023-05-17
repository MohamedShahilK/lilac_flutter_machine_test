// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';

import 'package:lilac_flutter_machine_test/routes/route_names.dart';

class RedirectingMiddleWare extends GetMiddleware {
  @override
  int? priority = 1;
  RedirectingMiddleWare({
   required this.priority,
  });
  @override
  RouteSettings? redirect(String? route) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const RouteSettings(name: AppRouteNames.initial);
    } else {
      return const RouteSettings(name: AppRouteNames.home);
    }
  }
}

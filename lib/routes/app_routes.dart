import 'package:get/get.dart';

import '../bindings/auth_binding.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => HomeScreen(),
      binding: AuthBinding(),
    ),
  ];
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes.dart';
import 'app/theme.dart';
import 'bindings/initial-binding.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppRoute.routes,
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      theme: AppTheme.theme,
    );
  }
}

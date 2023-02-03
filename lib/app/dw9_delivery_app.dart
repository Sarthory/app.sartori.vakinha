import 'package:dw9_delivery_app/app/core/providers/application_binding.dart';
import 'package:dw9_delivery_app/app/core/ui/theme/theme_config.dart';
import 'package:dw9_delivery_app/app/pages/auth/login/login_router.dart';
import 'package:dw9_delivery_app/app/pages/auth/register/register_router.dart';
import 'package:dw9_delivery_app/app/pages/bag_items/bag_items_page.dart';
import 'package:dw9_delivery_app/app/pages/home/home_router.dart';
import 'package:dw9_delivery_app/app/pages/product_detail/product_detail_router.dart';
import 'package:dw9_delivery_app/app/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

class Dw9DeliveryApp extends StatelessWidget {
  const Dw9DeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
          title: "Vakinha Burger",
          theme: ThemeConfig.theme,
          routes: {
            '/': (context) => const SplashPage(),
            '/home': (context) => HomeRouter.page,
            '/productDetail': (context) => ProductDetailRouter.page,
            '/login': (context) => LoginRouter.page,
            '/register': (context) => RegisterRouter.page,
            '/bagItems': (context) => BagItemsPage()
          }),
    );
  }
}
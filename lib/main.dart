import 'package:bot_toast/bot_toast.dart';
import 'package:demo_list_getx/core/binding/app_binding.dart';
import 'package:demo_list_getx/core/binding/auth_binding.dart';
import 'package:demo_list_getx/core/binding/create_product_binding.dart';
import 'package:demo_list_getx/presentation/product_detail/product_detail_screen.dart';
import 'package:demo_list_getx/presentation/create_product/create_product_screen.dart';
import 'package:demo_list_getx/presentation/screens/home/home_screen.dart';
import 'package:demo_list_getx/presentation/screens/login/login_screen.dart';
import 'package:demo_list_getx/presentation/screens/splash/splash_screen.dart';
import 'package:demo_list_getx/presentation/update_product/update_product_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/binding/home_binding.dart';
import 'core/binding/product_detail_binding.dart';
import 'core/binding/update_product_binding.dart';
import 'core/navigation/navigation_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  final app = await Firebase.initializeApp();
  debugPrint('Firebase App: ${app.options.projectId}');
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('vi')],
      path: 'assets/translations',
      fallbackLocale: const Locale('vi'),
      startLocale: const Locale('vi'),
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();

    return GetMaterialApp(
      title: 'App Demo',
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      initialRoute: NavigationService.splash,
      initialBinding: AppBinding(),
      getPages: [
        GetPage(name: NavigationService.splash, page: () => const SplashScreen()),
        GetPage(
          name: NavigationService.login,
          page: () => const LoginScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: NavigationService.home,
          page: () => const HomeScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: NavigationService.productDetail,
          page: () => const ProductDetailScreen(),
          binding: ProductDetailBinding(),
        ),
        GetPage(
          name: NavigationService.createProduct,
          page: () => const CreateProductScreen(),
          binding: CreateProductBinding(),
        ),
        GetPage(
          name: NavigationService.updateProduct,
          page: () => const UpdateProductScreen(),
          binding: UpdateProductBinding(),
        ),
      ],
      builder: (context, child) {
        child = botToastBuilder(context, child);
        return child;
      },
      navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}

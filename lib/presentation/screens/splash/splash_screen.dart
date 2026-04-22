import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/navigation/navigation_service.dart';
import '../../../core/styles/app_colors.dart';
import '../../../data/sources/local/secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final token = await SecureStorage.getAccessToken();
    if (!mounted) return;

    if (token == null || token.isEmpty) {
    } else {
      Get.offAllNamed(NavigationService.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: Center(child: FlutterLogo(size: 120)),
    );
  }
}

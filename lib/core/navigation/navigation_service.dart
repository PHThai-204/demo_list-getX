import 'package:flutter/cupertino.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const splash = '/splash';
  static const login = '/login';
  static const home = '/home';
}

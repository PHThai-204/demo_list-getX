import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppThemes {
  static OutlineInputBorder inputDefault = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.lightGrey),
    borderRadius: BorderRadius.circular(6),
  );

  static OutlineInputBorder inputFocused = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.darkOrange),
    borderRadius: BorderRadius.circular(6),
  );
}
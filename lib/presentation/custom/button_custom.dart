import 'package:flutter/cupertino.dart';

import '../../core/styles/app_colors.dart';
import '../../core/styles/app_text_styles.dart';


class ButtonCustom extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final BoxDecoration? buttonStyle;
  final TextStyle? textStyle;
  final Widget? icon;

  const ButtonCustom({
    super.key,
    required this.title,
    required this.onPressed,
    this.buttonStyle,
    this.textStyle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration:
            buttonStyle ??
            BoxDecoration(color: AppColors.darkOrange, borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 8)],
            Text(
              title,
              style: textStyle ?? AppTextStyles.style.s16.w600.whiteColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

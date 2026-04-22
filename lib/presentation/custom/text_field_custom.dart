import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/styles/app_colors.dart';
import '../../core/styles/app_text_styles.dart';
import '../../core/styles/app_themes.dart';

class TextFieldCustom extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final String hintText;
  final String? labelText;
  final String errorText;
  final FocusNode? focusNode;
  final bool alwaysShowSuffix;
  final Widget? suffix;
  final bool isPasswordField;
  final Function(String) onChanged;
  final ValueChanged<String>? onSubmitted;
  final Function()? onClickSuffix;
  final Iterable<String>? autofillHints;
  final AnimationController animation;
  final Animation<double> offset;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;

  const TextFieldCustom({
    super.key,
    this.controller,
    this.initialValue,
    required this.hintText,
    this.labelText,
    required this.errorText,
    this.focusNode,
    this.suffix,
    required this.onChanged,
    this.onSubmitted,
    this.onClickSuffix,
    this.inputType,
    this.textInputAction,
    this.alwaysShowSuffix = false,
    this.isPasswordField = false,
    this.autofillHints = const <String>[],
    required this.animation,
    required this.offset,
    this.inputFormatters,
    this.maxLines = 1,
  });

  @override
  State<StatefulWidget> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> with SingleTickerProviderStateMixin {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textEditingController = widget.controller ?? TextEditingController(text: widget.initialValue ?? '');
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(widget.labelText!, style: AppTextStyles.style.w700.s16.darkGrayColor),
        ],
        SizedBox(height: 8),
        AnimatedBuilder(
          animation: widget.offset,
          builder: (context, child) {
            return Transform.translate(offset: Offset(widget.offset.value, 0), child: child);
          },
          child: TextField(
            controller: _textEditingController,
            focusNode: _focusNode,
            keyboardType: widget.inputType ?? TextInputType.text,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            inputFormatters: widget.inputFormatters,
            autofillHints: widget.autofillHints,
            style: AppTextStyles.style.s16.w600.darianColor,
            obscureText: widget.inputType == TextInputType.visiblePassword ? true : false,
            obscuringCharacter: '✶',
            maxLines: widget.maxLines,
            cursorColor: AppColors.darkOrange,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyles.style.s16.w600.orchalColor,
              border: AppThemes.inputDefault,
              enabledBorder: AppThemes.inputDefault,
              errorBorder: AppThemes.inputDefault,
              focusedErrorBorder: AppThemes.inputFocused,
              focusedBorder: AppThemes.inputFocused,
              suffixIcon: widget.suffix != null
                  ? CupertinoButton(
                      onPressed: () {
                        widget.onClickSuffix?.call();
                        if (!widget.isPasswordField) {
                          _textEditingController.clear();
                        }
                      },
                      child: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _textEditingController,
                        builder: (context, value, child) {
                          if (widget.alwaysShowSuffix) {
                            return widget.suffix!;
                          }
                          if (value.text.isNotEmpty) {
                            return widget.suffix!;
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    )
                  : null,
              fillColor: AppColors.white,
              filled: true,
            ),
          ),
        ),
        SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: Text(widget.errorText, style: AppTextStyles.style.s12.w400.redColor),
        ),
      ],
    );
  }
}

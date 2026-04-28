import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../generated/assets.gen.dart';
import 'text_field_custom.dart';

class ProductTextInput extends StatefulWidget {
  final String label;
  final String hint;
  final FocusNode? focusNode;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final ValueChanged<String>? onSubmitted;
  final String errorText;
  final bool showValidationErrors;
  final int submitAttempt;
  final int maxLines;
  final String? initialValue;

  const ProductTextInput({
    super.key,
    required this.label,
    required this.hint,
    required this.onChanged,
    required this.onClear,
    required this.errorText,
    required this.showValidationErrors,
    required this.submitAttempt,
    this.focusNode,
    this.inputType,
    this.textInputAction,
    this.inputFormatters,
    this.onSubmitted,
    this.maxLines = 1,
    this.initialValue,
  });

  @override
  State<ProductTextInput> createState() => _ProductTextInputState();
}

class _ProductTextInputState extends State<ProductTextInput> with SingleTickerProviderStateMixin {
  late AnimationController _animation;
  late Animation<double> _offsetAnimation;
  late int _lastSubmitAttempt;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(duration: const Duration(milliseconds: 360), vsync: this);
    _offsetAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _animation, curve: Curves.easeOut));
    _lastSubmitAttempt = widget.submitAttempt;
  }

  @override
  void didUpdateWidget(covariant ProductTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    final submittedAgain = widget.submitAttempt != _lastSubmitAttempt;
    if (submittedAgain && widget.showValidationErrors && widget.errorText.isNotEmpty) {
      _trigger();
    }
    _lastSubmitAttempt = widget.submitAttempt;
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  void _trigger() {
    _animation.stop();
    _animation.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldCustom(
      focusNode: widget.focusNode,
      hintText: widget.hint,
      labelText: widget.label,
      errorText: widget.showValidationErrors ? widget.errorText : '',
      inputType: widget.inputType,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      suffix: Assets.svgs.icCloseCircle.svg(),
      onClickSuffix: widget.onClear,
      animation: _animation,
      offset: _offsetAnimation,
      maxLines: widget.maxLines,
      initialValue: widget.initialValue,
    );
  }
}

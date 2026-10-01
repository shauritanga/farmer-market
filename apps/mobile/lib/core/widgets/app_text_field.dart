import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

/// Shared text field: a leading hugeicon plus, for [obscureText] fields, a
/// trailing show/hide toggle. Used by login and every registration step so
/// the two flows look and behave identically (see AGENTS.md "Reusable
/// Components").
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autofocus = false,
    this.hintText,
  });

  final TextEditingController controller;
  final String label;
  final List<List<dynamic>> icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final bool autofocus;
  final String? hintText;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscured = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscured,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      autofocus: widget.autofocus,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: HugeIcon(
            icon: widget.icon,
            size: 20.sp,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 20.h),
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () => setState(() => _obscured = !_obscured),
                icon: HugeIcon(
                  icon: _obscured
                      ? HugeIcons.strokeRoundedViewOff
                      : HugeIcons.strokeRoundedView,
                  size: 20.sp,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              )
            : null,
      ),
    );
  }
}

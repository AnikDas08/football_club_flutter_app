import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants/app_colors.dart';
import '../text/common_text.dart';

// ignore: must_be_immutable
class CommonTextField extends StatefulWidget {
  const CommonTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.mexLength,
    this.validator,
    this.prefixText,
    this.paddingHorizontal = 16,
    this.paddingVertical = 14,
    this.borderRadius,
    this.inputFormatters,
    this.fillColor,
    this.hintTextColor,
    this.labelTextColor,
    this.textColor,
    this.borderColor = AppColors.transparent,
    this.onSubmitted,
    this.onChanged,
    this.onTap,
    this.isDense,
    this.suffixIcon,
    this.maxLines,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.prefixIconConstraints,
    this.isDark = false,
  });

  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? labelTextColor;
  final Color? hintTextColor;
  final Color? textColor;
  final Color borderColor;
  final double paddingHorizontal;
  final double paddingVertical;
  final int? maxLines;
  final double? borderRadius;
  final int? mexLength;
  final bool isPassword;
  final bool? isDense;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final BoxConstraints? prefixIconConstraints;
  final bool isDark;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final RxBool obscureText = false.obs;

  @override
  Widget build(BuildContext context) {
    // Determine defaults based on isDark theme
    final resolvedFillColor = widget.fillColor ?? (widget.isDark ? const Color(0xFF0C1322).withOpacity(0.6) : AppColors.white);
    final resolvedTextColor = widget.textColor ?? (widget.isDark ? Colors.white : AppColors.black);
    final resolvedHintTextColor = widget.hintTextColor ?? (widget.isDark ? AppColors.textSecondary : AppColors.textSecondary);
    final resolvedLabelTextColor = widget.labelTextColor ?? (widget.isDark ? AppColors.textColor : AppColors.textColor);
    final resolvedRadius = widget.borderRadius ?? (widget.isDark ? 12.0 : 10.0);
    
    final resolvedPrefixIconConstraints = widget.prefixIconConstraints ?? 
        (widget.isDark 
            ? BoxConstraints(minWidth: 48.w, minHeight: 24.h)
            : const BoxConstraints(maxWidth: 30, maxHeight: 30));

    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(resolvedRadius.r),
      borderSide: BorderSide(
        color: widget.isDark 
            ? Colors.white.withOpacity(0.1) 
            : (widget.borderColor == AppColors.transparent ? Colors.grey.withValues(alpha: 0.3) : widget.borderColor),
      ),
    );

    final resolvedEnabledBorder = widget.enabledBorder ?? defaultBorder;
    
    final resolvedFocusedBorder = widget.focusedBorder ?? (widget.isDark 
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(resolvedRadius.r),
            borderSide: const BorderSide(color: Color(0xFF1239D4), width: 1.5),
          )
        : defaultBorder);

    final resolvedErrorBorder = widget.errorBorder ?? (widget.isDark 
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(resolvedRadius.r),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          )
        : defaultBorder);

    final resolvedFocusedErrorBorder = widget.focusedErrorBorder ?? (widget.isDark 
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(resolvedRadius.r),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          )
        : defaultBorder);

    return Obx(
      () => TextFormField(
        autovalidateMode: AutovalidateMode.onUnfocus,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText: widget.isPassword ? !obscureText.value : obscureText.value,
        textInputAction: widget.textInputAction,
        maxLength: widget.mexLength,
        onChanged: widget.onChanged,
        inputFormatters: widget.inputFormatters,
        style: TextStyle(fontSize: 14, color: resolvedTextColor),
        onFieldSubmitted: widget.onSubmitted,
        onTap: widget.onTap,
        validator: widget.validator,
        maxLines: widget.isPassword ? 1 : widget.maxLines,
        decoration: InputDecoration(
          errorMaxLines: 2,
          isDense: widget.isDense,
          filled: true,
          prefixIconConstraints: resolvedPrefixIconConstraints,
          prefixIcon: widget.prefixIcon != null && widget.isDark
              ? IconTheme(
                  data: IconThemeData(color: AppColors.textColor),
                  child: widget.prefixIcon!,
                )
              : widget.prefixIcon,
          fillColor: resolvedFillColor,

          counterText: '',
          contentPadding: EdgeInsets.symmetric(
            horizontal: widget.paddingHorizontal.w,
            vertical: widget.paddingVertical.h,
          ),
          border: widget.border ?? defaultBorder,
          enabledBorder: resolvedEnabledBorder,
          focusedBorder: resolvedFocusedBorder,
          disabledBorder: widget.border ?? defaultBorder,
          errorBorder: resolvedErrorBorder,
          focusedErrorBorder: resolvedFocusedErrorBorder,
          hintText: widget.hintText,
          labelText: widget.labelText,
          hintStyle: GoogleFonts.inter(fontSize: 12, color: resolvedHintTextColor),
          labelStyle: GoogleFonts.inter(fontSize: 12, color: resolvedLabelTextColor),
          prefix: CommonText(text: widget.prefixText ?? '', fontWeight: FontWeight.w400),
          suffixIcon: widget.isPassword ? _buildPasswordSuffixIcon(resolvedTextColor) : widget.suffixIcon,
        ),
      ),
    );
  }

  Widget _buildPasswordSuffixIcon(Color resolvedTextColor) {
    return GestureDetector(
      onTap: toggle,
      child: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Obx(
          () => Icon(
            obscureText.value
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 20.sp,
            color: resolvedTextColor.withOpacity(0.4),
          ),
        ),
      ),
    );
  }

  void toggle() {
    obscureText.value = !obscureText.value;
  }
}

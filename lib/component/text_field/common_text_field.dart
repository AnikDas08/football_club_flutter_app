import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants/app_colors.dart';
import '../text/common_text.dart';

// ignore: must_be_immutable
class CommonTextField extends StatelessWidget {
  CommonTextField({
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
  RxBool obscureText = false.obs;
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
  Widget build(BuildContext context) {
    // Determine defaults based on isDark theme
    final resolvedFillColor = fillColor ?? (isDark ? const Color(0xFF0C1322).withOpacity(0.6) : AppColors.white);
    final resolvedTextColor = textColor ?? (isDark ? Colors.white : AppColors.black);
    final resolvedHintTextColor = hintTextColor ?? (isDark ? AppColors.textColor : AppColors.textColor);
    final resolvedLabelTextColor = labelTextColor ?? (isDark ? AppColors.textColor : AppColors.textColor);
    final resolvedRadius = borderRadius ?? (isDark ? 12.0 : 10.0);
    
    final resolvedPrefixIconConstraints = prefixIconConstraints ?? 
        (isDark 
            ? BoxConstraints(minWidth: 48.w, minHeight: 24.h)
            : const BoxConstraints(maxWidth: 30, maxHeight: 30));

    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(resolvedRadius.r),
      borderSide: BorderSide(
        color: isDark 
            ? Colors.white.withOpacity(0.1) 
            : (borderColor == AppColors.transparent ? Colors.grey.withValues(alpha: 0.3) : borderColor),
      ),
    );

    final resolvedEnabledBorder = enabledBorder ?? defaultBorder;
    
    final resolvedFocusedBorder = focusedBorder ?? (isDark 
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(resolvedRadius.r),
            borderSide: const BorderSide(color: Color(0xFF1239D4), width: 1.5),
          )
        : defaultBorder);

    final resolvedErrorBorder = errorBorder ?? (isDark 
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(resolvedRadius.r),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          )
        : defaultBorder);

    final resolvedFocusedErrorBorder = focusedErrorBorder ?? (isDark 
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(resolvedRadius.r),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          )
        : defaultBorder);

    return Obx(
      () => TextFormField(
        autovalidateMode: AutovalidateMode.onUnfocus,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: isPassword ? !obscureText.value : obscureText.value,
        textInputAction: textInputAction,
        maxLength: mexLength,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        style: TextStyle(fontSize: 14, color: resolvedTextColor),
        onFieldSubmitted: onSubmitted,
        onTap: onTap,
        validator: validator,
        maxLines: isPassword ? 1 : maxLines,
        decoration: InputDecoration(
          errorMaxLines: 2,
          isDense: isDense,
          filled: true,
          prefixIconConstraints: resolvedPrefixIconConstraints,
          prefixIcon: prefixIcon != null && isDark
              ? IconTheme(
                  data: IconThemeData(color: AppColors.textColor),
                  child: prefixIcon!,
                )
              : prefixIcon,
          fillColor: resolvedFillColor,

          counterText: '',
          contentPadding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal.w,
            vertical: paddingVertical.h,
          ),
          border: border ?? defaultBorder,
          enabledBorder: resolvedEnabledBorder,
          focusedBorder: resolvedFocusedBorder,
          disabledBorder: border ?? defaultBorder,
          errorBorder: resolvedErrorBorder,
          focusedErrorBorder: resolvedFocusedErrorBorder,
          hintText: hintText,
          labelText: labelText,
          hintStyle: GoogleFonts.roboto(fontSize: 14, color: resolvedHintTextColor),
          labelStyle: GoogleFonts.roboto(fontSize: 14, color: resolvedLabelTextColor),
          prefix: CommonText(text: prefixText ?? '', fontWeight: FontWeight.w400),
          suffixIcon: isPassword ? _buildPasswordSuffixIcon(resolvedTextColor) : suffixIcon,
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

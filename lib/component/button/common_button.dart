import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';
import '../other_widgets/common_loader.dart';
import '../text/common_text.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String titleText;
  final Color titleColor;
  final Color buttonColor;
  final Color? borderColor;
  final double borderWidth;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double buttonHeight;
  final double buttonWidth;
  final bool isLoading;
  final Gradient? gradient;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CommonButton({
    this.onTap,
    required this.titleText,
    this.titleColor = AppColors.white,
    this.buttonColor = AppColors.primaryColor,
    this.titleSize = 16,
    this.buttonRadius = 16,
    this.titleWeight = FontWeight.w600,
    this.buttonHeight = 48,
    this.borderWidth = 1,
    this.isLoading = false,
    this.buttonWidth = double.infinity,
    this.borderColor = AppColors.primaryColor,
    this.gradient,
    this.prefixIcon,
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _buildElevatedButton();
  }

  Widget _buildElevatedButton() {
    final hasGradient = gradient != null;
    final decoration = hasGradient
        ? BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(buttonRadius),
          )
        : null;

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: hasGradient ? Colors.transparent : buttonColor,
      shadowColor: hasGradient ? Colors.transparent : null,
      elevation: hasGradient ? 0 : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonRadius),
        side: hasGradient
            ? BorderSide.none
            : BorderSide(color: borderColor ?? buttonColor, width: borderWidth),
      ),
      minimumSize: Size(buttonWidth, buttonHeight),
      maximumSize: Size(buttonWidth, buttonHeight),
      padding: EdgeInsets.zero,
    );

    Widget button = ElevatedButton(
      onPressed: onTap,
      style: buttonStyle,
      child: isLoading ? _buildLoader() : _buildText(),
    );

    if (hasGradient) {
      return Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: decoration,
        child: button,
      );
    }

    return button;
  }

  Widget _buildLoader() {
    return CommonLoader(size: buttonHeight - 12, color: Colors.white);
  }

  Widget _buildText() {
    if (prefixIcon == null && suffixIcon == null) {
      return CommonText(
        text: titleText,
        fontSize: titleSize,
        color: titleColor,
        fontWeight: titleWeight,
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (prefixIcon != null) ...[
          prefixIcon!,
          const SizedBox(width: 8),
        ],
        CommonText(
          text: titleText,
          fontSize: titleSize,
          color: titleColor,
          fontWeight: titleWeight,
        ),
        if (suffixIcon != null) ...[
          const SizedBox(width: 8),
          suffixIcon!,
        ],
      ],
    );
  }
}

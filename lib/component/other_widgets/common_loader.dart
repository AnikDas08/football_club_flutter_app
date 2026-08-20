import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key, this.size = 60, this.strokeWidth = 4, this.color});

  final double size;
  final double strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size.sp,
        width: size.sp,
        child: Platform.isIOS
            ? CupertinoActivityIndicator(
                color: color ?? Colors.white,
                radius: size.sp / 2,
              )
            : CircularProgressIndicator(
                strokeWidth: strokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.white),
              ),
      ),
    );
  }
}

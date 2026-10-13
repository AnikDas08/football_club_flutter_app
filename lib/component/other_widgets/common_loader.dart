import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key, this.size = 32, this.strokeWidth = 3, this.color});

  final double size;
  final double strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: color ?? Colors.white,
        radius: (size / 2).r,
      ),
    );
  }
}

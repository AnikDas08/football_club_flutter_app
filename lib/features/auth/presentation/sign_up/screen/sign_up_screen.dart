import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/button/common_button.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/features/auth/presentation/sign_up/container/sign_up_controller.dart';
import 'package:football_club/features/auth/presentation/sign_up/widgets/already_accunt_rich_text.dart';
import 'package:football_club/features/auth/presentation/sign_up/widgets/sign_up_all_filed.dart';
import 'package:football_club/utils/constants/app_string.dart';
import 'package:football_club/utils/extensions/extension.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Section Starts Here
      appBar: AppBar(),

      /// Body Section Starts Here
      body: GetBuilder<SignUpController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// Sign UP Instructions here
                  const CommonText(
                    text: AppString.createYourAccount,
                    fontSize: 32,
                    bottom: 20,
                  ),

                  /// All Text Filed here
                  SignUpAllField(controller: controller),

                  16.height,

                  /// Submit Button Here
                  CommonButton(
                    titleText: AppString.signUp,
                    isLoading: controller.isLoading,
                    onTap: () {
                      if (!_formKey.currentState!.validate()) return;
                      controller.signUpUser();
                    },
                  ),
                  24.height,

                  ///  Sign In Instruction here
                  const AlreadyAccountRichText(),
                  30.height,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

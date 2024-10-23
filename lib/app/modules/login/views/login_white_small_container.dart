import 'package:d_and_s/app/constants/text_size.dart';
import 'package:d_and_s/app/modules/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:d_and_s/app/modules/forgot_password/views/forgot_password_view.dart';

import 'package:d_and_s/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/colors.dart';
import '../../register/views/register_view.dart';
import '../../reusable_widgets/CheckBoxReusable.dart';
import '../../reusable_widgets/LargeButtonReusable.dart';
import '../../reusable_widgets/TextFormFieldReusable.dart';

class LoginWhiteSmallContainer extends StatelessWidget {
  final controller = Get.put(LoginController());
  final email = TextEditingController();
  final password = TextEditingController();

  LoginWhiteSmallContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Adaptive.h(23),
      left: 25,
      right: 25,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email",
                style: TextStyle(
                  fontSize: TextSize.small,
                  color: AppColors.titleColorGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              TextFormFieldReusable(
                hint: 'Enter your email',
                icon: const Icon(Icons.person),
                textEditingController: email,
              ),
              const SizedBox(height: 10),
              Text(
                "Password",
                style: TextStyle(
                    fontSize: TextSize.small,
                    color: AppColors.titleColorGrey,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              TextFormFieldReusable(
                isObscure: true,
                hint: 'Enter your Password',
                icon: const Icon(Icons.password),
                textEditingController: password,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Obx(
                    () => CheckboxReusable(
                      checkboxFunc: () {
                        controller.toogleIsSelected();
                      },
                      valueCheckBox: controller.isSelected.value,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Remember me",
                    style: TextStyle(
                        fontSize: TextSize.small,
                        color: AppColors.titleColorGrey,
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        ForgotPasswordView(),
                        // transition: Transition
                        //     .leftToRightWithFade, // Professional fade-in effect
                        // duration: const Duration(
                        //     milliseconds:
                        //         500), // Smooth duration for the transition
                        // curve: Curves
                        //     .easeInOut, // Adds smoothness with easing in and out
                      );
                    },
                    child: const Text(
                      "Forgot Password ?",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                  onTap: () => Get.to(
                        // const BottomNavBar(),
                        BottomNavigationView(),
                        // transition: Transition
                        //     .leftToRightWithFade, // Professional fade-in effect
                        // duration: const Duration(
                        //     milliseconds:
                        //         500), // Smooth duration for the transition
                        // curve: Curves
                        //     .easeInOut, // Adds smoothness with easing in and out
                      ),
                  child: const LargeButtonReusable(
                    title: "Log in",
                    color: AppColors.buttonColor,
                  )),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontSize: TextSize.small,
                        color: AppColors.textColorGrey,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        RegisterView(),
                        // transition: Transition
                        //     .leftToRightWithFade, // Professional fade-in effect
                        // duration: const Duration(
                        //     milliseconds:
                        //         500), // Smooth duration for the transition
                        // curve: Curves
                        //     .easeInOut, // Adds smoothness with easing in and out
                      );
                    },
                    child: Text(
                      "Sign UP",
                      style: TextStyle(
                          fontSize: TextSize.small,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

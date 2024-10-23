// ignore_for_file: file_names

import 'package:d_and_s/app/constants/colors.dart';
import 'package:d_and_s/app/modules/user_account/controllers/user_account_controller.dart';

import 'package:d_and_s/app/modules/user_account/views/user_account_tabBar/user_account_tabs_info/user_account_tabs_Info.dart';
import 'package:d_and_s/app/modules/user_account/views/user_account_tabBar/user_account_tabs_WishList.dart';
import 'package:d_and_s/app/modules/user_account/views/user_account_tabBar/user_account_tabs_address/user_account_tabs_address.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/text_size.dart';

import 'user_account_tabs_order/user_account_tabs_Order.dart';
import 'user_account_tabs_review/user_account_tabs_review.dart';

class UserAccountTabBar extends StatelessWidget {
  final List<String> tabLabels = [
    "Personal Information",
    "Add Address",
    "Order History",
    "WishList",
    "Review"
  ];
  final userAccController = Get.put(UserAccountController());
  UserAccountTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tabLabels.length,
            itemBuilder: (BuildContext context, index) => GestureDetector(
              onTap: () {
                userAccController.tabBarIndex.value = index;
              },
              child: Obx(
                () => Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(16),
                    color: userAccController.tabBarIndex.value == index
                        ? AppColors.buttonColor
                        // Color(0xff6B7280)
                        : Colors.white,
                  ),
                  child: Text(
                    tabLabels[index],
                    style: TextStyle(
                      fontSize: TextSize.small,
                      fontWeight: FontWeight.w700,
                      color:
                          //  Colors.white,
                          userAccController.tabBarIndex.value == index
                              ? Colors.white
                              : AppColors.titleColorGrey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Obx(() => changeView())
      ],
    );
  }

  changeView() {
    if (userAccController.tabBarIndex.value == 0) {
      return const UserAccountTabsInfo();
    } else if (userAccController.tabBarIndex.value == 1) {
      return const UserAccountTabsAddress();
    } else if (userAccController.tabBarIndex.value == 2) {
      return UserAccountTabsOrder();
    } else if (userAccController.tabBarIndex.value == 3) {
      return UserAccountTabsWishList();
    } else {
      return UserAccountTabsReview();
    }
  }
}

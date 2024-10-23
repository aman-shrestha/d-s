// ignore_for_file: file_names, must_be_immutable

import 'package:d_and_s/app/constants/colors.dart';
import 'package:d_and_s/app/modules/favourites/controllers/favourites_controller.dart';
import 'package:d_and_s/app/modules/home/controllers/home_controller.dart';
import 'package:d_and_s/app/modules/product_detail/controllers/product_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../constants/text_size.dart';
import '../../../../data/alldata.dart';
import '../../../product_detail/views/product_detail_view.dart';
import 'home_section_tabBar_tabs_bottomSheet.dart';

class HomeSectionTabBarTabs extends StatelessWidget {
  HomeSectionTabBarTabs({
    super.key,
  });
  final controller = Get.put(HomeController());

  final controllerProduct = Get.put(ProductDetailController());
  final controllerFavorites = Get.put(FavouritesController());
  var index = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // Get the selected tab's products list
        var selectedProducts = products
            .where((element) =>
                element["featured"] == controller.homeSectionindex.value)
            .toList();
        // Create a list of observable indices for each product
        List<RxInt> imageIndices = List.generate(
          selectedProducts.length,
          (index) => 0.obs,
        );

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: selectedProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 15.0,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (BuildContext context, index) {
            var product = selectedProducts[index];
            Map colorMap = product["color"] ?? {};
            List imageUrls = colorMap.isNotEmpty
                ? colorMap.entries.first.value
                : [
                    'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg'
                  ]; // Gets the list of images for the first color
            String imageUrl = imageUrls[0];

            void onSwipeLeft() {
              if (imageIndices[index].value < imageUrls.length - 1) {
                imageIndices[index].value++;
              } else {
                imageIndices[index].value = 0;
              }
            }

            void onSwipeRight() {
              if (imageIndices[index].value > 0) {
                imageIndices[index].value--;
              } else {
                imageIndices[index].value = imageUrls.length - 1;
              }
            }

            // imageUrls.isNotEmpty
            // ? imageUrls[0]
            // : 'https://static-00.iconduck.com/assets.00/no-image-icon-512x512-lfoanl0w.png'; // First image URL of the first color
            return GestureDetector(
              onTap: () {
                controllerProduct.selectedColorName.value = '';

                Map imageStore = product["color"] ?? {};
                Map images = imageStore.isNotEmpty
                    ? product["color"]
                    : {
                        0x00000000: [
                          'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg'
                        ],
                      };
                List test = images.entries.first.value;
                controllerProduct.selectedImages.assignAll(test);
                Get.to(
                  ProductDetailView(data: product),
                );
              },
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => GestureDetector(
                              onHorizontalDragEnd: (details) {
                                // Detect swipe direction based on velocity
                                if (details.velocity.pixelsPerSecond.dx > 0) {
                                  // Swiped right
                                  onSwipeRight();
                                } else if (details.velocity.pixelsPerSecond.dx <
                                    0) {
                                  // Swiped left
                                  onSwipeLeft();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrls[imageIndices[
                                            index]
                                        .value]), // Replace with actual image URL
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                height: Adaptive.h(25),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Rs.${product["price"] ?? ""}",
                                      style: TextStyle(
                                          fontSize: TextSize.small,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(width: 5),

                                    const Spacer(),
                                    // Positioned(
                                    //   right: 0,
                                    //   top: 40,
                                    //   child:
                                    GestureDetector(
                                      onTap: () {
                                        controllerProduct
                                            .selectedColorName.value = '';
                                        Map imageStore = product["color"] ?? {};
                                        Map images = imageStore.isNotEmpty
                                            ? product["color"]
                                            : {
                                                0x00000000: [
                                                  'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg'
                                                ],
                                              };
                                        List test = images.entries.first.value;
                                        controllerProduct.selectedImages
                                            .assignAll(test);
                                        showModalBottomSheet<void>(
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return DraggableScrollableSheet(
                                                expand: false,
                                                initialChildSize:
                                                    0.8, // Set initial height of bottom sheet
                                                maxChildSize:
                                                    0.8, // Max height when fully expanded
                                                minChildSize:
                                                    0.3, // Minimum height of bottom sheet
                                                builder: (BuildContext context,
                                                        scrollController) =>
                                                    HomeSectionTabBarTabsBottomSheet(
                                                  homeSectionTabsData: product,
                                                  homeSectionTabsImg: imageUrl,
                                                ),
                                              );
                                            });
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 15),
                                        child: Icon(
                                          Icons.shopping_cart_outlined,
                                          size: 18,
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      "${product["realprice"]}",
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        decorationThickness: 2,
                                        decorationColor: Colors.grey,
                                        fontSize: 12,
                                        // color: AppColors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "${product["discount"]}%",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Expanded(
                                      child: Text(
                                        "Original Price ",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                          // color: AppColors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    product["name"] ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColors.titleColorGrey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      // color: AppColors.defaultColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Tags(tagTitle: "${product["discount"]}%"),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

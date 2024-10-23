import 'package:d_and_s/app/modules/product_detail/views/product_detail_view.dart';
import 'package:d_and_s/app/modules/reusable_widgets/recommendation_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_size.dart';

import '../controllers/favourites_controller.dart';

class FavouritesView extends StatelessWidget {
  final controller = Get.put(FavouritesController());

  FavouritesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightSilver,
        title: const Text('Favourites'),
        centerTitle: false,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.lightSilver,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () => Column(
                children: [
                  controller.favoritesList.isEmpty
                      ? Container(
                          height: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/emptyWishList.png"), // Use AssetImage instead of Image.asset
                              fit: BoxFit
                                  .cover, // Optional: Adjust image fit if necessary
                            ),
                          ),
                        )
                      : Column(
                          children: controller.favoritesList.map((item) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Product Image
                                  Container(
                                    height: 120,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            item["color"].entries.first.value[0]
                                            // .entries.first.value,
                                            ),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  // Product Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Product Title
                                        Text(
                                          item["name"],
                                          style: TextStyle(
                                            color: AppColors.titleColorGrey,
                                            fontSize: TextSize.small,
                                            fontWeight: FontWeight.w700,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 2,
                                        ),
                                        const SizedBox(height: 10),

                                        // Product Size
                                        // Text(
                                        //   "Size: ${item["size"]}",
                                        //   style: const TextStyle(
                                        //     color: Colors.blue,
                                        //     fontSize: 14,
                                        //   ),
                                        // ),
                                        // const SizedBox(height: 5),

                                        // Price and Discounted Price
                                        Row(
                                          children: [
                                            Text(
                                              "Rs. ${item["price"]}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            // if (item["realprice"] != null)
                                            Text(
                                              "\$${item["realprice"]}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: TextSize.small,
                                                  color:
                                                      AppColors.textColorGrey),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            // Product Color
                                            // Container(
                                            //   height: 20,
                                            //   width: 20,
                                            //   decoration: BoxDecoration(
                                            //     shape: BoxShape.circle,
                                            //     color: Color(
                                            //       // 0xffFF0000
                                            //       item["color"],
                                            //     ),
                                            //   ),
                                            // ),
                                            GestureDetector(
                                                onTap: () {
                                                  Get.to(ProductDetailView(
                                                      data: item));
                                                },
                                                child: Text(
                                                  "View Product",
                                                  style: TextStyle(
                                                      fontSize: TextSize.small,
                                                      color: AppColors
                                                          .primaryColor),
                                                )),

                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                controller.favoritesList
                                                    .removeWhere(
                                                  (element) =>
                                                      element["product_id"] ==
                                                      item["product_id"],
                                                );
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: AppColors.textColorGrey,
                                              ),
                                            ),
                                            // Quantity Selector
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.lightSilver,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Recommended Items', // Improved typography
                  style: TextStyle(
                    fontSize: 18, // Slightly larger for emphasis
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors
                      .lightSilver, // Background color for a clean look
                  borderRadius: BorderRadius.circular(
                      10), // Rounded corners for smoothness
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Soft shadow
                      blurRadius: 10,
                      offset: const Offset(0, 5), // Shadow direction
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.all(10), // Padding inside the container
                height: Adaptive.h(27),
                child: RecommendationView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

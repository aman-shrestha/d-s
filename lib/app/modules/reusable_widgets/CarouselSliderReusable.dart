// ignore_for_file: file_names

import 'package:d_and_s/app/constants/text_size.dart';
import 'package:d_and_s/app/modules/category/views/category_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// class CarouselSliderReusable extends StatelessWidget {
//   final List<String> imgList;
//   CarouselSliderReusable({super.key, required this.imgList});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(0.0),
//       child: CarouselSlider(
//         options: CarouselOptions(
//           autoPlay: true,
//           enlargeStrategy: CenterPageEnlargeStrategy.zoom,
//           enlargeCenterPage: true,
//           aspectRatio: 2,
//         ),

//         items: imgList
//             .map((item) => Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 0),
//                   // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),image: DecorationImage(image: NetworkImage(item))),
//                   child: Image.network(
//                     item,
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     height: double.infinity,
//                   ),
//                 ))
//             .toList(),
//       ),

//     );
//   }
// }
// ignore: must_be_immutable
class CarouselSliderReusable extends StatelessWidget {
  var index = 0.obs;
  final List<String> title = [
    "From casual to formal, our shirts are designed to keep you looking sharp.",
    "Make a statement in our expertly crafted suits. Perfect fit, every time.",
    "Redefine elegance with our tailored suits, designed for the modern man.",
  ];
  final List<String> imgList;
  CarouselSliderReusable({super.key, required this.imgList});

  void _onSwipeLeft() {
    if (index.value < imgList.length - 1) {
      index.value++;
    } else {
      index.value = 0;
    }
  }

  void _onSwipeRight() {
    if (index.value > 0) {
      index.value--;
    } else {
      index.value = imgList.length - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        // Detect swipe direction based on velocity
        if (details.velocity.pixelsPerSecond.dx > 0) {
          // Swiped right
          _onSwipeRight();
        } else if (details.velocity.pixelsPerSecond.dx < 0) {
          // Swiped left
          _onSwipeLeft();
        }
      },
      child: Stack(
        children: [
          Obx(
            () => Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(imgList[index.value]),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.3),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 40,
            child: GestureDetector(
              onTap: () {
                Get.to(CategoryView());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Urban Edge 2024",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: TextSize.medium,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: Adaptive.w(70), // Ensures adaptive width
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(
                      () => Text(
                        title[index.value],
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: TextSize.small,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    child: Text(
                      "Shop Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: TextSize.small,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 10,
            child: GestureDetector(
              onTap: _onSwipeRight, // Call the right swipe function
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: 10,
            child: GestureDetector(
              onTap: _onSwipeLeft, // Call the left swipe function
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

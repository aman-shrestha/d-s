import 'package:get/get.dart';

class LoginController extends GetxController {

  RxBool isSelected = false.obs;
  void toogleIsSelected() {
    isSelected.value = !isSelected.value;
  }

  final count = 0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void increment() => count.value++;
}

import 'package:get/get.dart';

class CounterController extends GetxController {
  RxInt bilangan = 0.obs;

  void tambahSatu() {
    if (bilangan.value >= 20) {
      Get.snackbar('Warning', 'Loba teuing Cangkeul');
    } else {
      bilangan.value++;
    }
  }
    void kurangSatu() {
    if (bilangan.value <= 0) {
      Get.snackbar('Warning', 'Tebisa boy');
    } else {
      bilangan.value--;
    }
  }
}

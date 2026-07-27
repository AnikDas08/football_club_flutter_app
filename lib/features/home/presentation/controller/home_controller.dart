import 'package:get/get.dart';

class HomeController extends GetxController {
  var message = 0.obs; // Message badge count reactive variable
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  void fetchHomeData() {
    // Simulating home data fetch
    message.value = 3; // Setting a mock message badge count to show the reactive badge
  }
}

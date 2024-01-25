import 'package:get/get.dart';
import 'package:lawer_finder/controllers/common-controller.dart';

import '../controllers/home-controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // todo:  dependencies
    Get.put(CommonController());
    Get.put(HomeController());
  }
}

import 'package:get/get.dart';

import '../home/Screen/home_page.dart';
import '../home/Screen/add_product.dart';
import '../home/Screen/edit_product.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.ADDPRODUCT,
      page: () => AddProduct(),
    ),
    GetPage(
        name: Routes.EDITPRODUCT,
        page: (() {
          return EditProduct(
            id: Get.arguments,
          );
        })),
  ];
}

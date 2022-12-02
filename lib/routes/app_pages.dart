import 'package:get/get.dart';

import '../home/Screen/home_page.dart';
import '../home/Screen/add_product.dart';
import '../home/Screen/edit_product.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: Routes.addproduct,
      page: () => const AddProduct(),
    ),
    GetPage(
        name: Routes.editproduct,
        page: (() {
          return EditProduct(
            id: Get.arguments,
          );
        })),
  ];
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  final String name;
  final int price;
  final int rate;
  final String desc;

  Product(
      {this.id = '',
      required this.name,
      required this.price,
      required this.rate,
      required this.desc});
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'rate': rate,
        'desc': desc,
      };
}

class HomeController {
  static Future createProduct(name, price, rate, desc) async {
    final docUser = FirebaseFirestore.instance.collection('products').doc();
    final user = Product(
        id: docUser.id, name: name, price: price, rate: rate, desc: desc);
    final json = user.toJson();
    await docUser.set(json);
    return '200';
  }
}

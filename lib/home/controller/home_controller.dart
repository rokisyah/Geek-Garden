import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

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
  static Future loadFakeStore() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    return response.body;
  }

  static Future createProduct(name, price, rate, desc) async {
    final docProduct = FirebaseFirestore.instance.collection('products').doc();
    final product = Product(
        id: docProduct.id, name: name, price: price, rate: rate, desc: desc);
    final json = product.toJson();
    await docProduct.set(json);
    return '200';
  }

  static Future updateProduct(id, name, price, rate, desc) async {
    final docProduct =
        FirebaseFirestore.instance.collection('products').doc(id);
    final product = Product(
        id: docProduct.id, name: name, price: price, rate: rate, desc: desc);
    final json = product.toJson();
    await docProduct.update(json);
    return '200';
  }

  static Future delete(id) async {
    final docProduct =
        FirebaseFirestore.instance.collection('products').doc(id);
    docProduct.delete();
    return '200';
  }

  static Future loadDataId(id) async {
    var collection = FirebaseFirestore.instance.collection('products');
    var docSnapshot = await collection.doc(id).get();
    if (docSnapshot.exists) {
      return (docSnapshot.data());
    }
  }
}

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  static String convertToDolar(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      symbol: 'USD ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}

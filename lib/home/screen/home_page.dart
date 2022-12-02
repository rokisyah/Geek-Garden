import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:animations/animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geek_garden/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final GlobalKey<State> _keyLoader = GlobalKey<State>();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  TextEditingController namaProduk = TextEditingController();
  TextEditingController hargaProduk = TextEditingController();
  TextEditingController rateProduk = TextEditingController();
  TextEditingController deskripsiProduk = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    final heightCard = MediaQuery.of(context).size.height;
    final widthCard = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // 1
          title: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 12, 0),
            child: Text('Products',
                style: TextStyle(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 16 * textScale,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                )),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
              child: IconButton(
                icon: Image.asset('assets/images/filter_search.png',
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    height: heightCard / 24.40816327),
                onPressed: () {
                  // _showBottomModal(context);
                },
              ),
            ),
          ],
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(20, 29, 46, 1),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  opacity: 0.05,
                  colorFilter: ColorFilter.mode(
                      const Color.fromRGBO(20, 29, 46, 1).withOpacity(1),
                      BlendMode.colorBurn),
                  image: const AssetImage("assets/images/Batik_Light.png"),
                  alignment: Alignment.bottomLeft,
                )),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: StreamBuilder(
                stream: readProducts(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    final products = snapshot.data!;
                    return ListView(
                        children: products.map(buildProduct).toList());
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
              ),
            )),
        floatingActionButton: InkWell(
            borderRadius: const BorderRadius.all(Radius.zero),
            onTap: () {
              // buildDetailData(index);
              Get.toNamed("/addproduct");
            },
            child: Container(
                width: widthCard / 4,
                height: heightCard / 15.92,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(238, 242, 249, 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      opacity: 0.5,
                      colorFilter: ColorFilter.mode(
                          const Color.fromRGBO(238, 242, 249, 1).withOpacity(1),
                          BlendMode.colorBurn),
                      image: const AssetImage("assets/images/Batik_Card.png"),
                      alignment: Alignment.bottomLeft,
                    )),
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/create_bold.png',
                          height: heightCard / 39.8,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: SizedBox(
                            width: widthCard / 7.8,
                            child: Text("Create",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10 * textScale,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                        )
                      ],
                    )))));
  }

  Future<void> productDetail(String id) async {
    final textScale = MediaQuery.of(context).textScaleFactor;
    final heightCard = MediaQuery.of(context).size.height;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pendaftaran Pelanggan',
              style: TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w500,
                  fontSize: 20 * textScale,
                  color: Color.fromRGBO(238, 242, 249, 1))),
          content: Card(
              color: const Color.fromRGBO(238, 242, 249, 1),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                  // width: widthCard / 2.407407407,
                  height: heightCard / 6.123076923,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        10,
                      ),
                      bottomLeft: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/watch.jpg"),
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(9),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              color: Colors.white,
                              child: Text(id,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12 * textScale,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500))),
                        ],
                      )))),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal',
                  style: TextStyle(
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      fontSize: 16 * textScale,
                      color: Color.fromRGBO(238, 242, 249, 1))),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 0.0,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  deleteDoc(context, id);
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(238, 242, 249, 1),
              ),
              child: Text('Delete',
                  style: TextStyle(
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      fontSize: 16 * textScale,
                      color: Color.fromRGBO(20, 29, 46, 1))),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // HomeController.loadDataId(id);

                  Get.toNamed('/editproduct', arguments: id);
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(238, 242, 249, 1),
              ),
              child: Text('Update',
                  style: TextStyle(
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      fontSize: 16 * textScale,
                      color: Color.fromRGBO(20, 29, 46, 1))),
            )
          ],
        );
      },
    );
  }

  void deleteDoc(BuildContext context, String id) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Warning !",
              style: TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w500,
                  fontSize: 20 * textScale,
                  color: Colors.red)),
          content: Text("Do you want to delete product?",
              style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Colors.black,
                  fontSize: 17 * textScale,
                  fontWeight: FontWeight.w400)),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 0.0,
              ),
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: Text('Cancel',
                  style: TextStyle(
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      fontSize: 20 * textScale,
                      color: const Color.fromRGBO(20, 29, 46, 1))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () => deleteProduct(id),
              child: Text('Ok',
                  style: TextStyle(
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      fontSize: 20 * textScale,
                      color: const Color.fromRGBO(255, 255, 255, 1))),
            ),
          ],
        );
      },
    );
  }

  Future deleteProduct(String id) async {
    return await HomeController.delete(id).then((value) {
      Future.delayed(const Duration(milliseconds: 200));
      Navigator.of(context, rootNavigator: true).pop();
      if (value == "200") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Delete Success.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
        ));
        setState(() {
          Get.back();
          Get.toNamed('/home');
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Delete Error.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ));
        setState(() {});
      }
    });
  }

  Widget buildProduct(Product product) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    final heightCard = MediaQuery.of(context).size.height;
    final widthCard = MediaQuery.of(context).size.width;
    return Card(
      color: const Color.fromRGBO(238, 242, 249, 1),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
          borderRadius: const BorderRadius.all(Radius.zero),
          onTap: () {
            productDetail(product.id);
          },
          child: Row(
            children: [
              Expanded(
                  child: Container(
                      // width: widthCard / 2.407407407,
                      height: heightCard / 6.123076923,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            10,
                          ),
                          bottomLeft: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/watch.jpg"),
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(9),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  color: Colors.white,
                                  child: Text(
                                      CurrencyFormat.convertToIdr(
                                          product.price, 2),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12 * textScale,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500))),
                            ],
                          )))),
              Expanded(
                  child: Container(
                      height: heightCard / 6.123076923,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(product.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12 * textScale,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              )),
                          Text(product.desc,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 9 * textScale,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              )),
                          Spacer(),
                          Row(
                            children: [
                              Spacer(),
                              Icon(
                                Icons.star,
                                color: Colors.green,
                              ),
                              Text(product.rate.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12 * textScale,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],
                          )
                        ],
                      )))
            ],
          )),
    );
  }

  Stream<List<Product>> readProducts() => FirebaseFirestore.instance
      .collection('products')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
}

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

  static Product fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        rate: json['rate'],
        desc: json['desc'],
      );
}

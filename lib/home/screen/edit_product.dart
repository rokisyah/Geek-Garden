import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:animations/animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geek_garden/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final GlobalKey<State> _keyLoader = GlobalKey<State>();

class EditProduct extends StatefulWidget {
  final String id;
  const EditProduct({Key? key, required this.id}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<EditProduct> {
  bool loading = false;
  String namaProduk = "";
  int hargaProduk = 0;
  int rateProduk = 0;
  String deskripsiProduk = "";
  TextEditingController namaProdukCtrl = TextEditingController();
  TextEditingController hargaProdukCtrl = TextEditingController();
  TextEditingController rateProdukCtrl = TextEditingController();
  TextEditingController deskripsiProdukCtrl = TextEditingController();

  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    loading = true;
    return await HomeController.loadDataId(widget.id).then((value) {
      print(value);
      namaProduk = value['name'];
      namaProdukCtrl.text = value['name'];

      hargaProduk = value['price'];
      hargaProdukCtrl.text = value['price'].toString();

      rateProduk = value['rate'];
      rateProdukCtrl.text = value['rate'].toString();

      deskripsiProduk = value['desc'];
      deskripsiProdukCtrl.text = value['desc'];
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    final heightCard = MediaQuery.of(context).size.height;
    final widthCard = MediaQuery.of(context).size.width;
    if (loading == true) {
      return Scaffold(
          body: Stack(children: [
        Container(
          color: Color.fromRGBO(20, 29, 46, 1),
          width: double.infinity,
        ),
        Center(
            child: SpinKitChasingDots(color: Color.fromRGBO(255, 255, 255, 1)))
      ]));
    } else {
      return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 12, 0),
              child: Text('Update Produk',
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 16 * textScale,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  )),
            ),
            centerTitle: true,
            leading: GestureDetector(
              child: Image.asset(
                'assets/images/back_button_1px.png',
                color: const Color.fromRGBO(255, 255, 255, 1),
                height: heightCard / 39.8,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
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
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: ListView(
                  children: [
                    Text(
                      "Product Name",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14 * textScale,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: heightCard / 159.2,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: heightCard / 68.34285714),
                      child: TextField(
                        style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 15 * textScale,
                            fontWeight: FontWeight.w400),
                        onChanged: (value) {
                          setState(() {
                            namaProduk = value;
                          });
                        },
                        controller: namaProdukCtrl,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            fillColor: const Color.fromRGBO(225, 227, 231, 1),
                            filled: true),
                      ),
                    ),
                    SizedBox(
                      height: heightCard / 79.6,
                    ),
                    Text(
                      "Product Price",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14 * textScale,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: heightCard / 159.2,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: heightCard / 68.34285714),
                      child: TextField(
                        style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 15 * textScale,
                            fontWeight: FontWeight.w400),
                        controller: hargaProdukCtrl,
                        onChanged: (value) {
                          value == "" ? value = 0.toString() : value = value;
                          setState(() {
                            hargaProduk = int.parse(value);
                          });
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Only numbers can be entered
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            fillColor: const Color.fromRGBO(225, 227, 231, 1),
                            filled: true),
                      ),
                    ),
                    SizedBox(
                      height: heightCard / 79.6,
                    ),
                    Text(
                      "Product Ratting",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14 * textScale,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: heightCard / 159.2,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: heightCard / 68.34285714),
                      child: TextField(
                        style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 15 * textScale,
                            fontWeight: FontWeight.w400),
                        onChanged: (value) {
                          value == "" ? value = 0.toString() : value = value;
                          setState(() {
                            rateProduk = int.parse(value);
                          });
                        },
                        controller: rateProdukCtrl,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Only numbers can be entered
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            fillColor: const Color.fromRGBO(225, 227, 231, 1),
                            filled: true),
                      ),
                    ),
                    SizedBox(
                      height: heightCard / 79.6,
                    ),
                    Text(
                      "Product Description",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14 * textScale,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: heightCard / 159.2,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      height: heightCard / 4.556190476,
                      child: TextField(
                        maxLines: 5,
                        style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 15 * textScale,
                            fontWeight: FontWeight.w400),
                        onChanged: (value) {
                          setState(() {
                            deskripsiProduk = value;
                          });
                        },
                        controller: deskripsiProdukCtrl,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(15)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(15)),
                            fillColor: const Color.fromRGBO(225, 227, 231, 1),
                            filled: true),
                      ),
                    ),
                    Card(
                        color: const Color.fromRGBO(113, 212, 166, 1),
                        margin: const EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: InkWell(
                          onTap: () {
                            checkUpdate(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text('Save Product',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16 * textScale,
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1))),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              )));
    }
  }

  void checkUpdate(BuildContext context) {
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
                  color: const Color.fromRGBO(20, 29, 46, 1))),
          content: Text("Do you want to create product?",
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
                primary: const Color.fromRGBO(20, 29, 46, 1),
              ),
              onPressed: () => editProduct(),
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

  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Container(
                color: const Color.fromRGBO(20, 29, 46, 1),
                child: const SpinKitFadingCircle(
                    color: Color.fromRGBO(255, 255, 255, 1)),
              ));
        });
  }

  Future editProduct() async {
    var jmlError = 0;
    var msgError = [];
    print(rateProduk);

    if (namaProduk == "") {
      jmlError++;
      msgError.add("Product Name cannot be empty");
    }

    if (hargaProduk <= 0) {
      jmlError++;
      msgError.add("Product Price cannot be 0");
    }

    // ignore: unrelated_type_equality_checks
    if (jmlError == 0) {
      showLoadingDialog(context, _keyLoader);
      return await HomeController.updateProduct(
              widget.id, namaProduk, hargaProduk, rateProduk, deskripsiProduk)
          .then((value) {
        Future.delayed(const Duration(milliseconds: 200));
        Navigator.of(context, rootNavigator: true).pop();
        if (value == "200") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Save Success.'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
          ));
          setState(() {
            Get.back();
            Get.back();
            // Get.toNamed('/home');
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Save Error.'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ));
          setState(() {});
        }
      });
    } else {
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
                    color: const Color.fromRGBO(255, 255, 255, 1))),
            content: Text(msgError.join("\n")),
            actions: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 20 * textScale),
                    primary: const Color.fromRGBO(20, 29, 46, 1),
                  ),
                  onPressed: () {
                    Navigator.pop(context, 'Ok');
                  },
                  child: Text('Ok',
                      style: TextStyle(
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                          fontSize: 20 * textScale,
                          color: const Color.fromRGBO(255, 255, 255, 1)))),
            ],
          );
        },
      );
    }
  }
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

import 'package:flutter/material.dart';
import 'dart:convert';
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
  TextEditingController namaProduk = TextEditingController();
  TextEditingController hargaProduk = TextEditingController();
  TextEditingController rateProduk = TextEditingController();
  TextEditingController deskripsiProduk = TextEditingController();

  String pilihtype = "Firebase";
  List<String> listtype = ["Firebase", "Fakestore"];
  int jumlahListPage = 0;

  var docIdList = [];
  var docImageList = [];
  var docNameList = [];
  var docDescList = [];
  var docPriceList = [];
  var docRateList = [];

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
            child: Text('Products $pilihtype',
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
                  _showBottomModal(context);
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
            child: pilihtype == "Firebase"
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: StreamBuilder(
                      stream: readProducts(),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          final products = snapshot.data!;
                          return ListView(
                              children: products.map(buildProduct).toList());
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                    ),
                  )
                : SafeArea(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                        child: buildListData()))),
        floatingActionButton: InkWell(
            borderRadius: const BorderRadius.all(Radius.zero),
            onTap: () {
              Get.toNamed("/addproduct");
            },
            child: Container(
                width: pilihtype == "Firebase" ? widthCard / 4 : 0,
                height: pilihtype == "Firebase" ? heightCard / 15.92 : 0,
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
                child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(251, 211, 9, 1),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
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

  void refreshData() async {
    jumlahListPage = 0;
    showLoadingDialog(context, _keyLoader);
    if (pilihtype == "Fakestore") {
      return await HomeController.loadFakeStore().then((value) {
        var jsonObject = json.decode(value);
        for (int i = 0; i < jsonObject.length; i++) {
          jumlahListPage++;
          docIdList.add(jsonObject[i]['id'].toString());
          docNameList.add(jsonObject[i]['title']);
          docDescList.add(jsonObject[i]['description']);
          docPriceList.add(jsonObject[i]['price']);
          docImageList.add(jsonObject[i]['image']);
          docRateList.add(jsonObject[i]['rating']['rate']);
        }
        Future.delayed(const Duration(milliseconds: 200));
        Navigator.of(context, rootNavigator: true).pop();
        setState(() {});
      });
    } else {
      Future.delayed(const Duration(milliseconds: 200));
      Navigator.of(context, rootNavigator: true).pop();
      setState(() {});
    }
  }

  buildListData() {
    final textScale = MediaQuery.of(context).textScaleFactor;
    final heightCard = MediaQuery.of(context).size.height;
    return Expanded(
      child: ListView.builder(
        itemCount: jumlahListPage,
        itemBuilder: (context, index) {
          return Card(
            color: const Color.fromRGBO(238, 242, 249, 1),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
                borderRadius: const BorderRadius.all(Radius.zero),
                onTap: () {
                  productDetailFakeStore(
                      docImageList[index],
                      docNameList[index],
                      docPriceList[index],
                      docRateList[index],
                      docDescList[index]);
                },
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: heightCard / 6.123076923,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(
                            10,
                          ),
                          bottomLeft: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(docImageList[index]),
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    )),
                    Expanded(
                        child: Container(
                            height: heightCard / 6.123076923,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(docNameList[index],
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10 * textScale,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    )),
                                Text(docDescList[index],
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 6 * textScale,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    )),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                        CurrencyFormat.convertToDolar(
                                            docPriceList[index], 2),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 10 * textScale,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500)),
                                    const Spacer(),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.green,
                                    ),
                                    Text(docRateList[index].toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10 * textScale,
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
        },
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        controller: ScrollController(keepScrollOffset: false),
      ),
    );
  }

  _showBottomModal(context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    final heightCard = MediaQuery.of(context).size.height;
    final widthCard = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return Container(
                height: heightCard / 4,
                color: Colors.transparent,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(20, 29, 46, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius:
                            10.0, // has the effect of softening the shadow
                        spreadRadius:
                            0.0, // has the effect of extending the shadow
                      )
                    ],
                  ),
                  alignment: Alignment.topLeft,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            widthCard / 19.5,
                            heightCard / 99.5,
                            widthCard / 19.5,
                            heightCard / 159.2),
                        child: Text(
                          "Filter",
                          style: TextStyle(
                              fontFamily: 'Outfit',
                              color: const Color.fromRGBO(238, 242, 249, 1),
                              fontSize: 19 * textScale,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            widthCard / 19.5,
                            heightCard / 159.2,
                            widthCard / 19.5,
                            heightCard / 159.2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Document Type",
                                  style: TextStyle(
                                      fontFamily: 'Outfit',
                                      fontSize: 17 * textScale,
                                      color: const Color.fromRGBO(
                                          238, 242, 249, 1),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            SizedBox(
                              height: heightCard / 159.2,
                            ),
                            Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor:
                                      const Color.fromRGBO(20, 29, 46, 1),
                                ),
                                child: DropdownButton(
                                  value: pilihtype,
                                  isExpanded: true,
                                  underline: Container(
                                      height: heightCard / 398,
                                      color: const Color.fromRGBO(
                                          238, 242, 249, 1)),
                                  onChanged: (value) {
                                    setState(() {
                                      pilihtype = value.toString();
                                    });
                                  },
                                  items: listtype.map((valueItem) {
                                    return DropdownMenuItem<String>(
                                      value: valueItem,
                                      child: Text(
                                        valueItem,
                                        style: TextStyle(
                                            fontFamily: 'Outfit',
                                            fontSize: 16 * textScale,
                                            color: const Color.fromRGBO(
                                                238, 242, 249, 1),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    );
                                  }).toList(),
                                )),
                            Center(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize:
                                    Size(widthCard / 3.9, heightCard / 19.9),
                                primary: const Color.fromRGBO(251, 211, 9, 1),
                              ),
                              onPressed: () {
                                Get.back();
                                refreshData();
                              },
                              child: Text('SEARCH',
                                  style: TextStyle(
                                      fontFamily: 'Outfit',
                                      fontSize: 12 * textScale,
                                      color:
                                          const Color.fromRGBO(20, 29, 46, 1),
                                      fontWeight: FontWeight.w700)),
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }

  Future<void> productDetail(
      String id, String name, int price, int rate, String desc) async {
    final textScale = MediaQuery.of(context).textScaleFactor;
    final heightCard = MediaQuery.of(context).size.height;
    final widthCard = MediaQuery.of(context).size.width;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: widthCard,
                      height: heightCard / 3,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            5,
                          ),
                          topRight: Radius.circular(5),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/watch.jpg"),
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close),
                            color: Colors.red[100],
                            iconSize: 35,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Get.back();
                            },
                          )
                        ],
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: TextStyle(
                                fontSize: 14 * textScale,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700)),
                        Text(desc,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 9 * textScale,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(CurrencyFormat.convertToIdr(price, 2),
                              style: TextStyle(
                                fontSize: 12 * textScale,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              )),
                          const Spacer(),
                          const Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          Text(rate.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12 * textScale,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      )),
                ],
              )),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  deleteDoc(context, id);
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text('Delete',
                  style: TextStyle(
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      fontSize: 16 * textScale,
                      color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Get.offAndToNamed('/editproduct', arguments: id);
                });
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(238, 242, 249, 1),
              ),
              child: Text('Update',
                  style: TextStyle(
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      fontSize: 16 * textScale,
                      color: const Color.fromRGBO(20, 29, 46, 1))),
            )
          ],
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
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

  Future<void> productDetailFakeStore(
      String image, String name, double price, double rate, String desc) async {
    final textScale = MediaQuery.of(context).textScaleFactor;
    final heightCard = MediaQuery.of(context).size.height;
    final widthCard = MediaQuery.of(context).size.width;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: widthCard,
                      height: heightCard / 3,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(
                            5,
                          ),
                          topRight: Radius.circular(5),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(image),
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close),
                            color: Colors.red[100],
                            iconSize: 35,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Get.back();
                            },
                          )
                        ],
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: TextStyle(
                                fontSize: 14 * textScale,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700)),
                        Text(desc,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 9 * textScale,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(CurrencyFormat.convertToDolar(price, 2),
                              style: TextStyle(
                                fontSize: 12 * textScale,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              )),
                          const Spacer(),
                          const Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          Text(rate.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12 * textScale,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      )),
                ],
              )),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
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
    return Card(
      color: const Color.fromRGBO(238, 242, 249, 1),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
          borderRadius: const BorderRadius.all(Radius.zero),
          onTap: () {
            productDetail(product.id, product.name, product.price, product.rate,
                product.desc);
          },
          child: Row(
            children: [
              Expanded(
                  child: Container(
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
              )),
              Expanded(
                  child: Container(
                      height: heightCard / 6.123076923,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(product.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10 * textScale,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              )),
                          Text(product.desc,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 6 * textScale,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              )),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                  CurrencyFormat.convertToIdr(product.price, 2),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10 * textScale,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500)),
                              const Spacer(),
                              const Icon(
                                Icons.star,
                                color: Colors.green,
                              ),
                              Text(product.rate.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10 * textScale,
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

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geek_garden/home/controller/home_controller.dart';
import 'package:get/get.dart';

final GlobalKey<State> _keyLoader = GlobalKey<State>();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            15, heightCard / 159.2, 15, heightCard / 159.2),
                        child: Column(children: [
                          Wrap(
                              direction: Axis.horizontal,
                              spacing: 1.0,
                              runSpacing: 3.0,
                              children: [
                                // buildListData(),
                                Container(
                                  height: isLoading ? heightCard / 15.92 : 0,
                                  color: Colors.transparent,
                                  child: const Center(
                                    child: LinearProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color.fromRGBO(255, 255, 255, 1)),
                                      minHeight: 10,
                                    ),
                                  ),
                                ),
                              ]),
                        ]),
                      ),
                    ),
                  ]),
            )),
        floatingActionButton: OpenContainer(closedBuilder: (context, action) {
          return Container(
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
                  )));
        }, openBuilder: (context, action) {
          namaProduk.text = "";
          hargaProduk.text = "";
          rateProduk.text = "";
          deskripsiProduk.text = "";

          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 12, 0),
                  child: Text('Create Produk',
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
                // leadingWidth: 100,
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
                        image:
                            const AssetImage("assets/images/Batik_Light.png"),
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
                          margin:
                              EdgeInsets.only(bottom: heightCard / 68.34285714),
                          child: TextField(
                            style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 15 * textScale,
                                fontWeight: FontWeight.w400),
                            controller: namaProduk,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                fillColor:
                                    const Color.fromRGBO(225, 227, 231, 1),
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
                          margin:
                              EdgeInsets.only(bottom: heightCard / 68.34285714),
                          child: TextField(
                            style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 15 * textScale,
                                fontWeight: FontWeight.w400),
                            controller: hargaProduk,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                fillColor:
                                    const Color.fromRGBO(225, 227, 231, 1),
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
                          margin:
                              EdgeInsets.only(bottom: heightCard / 68.34285714),
                          child: TextField(
                            style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 15 * textScale,
                                fontWeight: FontWeight.w400),
                            controller: rateProduk,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                fillColor:
                                    const Color.fromRGBO(225, 227, 231, 1),
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
                            controller: deskripsiProduk,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15)),
                                fillColor:
                                    const Color.fromRGBO(225, 227, 231, 1),
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
                                InsertCheckin(context);
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
        }));
  }

  // ignore: non_constant_identifier_names
  void InsertCheckin(BuildContext context) {
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
              onPressed: () => insertProduct(),
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

  Future insertProduct() async {
    var jmlError = 0;
    var msgError = [];

    if (namaProduk.text == "") {
      jmlError++;
      msgError.add("Product Name cannot be empty");
    }

    // ignore: unrelated_type_equality_checks
    if (hargaProduk == "") {
      jmlError++;
      msgError.add("Product Price cannot be empty");
    }

    if (jmlError == 0) {
      showLoadingDialog(context, _keyLoader);
      return await HomeController.createProduct(
              namaProduk.text,
              int.parse(hargaProduk.text),
              int.parse(rateProduk.text),
              deskripsiProduk.text)
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
      isLoading = false;
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

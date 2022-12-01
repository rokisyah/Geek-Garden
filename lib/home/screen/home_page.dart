import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
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
                color: Color.fromRGBO(255, 255, 255, 1),
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
                  color: Color.fromRGBO(255, 255, 255, 1),
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
              color: Color.fromRGBO(20, 29, 46, 1),
              image: DecorationImage(
                fit: BoxFit.fill,
                opacity: 0.05,
                colorFilter: ColorFilter.mode(
                    Color.fromRGBO(20, 29, 46, 1).withOpacity(1),
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
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobailshop/UI/Reports/reports_screen.dart';
import 'package:mobailshop/UI/addproduct/addproduct_screen.dart';
import 'package:mobailshop/UI/chat/home.dart';
import 'package:mobailshop/mainaccont.dart';
import 'package:mobailshop/UI/more/more_screen.dart';
import 'package:mobailshop/UI/order/order_screen.dart';
import 'package:mobailshop/UI/widget/bottombar.dart';

import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/provider/auth_provider.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/images.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UI/auth/widget/sign_in_widget.dart';

bool isVisible = false;
ScrollController controller = ScrollController();

class MainShop extends StatefulWidget {
  var photourl;
  MainShop({
    this.photourl,
  });
  @override
  _MainShopState createState() => _MainShopState();
}

enum BottomIcons {
  Home,
  SHopHome,
  Add,
  Insert_Chart,
  Insert_ChartShop,
  Search,
  SettingShop,
  Setting,
  Store_sharp,
  Notifications_outlined,
  Notifications_outlinedShop,
  OrderShop,
  Orderuser
}

class _MainShopState extends State<MainShop> {
  // late SocketIOManager manager;

  @override
  void initState() {
    super.initState();

    bottomIconssla(context);

    // updatePalettes(imageSize);
    setsingInGuest();
    isVisible = true;
    hide;
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (isVisible) {
          setState(() {
            isVisible = false;
          });
        }
      }
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        if (!isVisible) {
          setState(() {
            isVisible = true;
          });
        }
      }
    });
  }

  setsingInGuest() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('Guest', singInGuest);
    print(singInGuest);
    return singInGuest;
  }

  bottomIconssla(BuildContext context) {
    String getUserType =
        Provider.of<AuthProvider>(context, listen: false).getUserType();
    bottomIcons =
        getUserType == 'admin' ? BottomIcons.SHopHome : BottomIcons.Home;
  }

  late BottomIcons bottomIcons;

  bool hide = true;

  @override
  Widget build(BuildContext context) {
    String getUserType =
        Provider.of<AuthProvider>(context, listen: false).getUserType();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          bottomIcons == BottomIcons.SHopHome
              ? AccontMain(
                  photourl: widget.photourl,
                )
              : Container(),
          bottomIcons == BottomIcons.Home
              ? Center(
                  child: Text(
                    "Hi, this is favorite page",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Container(),
          bottomIcons == BottomIcons.Add ? Addproduct() : Container(),
          bottomIcons == BottomIcons.Home
              ? Center(
                  child: Text(
                    "Hi, this is favorite page",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Container(),
          bottomIcons == BottomIcons.Notifications_outlined
              ? Center(
                  child: Text(
                    "Hi, this is favorite page",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Container(),
          bottomIcons == BottomIcons.Store_sharp
              ? Center(
                  child: Text(
                    "Hi, this is favorite page",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Container(),
          bottomIcons == BottomIcons.Notifications_outlinedShop
              ? Center(
                  child: FutureBuilder(
                      future: Firebase.initializeApp(),
                      builder: (context, snapshot) {
                        return Home();
                      }))
              : Container(),
          bottomIcons == BottomIcons.Insert_Chart
              ? Center(
                  child: Text(
                    "Hi, this is favorite page",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Container(),
          bottomIcons == BottomIcons.Insert_ChartShop
              ? Center(
                  child: ReportsScreen(),
                )
              : Container(),
          bottomIcons == BottomIcons.Setting
              ? Center(
                  child: Text(
                    "Hi, this is search page",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Container(),
          bottomIcons == BottomIcons.SettingShop
              ? Center(
                  child: MoreScreen(),
                )
              : Container(),
          bottomIcons == BottomIcons.OrderShop
              ? Center(child: OrderScreen())
              : Container(),
          getUserType == 'admin'
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    height: isVisible ? ScreenUtil().setHeight(80) : 0.0,
                    child: isVisible
                        ? Container(
                            decoration: BoxDecoration(
                                color: Color(0xABFFFFFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(36)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 3,
                                      offset: Offset(0, 3))
                                ]),
                            height: 70,
                            margin: EdgeInsets.only(
                                left: 30, right: 30, bottom: 30),
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  BottomBar(
                                    onPressed: () {
                                      setState(() {
                                        bottomIcons = BottomIcons.SHopHome;
                                      });
                                    },
                                    color: ColorResources.red0001,
                                    bottomIcons:
                                        bottomIcons == BottomIcons.SHopHome
                                            ? true
                                            : false,
                                    image: Images.home_image,
                                    text: getTranslated('home', context),
                                  ),
                                  BottomBar(
                                      onPressed: () {
                                        setState(() {
                                          bottomIcons = BottomIcons.OrderShop;
                                        });
                                      },
                                      color: ColorResources.red0001,
                                      bottomIcons:
                                          bottomIcons == BottomIcons.OrderShop
                                              ? true
                                              : false,
                                      image: Images.shopping_image,
                                      text: getTranslated('orders', context)),
                                  BottomBar(
                                      onPressed: () {
                                        setState(() {
                                          bottomIcons = BottomIcons.Add;
                                        });
                                      },
                                      color: ColorResources.red0001,
                                      bottomIcons:
                                          bottomIcons == BottomIcons.Add
                                              ? true
                                              : false,
                                      image: Images.add,
                                      text: "أضافة سلعة"),
                                  BottomBar(
                                      onPressed: () {
                                        setState(() {
                                          bottomIcons = BottomIcons
                                              .Notifications_outlinedShop;
                                        });
                                        // Provider.of<ChatProvider>(context,
                                        //         listen: false)
                                        //     .initChatList(context);
                                        // socketServer();
                                      },
                                      color: ColorResources.red0001,
                                      bottomIcons: bottomIcons ==
                                              BottomIcons
                                                  .Notifications_outlinedShop
                                          ? true
                                          : false,
                                      image: Images.CHAT,
                                      text: getTranslated('inbox', context)),
                                  BottomBar(
                                      onPressed: () {
                                        setState(() {
                                          bottomIcons =
                                              BottomIcons.Insert_ChartShop;
                                        });
                                      },
                                      color: ColorResources.red0001,
                                      bottomIcons: bottomIcons ==
                                              BottomIcons.Insert_ChartShop
                                          ? true
                                          : false,
                                      image: Images.report,
                                      text: "التقارير"),
                                  BottomBar(
                                      onPressed: () {
                                        setState(() {
                                          bottomIcons = BottomIcons.SettingShop;
                                        });
                                      },
                                      color: ColorResources.red0001,
                                      bottomIcons:
                                          bottomIcons == BottomIcons.SettingShop
                                              ? true
                                              : false,
                                      image: Images.more_image,
                                      text: getTranslated('more', context)),
                                ],
                              ),
                            ))
                        : Container(),
                  ))
              : Align(
                  alignment: Alignment.bottomRight,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    height: isVisible ? ScreenUtil().setHeight(80) : 0.0,
                    child: isVisible
                        ? Container(
                            decoration: BoxDecoration(
                                color: Color(0xABFFFFFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(36)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 3,
                                      offset: Offset(0, 3))
                                ]),
                            height: 70,
                            margin: EdgeInsets.only(
                                left: 30, right: 30, bottom: 30),
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  BottomBar(
                                    onPressed: () {
                                      setState(() {
                                        bottomIcons = BottomIcons.Home;
                                      });
                                    },
                                    color: ColorResources.red0001,
                                    bottomIcons: bottomIcons == BottomIcons.Home
                                        ? true
                                        : false,
                                    image: Images.home_image,
                                    text: 'الرئيسية',
                                  ),
                                  BottomBar(
                                      onPressed: () {
                                        setState(() {
                                          bottomIcons = BottomIcons
                                              .Notifications_outlined;
                                        });
                                      },
                                      color: ColorResources.red0001,
                                      bottomIcons: bottomIcons ==
                                              BottomIcons.Notifications_outlined
                                          ? true
                                          : false,
                                      image: Images.CHAT,
                                      text: "الرسائل"),
                                  BottomBar(
                                      onPressed: () {
                                        setState(() {
                                          bottomIcons = BottomIcons.Store_sharp;
                                        });
                                      },
                                      color: ColorResources.red0001,
                                      bottomIcons:
                                          bottomIcons == BottomIcons.Store_sharp
                                              ? true
                                              : false,
                                      image: Images.splash_logo,
                                      text: "المتاجر"),
                                  BottomBar(
                                      onPressed: () {
                                        setState(() {
                                          bottomIcons =
                                              BottomIcons.Insert_Chart;
                                        });
                                      },
                                      color: ColorResources.red0001,
                                      bottomIcons: bottomIcons ==
                                              BottomIcons.Insert_Chart
                                          ? true
                                          : false,
                                      image: Images.logo,
                                      text: "التقارير"),
                                  BottomBar(
                                      onPressed: () {
                                        setState(() {
                                          bottomIcons = BottomIcons.Setting;
                                        });
                                      },
                                      color: ColorResources.red0001,
                                      bottomIcons:
                                          bottomIcons == BottomIcons.Setting
                                              ? true
                                              : false,
                                      image: Images.settings,
                                      text: "اعدادات"),
                                ],
                              ),
                            ))
                        : Container(),
                  ))
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobailshop/UI/product/product_screen.dart';
import 'package:mobailshop/UI/widget/no_internet_screen.dart';
import 'package:mobailshop/main.dart';
import 'provider/get_shop_provider.dart';
import 'package:mobailshop/provider/order_provider.dart';
import 'package:mobailshop/provider/product_provider.dart';

import 'package:mobailshop/localization/language_constrants.dart';

import 'package:mobailshop/sryle.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/utill/dimensions.dart';
import 'package:mobailshop/utill/images.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:http_parser/http_parser.dart';

import 'UI/addproduct/addproduct_screen.dart';

late File imageget;
final ScrollController scrollController = ScrollController();

class AccontMain extends StatefulWidget {
  var photourl;
  var palettecolor;
  AccontMain({this.photourl, this.palettecolor});
  @override
  _AccontMainState createState() => _AccontMainState();
}

late String shopname;

class _AccontMainState extends State<AccontMain> {
  // late GetAccontBloc bloc;

  final GlobalKey imageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Provider.of<GetShopProvider>(context, listen: false).getShopList(context);
    shopid = Provider.of<GetShopProvider>(context, listen: false).getShopid();
    print("idsh$shopid");
    shopname =
        Provider.of<GetShopProvider>(context, listen: false).getShopname();
    print("namesh$shopname");
  }

  final bool isHomeScreen = true;
  Future<void> _loadData(BuildContext context, bool reload) async {
    await Provider.of<GetShopProvider>(context, listen: false)
        .getShopList(context);
    // await Provider.of<CategoryProvider>(context, listen: false).getCategoryList(reload, context);
    // await Provider.of<FlashDealProvider>(context, listen: false).getMegaDealList(reload, context);
    // await Provider.of<BrandProvider>(context, listen: false).getBrandList(reload, context);
    await Provider.of<ProductProvider>(context, listen: false)
        .getLatestProductList(context, shopid);
  }

  String image1 =
      "/data/user/0/com.necn.mobailshop/cache/image_picker6087156060929823821.jpg";

  Widget build(BuildContext context) {
    Provider.of<OrderProvider>(context, listen: false).getOrder(context);
    // GetShopModel _getShopMol =
    //     Provider.of<GetShopProvider>(context, listen: false).getshop;

    //

    return Scaffold(
        body: SafeArea(
            child: RefreshIndicator(
                backgroundColor: ColorResources.getRed(context),
                onRefresh: () async {
                  await _loadData(context, true);
                  // return true;
                },
                child: CustomScrollView(controller: scrollController, slivers: [
                  SliverAppBar(
                    floating: true,
                    elevation: 0,
                    centerTitle: false,
                    automaticallyImplyLeading: false,
                    backgroundColor: ColorResources.backgrond,
                    title: Image.asset(Images.logo_with_name_image,
                        height: ScreenUtil().setHeight(35),
                        color: ColorResources.getRed(context)),
                    actions: [
                      IconButton(
                        onPressed: () {
                          // saveaccont();
                        },
                        icon: Stack(clipBehavior: Clip.none, children: [
                          Image.asset(
                            Images.cart_arrow_down_image,
                            height: ScreenUtil()
                                .setHeight(Dimensions.ICON_SIZE_DEFAULT),
                            width: ScreenUtil()
                                .setWidth(Dimensions.ICON_SIZE_DEFAULT),
                            color: ColorResources.getRed(context),
                          ),
                          Positioned(
                            top: ScreenUtil().setSp(-4),
                            right: -4,
                            child: CircleAvatar(
                              radius: ScreenUtil().setSp(7),
                              backgroundColor: ColorResources.RED,
                              child: Text(
                                  // Provider.of<CartProvider>(context)
                                  //     .cartList
                                  //     .length
                                  //     .toString()
                                  'hsafdk',
                                  style: titilliumSemiBold.copyWith(
                                    color: ColorResources.WHITE,
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                  )),
                            ),
                          ),
                        ]),
                      )
                    ],
                  ),
                  SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverDelegate(
                        child: InkWell(
                          // onTap: () => Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) => SearchScreen())),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_SMALL,
                                vertical: 2),
                            color: ColorResources.getRed(context),
                            alignment: Alignment.center,
                            child: Container(
                              padding:
                                  EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              height: ScreenUtil().setHeight(50),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: ColorResources.backgrond,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.PADDING_SIZE_SMALL),
                              ),
                              child: Row(children: [
                                Icon(Icons.search,
                                    color: ColorResources.getRed(context),
                                    size: Dimensions.ICON_SIZE_LARGE),
                                SizedBox(width: ScreenUtil().setWidth(5)),
                                Text(getTranslated('SEARCH_HINT', context),
                                    style: robotoRegular.copyWith(
                                        color: Theme.of(context).hintColor)),
                              ]),
                            ),
                          ),
                        ),
                      )),
                  SliverToBoxAdapter(child: Consumer<GetShopProvider>(
                      builder: (context, getshopProvider, child) {
                    // print('length ${getshopProvider.getshopList.length}');
                    return getshopProvider.status == true
                        ? Container(
                            padding: EdgeInsets.all(ScreenUtil().setSp(10)),
                            decoration: BoxDecoration(
                              color: ColorResources.backgrond,
                            ),
                            child: Column(
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: ScreenUtil().setHeight(330),
                                      // color: Colors.blue,
                                    ),
                                    Container(
                                        color: ColorResources.getRed(context),
                                        padding: EdgeInsets.all(3),
                                        height: ScreenUtil().setHeight(250),
                                        child: ImageSlideshow(
                                          // width: double.infinity,
                                          height: ScreenUtil().setHeight(200),
                                          initialPage: 0,
                                          indicatorColor: Colors.blue,
                                          indicatorBackgroundColor: Colors.grey,
                                          children: [
                                            Image.asset(
                                              'assets/images/not21.png',
                                              fit: BoxFit.cover,
                                            ),
                                            Image.asset(
                                              'assets/images/rosia.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                            Image.asset(
                                              'assets/images/Sadidly.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                          onPageChanged: (value) {
                                            // print('Page changed: $value');
                                          },
                                          autoPlayInterval: 10000,
                                        )),
                                    Positioned(
                                      top: ScreenUtil().setSp(150),
                                      left: ScreenUtil().setSp(120),
                                      child: CircleAvatar(
                                        radius: ScreenUtil().setSp(80),
                                        backgroundColor: ColorResources.white,
                                        child: InkWell(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            radius: ScreenUtil().setSp(75),
                                            backgroundColor:
                                                ColorResources.white,
                                            backgroundImage: NetworkImage(
                                              "http://172.16.0.6:3001/uploads/avatars/${getshopProvider.getshop.logo}",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: ScreenUtil().setSp(210),
                                      left: ScreenUtil().setSp(240),
                                      child: CircleAvatar(
                                        radius: ScreenUtil().setSp(22),
                                        backgroundColor: Colors.grey[300],
                                        child: IconButton(
                                          icon: Icon(Icons.camera_enhance),
                                          onPressed: () {
                                            getImage(image1);
                                            print(getshopProvider.getshop.logo);
                                          },
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().setSp(10))),
                                      child: Container(
                                        width: ScreenUtil().setWidth(70),
                                        height: ScreenUtil().setHeight(50),
                                        color: ColorResources.getRed(context),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.message,
                                              color: ColorResources.white,
                                              size:
                                                  Dimensions.ICON_SIZE_DEFAULT,
                                            ),
                                            SizedBox(
                                              width: ScreenUtil().setWidth(5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().setSp(10))),
                                      child: Container(
                                        width: ScreenUtil().setWidth(70),
                                        height: ScreenUtil().setHeight(50),
                                        color: ColorResources.getRed(context),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.favorite,
                                                size: Dimensions
                                                    .ICON_SIZE_DEFAULT,
                                              ),
                                              onPressed: () async {
                                                print("token$getUserToken");
                                                String failname = imageget.path
                                                    .split('/')
                                                    .last;
                                                var response = await Dio().put(
                                                    'http://172.16.0.6:3001/api/v1/auth/avatar',
                                                    options: Options(
                                                      headers: {
                                                        'Content-Type':
                                                            'application/json',
                                                        'Authorization':
                                                            'Bearer $getUserToken',
                                                      },
                                                    ),
                                                    data: FormData.fromMap({
                                                      "avatar":
                                                          await MultipartFile
                                                              .fromFile(
                                                        imageget.path,
                                                        filename: failname,
                                                        contentType: MediaType(
                                                            "image", "jpg"),
                                                      ),
                                                    }));

                                                final data = response.data;

                                                if (response.statusCode ==
                                                    200) {
                                                  print('data : ${data}');
                                                  // photourl = data['photourl'];
                                                  // return data;
                                                } else {
                                                  return print('data : $data');
                                                }
                                              },
                                              color: ColorResources.white,
                                            ),
                                            SizedBox(
                                              width: ScreenUtil().setWidth(5),
                                            ),
                                            Center(
                                              child: Text(
                                                "${getshopProvider.getshop.subscriber}",
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(16),
                                                  color: ColorResources.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: Container(
                                        width: ScreenUtil().setWidth(200),
                                        height: ScreenUtil().setHeight(50),
                                        color: ColorResources.getRed(context),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            CircleAvatar(
                                                backgroundColor:
                                                    ColorResources.white,
                                                radius: 12,
                                                child: Icon(
                                                  Icons.add,
                                                  size: Dimensions
                                                      .ICON_SIZE_DEFAULT,
                                                  color: ColorResources.getRed(
                                                      context),
                                                )),
                                            SizedBox(
                                              width: ScreenUtil().setWidth(15),
                                            ),
                                            Text(
                                              "اضافة سلعة جديدة",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: ColorResources.white,
                                                fontFamily: 'Roboto',
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                sizedbox,
                                Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                          Text(
                                            getshopProvider.getshop.address,
                                            style: robotoRegular,
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(10),
                                          ),
                                          Icon(
                                            Icons.location_pin,
                                            size: Dimensions.ICON_SIZE_DEFAULT,
                                            color:
                                                ColorResources.getRed(context),
                                          ),
                                        ])),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(20),
                                    ),
                                    Expanded(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                          Text(
                                            getshopProvider.getshop.nameShop,
                                            style: robotoRegular,
                                          ),
                                          Icon(
                                            Icons.account_circle_rounded,
                                            size: Dimensions.ICON_SIZE_DEFAULT,
                                            color:
                                                ColorResources.getRed(context),
                                          ),
                                        ])),
                                  ],
                                ),
                                sizedbox,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                          Text(
                                            getshopProvider.getshop.phone,
                                            style: robotoRegular,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.phone,
                                            size: Dimensions.ICON_SIZE_DEFAULT,
                                            color:
                                                ColorResources.getRed(context),
                                          ),
                                        ])),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(20),
                                    ),
                                    Expanded(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                          Text(
                                            getshopProvider.getshop.phone,
                                            style: robotoRegular,
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(10),
                                          ),
                                          Icon(
                                            Icons.phone,
                                            size: Dimensions.ICON_SIZE_DEFAULT,
                                            color:
                                                ColorResources.getRed(context),
                                          ),
                                        ])),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(10),
                                ),
                                ProductScreen(),

                                // GridView.builder(gridDelegate: gridDelegate, itemBuilder:state.posts.data),
                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: FadeAnimation(
                                //           1.5,
                                //           makeItem(
                                //             image: 'assets/images/not21.png',
                                //             tag: 'red',
                                //             context: context,
                                //             color: Color(0xffbc092a),
                                //             // widget.palettecolor ?? Color(0xFF5F4747),
                                //           )),
                                //     ),
                                //     // sizedbox,
                                //     SizedBox(
                                //       width: ScreenUtil().setWidth(10),
                                //     ),
                                //     Expanded(
                                //       child: FadeAnimation(
                                //           1.5,
                                //           makeItem(
                                //             image:
                                //                 'assets/images/note 20.1.png',
                                //             tag: 'red',
                                //             context: context,
                                //             //  Color(0xffbc092a)
                                //             color: widget.palettecolor ??
                                //                 Color(0xFFCECECE),
                                //             //  ColorResources.getRed(context),
                                //           )),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ))
                        : NoInternetOrDataScreen(
                            onPressed: () {
                              Provider.of<GetShopProvider>(context,
                                      listen: false)
                                  .getShopList(context);
                              shopid = Provider.of<GetShopProvider>(context,
                                      listen: false)
                                  .getShopid();
                              print("idsh$shopid");
                              shopname = Provider.of<GetShopProvider>(context,
                                      listen: false)
                                  .getShopname();
                              print("namesh$shopname");
                            },
                            isNoInternet: true,
                            child: Container(
                              height: ScreenUtil().setHeight(600),
                            ));
                  }))
                ]))));
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}

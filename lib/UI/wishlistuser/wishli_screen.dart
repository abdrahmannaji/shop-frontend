import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobailshop/UI/order/widget/order_widget.dart';
import 'package:mobailshop/UI/widget/custom_app_bar.dart';
import 'package:mobailshop/helper/date_converter.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/provider/theme_provider.dart';
import 'package:mobailshop/provider/theme_provider.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/utill/dimensions.dart';
import 'package:mobailshop/utill/images.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class WishliScreen extends StatefulWidget {
  @override
  _WishliScreenState createState() => _WishliScreenState();
}

class _WishliScreenState extends State<WishliScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.getIconBg(context),
        body: Container(
          color: Theme.of(context).accentColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                  onActionPressed: () {},
                  title: getTranslated('wishlistuser', context),
                  isBackButtonExist: true),
              // Container(height: 10, width: 150, color: ColorResources.WHITE),
              Expanded(
                  child: RefreshIndicator(
                backgroundColor: Theme.of(context).primaryColor,
                onRefresh: () async {
                  // await order.getOrder(context);
                },
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) => Container(
                    height: 160,
                    width: 400,
                    margin: EdgeInsets.only(left: 14, right: 14, bottom: 20),
                    // padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      // color: ColorResources.COLOR_PRIMARY,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[
                                Provider.of<ThemeProvider>(context).darkTheme
                                    ? 800
                                    : 200]!,
                            spreadRadius: 0.5,
                            blurRadius: 0.3)
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Container(
                        //   margin: EdgeInsets.only(right: 14, left: 14),
                        //   decoration: BoxDecoration(
                        //     color: Color(0x70CCCCCC),
                        //     borderRadius: BorderRadius.all(
                        //       Radius.circular(ScreenUtil().setSp(5)),
                        //     ),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         offset: Offset.infinite,
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: ColorResources.WHITE,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(12)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: ColorResources.WHITE,
                                              spreadRadius: 1,
                                              blurRadius: 0.9)
                                        ],
                                      ),
                                      child: Row(children: [
                                        Text('أسم العميل',
                                            style: titilliumBold.copyWith(
                                                color: ColorResources
                                                    .HINT_TEXT_COLOR,
                                                //  ColorResources.HINT_Whet,
                                                fontSize: 14)),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(':',
                                            style: titilliumBold.copyWith(
                                                color: ColorResources
                                                    .HINT_TEXT_COLOR,
                                                fontSize: 14)),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('عبد الرحمن ناجي',
                                            style: titilliumBold.copyWith(
                                                fontSize: 16,
                                                color: ColorResources.BLACK)),
                                      ])),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: ColorResources.WHITE,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: ColorResources.WHITE,
                                            spreadRadius: 1,
                                            blurRadius: 0.9)
                                      ],
                                    ),
                                    child: Row(children: [
                                      Text('أسم الهاتف',
                                          style: titilliumBold.copyWith(
                                              color: ColorResources
                                                  .HINT_TEXT_COLOR,
                                              fontSize: 14)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(':',
                                          style: titilliumBold.copyWith(
                                              color: ColorResources
                                                  .HINT_TEXT_COLOR,
                                              fontSize: 14)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('سامسونج 21 الترا',
                                          style: titilliumBold.copyWith(
                                              fontSize: 16,
                                              color: ColorResources.BLACK)),
                                    ]),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: ColorResources.WHITE,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: ColorResources.WHITE,
                                            spreadRadius: 1,
                                            blurRadius: 0.9)
                                      ],
                                    ),
                                    child: Row(children: [
                                      Text('سعر الهاتف',
                                          style: titilliumBold.copyWith(
                                              color: ColorResources
                                                  .HINT_TEXT_COLOR,
                                              fontSize: 14)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(':',
                                          style: titilliumBold.copyWith(
                                              color: ColorResources
                                                  .HINT_TEXT_COLOR,
                                              fontSize: 14)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('1200\$',
                                          style: titilliumBold.copyWith(
                                              fontSize: 16,
                                              color: ColorResources.BLACK)),
                                    ]),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: ColorResources.WHITE,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: ColorResources.WHITE,
                                            spreadRadius: 1,
                                            blurRadius: 0.9)
                                      ],
                                    ),
                                    child: Row(children: [
                                      Text('المتجر',
                                          style: titilliumBold.copyWith(
                                              color: ColorResources
                                                  .HINT_TEXT_COLOR,
                                              fontSize: 14)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(':',
                                          style: titilliumBold.copyWith(
                                              color: ColorResources
                                                  .HINT_TEXT_COLOR,
                                              fontSize: 14)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('سامي فون',
                                          style: titilliumBold.copyWith(
                                              fontSize: 16,
                                              color: ColorResources.BLACK)),
                                    ]),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: ColorResources.WHITE,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12)),
                                ),
                                height: 100,
                                width: 100,
                                child: Image.asset("${Images.not}"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
          // ),
        ));
  }
}

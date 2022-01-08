import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobailshop/UI/Reports/smallPages/coupons.dart';
import 'package:mobailshop/UI/Reports/smallPages/productsales.dart';
import 'package:mobailshop/UI/Reports/smallPages/salescategory.dart';
import 'package:mobailshop/UI/Reports/smallPages/theSales.dart';
import 'package:mobailshop/UI/Reports/widget/report-type-button.dart';
import 'package:mobailshop/UI/widget/custom_app_bar.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/provider/order_provider.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/dimensions.dart';
import 'package:mobailshop/utill/images.dart';
import 'package:provider/provider.dart';

class SalesReports extends StatefulWidget {
  @override
  _SalesReportsState createState() => _SalesReportsState();
}

class _SalesReportsState extends State<SalesReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.getHomeBg(context),
        body: Consumer<OrderProvider>(builder: (context, order, child) {
          return Column(children: [
            CustomAppBar(
                icon: Icons.analytics_outlined,
                title: getTranslated('Sales Reports', context),
                isBackButtonExist: true),
            Container(
              color: ColorResources.getPrimary(context),
              height: 70,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                  vertical: Dimensions.PADDING_SIZE_SMALL),
              child: ListView(
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  ReportTypeButton(
                    image: Images.increase,
                    text: getTranslated('theSales', context),
                    index: 0,
                    //ReportList:Report.orderList
                  ),
                  SizedBox(width: 5),
                  ReportTypeButton(
                    text: getTranslated('Products Sales', context),
                    index: 1,
                    //ReportList:Report.orderList
                  ),
                  SizedBox(width: 5),
                  // ReportTypeButton(
                  //   text: getTranslated('sales by category', context),
                  //   index: 2,
                  //   //ReportList:Report.orderList
                  // ),

                  SizedBox(width: 5),
                  ReportTypeButton(
                    text: getTranslated('Coupons', context),
                    index: 3,
                    //ReportList:Report.orderList
                  ),

                  // SizedBox(width: 5),
                  //ReportTypeButton(
                  //   text: getTranslated('delivered', context),
                  //   index: 3,
                  //   // orderList: order.orderList
                  // ),
                  // SizedBox(width: 5),
                ],
              ),
            ),
            Expanded(
              child: order.orderTypeIndex == 0
                  ? TheSales()
                  : order.orderTypeIndex == 1
                      ? ProductsSales()
                      : order.orderTypeIndex == 2
                          ? SalesbyCategory()
                          : order.orderTypeIndex == 3
                              ? Coupons()
                              : TheSales(),
            ),
            // )
          ]);
        }));
  }
}

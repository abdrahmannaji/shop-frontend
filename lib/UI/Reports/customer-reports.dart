import 'package:flutter/material.dart';
import 'package:mobailshop/UI/widget/custom_app_bar.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/utill/dimensions.dart';

import 'widget/report-type-button.dart';

class CustomerReports extends StatefulWidget {
  @override
  _CustomerReportsState createState() => _CustomerReportsState();
}

class _CustomerReportsState extends State<CustomerReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      CustomAppBar(
          title: getTranslated('Customer Reports', context),
          isBackButtonExist: true),
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_SMALL,
            vertical: Dimensions.PADDING_SIZE_SMALL),
        child: SizedBox(
          height: 60,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              ReportTypeButton(
                text: getTranslated('Customers', context),
                index: 0,
                //ReportList:Report.orderList
              ),
              SizedBox(width: 5),
              ReportTypeButton(
                text: getTranslated('Guests', context),
                index: 1,
                //ReportList:Report.orderList
              ),
              SizedBox(width: 5),
              ReportTypeButton(
                text: getTranslated('Customer List', context),
                index: 2,
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
      )
    ]));
  }
}

import 'package:flutter/material.dart';

import 'package:mobailshop/UI/Reports/widget/report-type-button.dart';
import 'package:mobailshop/UI/widget/custom_app_bar.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/utill/dimensions.dart';

class StockReports extends StatefulWidget {
  @override
  _StockReportsState createState() => _StockReportsState();
}

class _StockReportsState extends State<StockReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
              title: getTranslated('Stock Reports', context),
              isBackButtonExist: true),
        ],
      ),
    );
  }
}

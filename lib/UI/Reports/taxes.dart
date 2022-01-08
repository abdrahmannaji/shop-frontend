import 'package:flutter/material.dart';

import 'package:mobailshop/UI/Reports/widget/report-type-button.dart';
import 'package:mobailshop/UI/widget/custom_app_bar.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/utill/dimensions.dart';

class TaxeReports extends StatefulWidget {
  @override
  _TaxesState createState() => _TaxesState();
}

class _TaxesState extends State<TaxeReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
              title: getTranslated('Taxes', context), isBackButtonExist: true),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobailshop/UI/Reports/customer-reports.dart';
import 'package:mobailshop/UI/Reports/stock-reports.dart';
import 'package:mobailshop/UI/Reports/SalesReports.dart';
import 'package:mobailshop/UI/Reports/taxes.dart';
import 'package:mobailshop/UI/widget/custom_app_bar.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/utill/dimensions.dart';
import 'package:mobailshop/utill/images.dart';

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  bool isBacButtonExist = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            CustomAppBar(
                title: getTranslated('Reports', context),
                isBackButtonExist: isBacButtonExist),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              SquareButton(
                  image: Images.customerreport,
                  title: getTranslated('Customer Reports', context),
                  navigateTo: CustomerReports()),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              SquareButton(
                  image: Images.salereport,
                  title: getTranslated('Sales Reports', context),
                  navigateTo: SalesReports()),
            ]),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              SquareButton(
                  image: Images.tax,
                  title: getTranslated('Taxes', context),
                  navigateTo: TaxeReports()),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              SquareButton(
                  image: Images.warehouse,
                  title: getTranslated('Stock Reports', context),
                  navigateTo: StockReports()),
            ])
          ],
        ),
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;

  SquareButton(
      {required this.image, required this.title, required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => navigateTo,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            transitionDuration: Duration(milliseconds: 500),
          )),
      // onTap: () => Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => navigateTo)),
      child: Column(children: [
        Container(
          width: width / 3,
          height: width / 3,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorResources.getPrimary(context),
          ),
          child: Image.asset(image, color: Theme.of(context).accentColor),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(title, style: titilliumRegular),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/utill/dimensions.dart';
import 'package:mobailshop/utill/images.dart';

class NoDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Images.no_data,
                width: MediaQuery.of(context).size.height * 0.22,
                height: MediaQuery.of(context).size.height * 0.22,
                color: Theme.of(context).primaryColor,
              ),
              Text(
                getTranslated('nothing_found', context),
                style: titilliumBold.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: MediaQuery.of(context).size.height * 0.023),
                textAlign: TextAlign.center,
              ),
            ]),
      ),
    );
  }
}

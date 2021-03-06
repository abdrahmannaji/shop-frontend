import 'package:flutter/material.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/utill/dimensions.dart';
import 'package:mobailshop/utill/images.dart';

class NoInternetOrDataScreen extends StatelessWidget {
  final bool isNoInternet;
  Function()? onPressed;
  Widget? child;
  NoInternetOrDataScreen(
      {required this.isNoInternet, this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(isNoInternet ? Images.no_internet : Images.no_data,
                width: 150, height: 150),
            Text(
                isNoInternet
                    ? getTranslated('OPPS', context)
                    : getTranslated('sorry', context),
                style: titilliumBold.copyWith(
                  fontSize: 30,
                  color: isNoInternet
                      ? Theme.of(context).textTheme.bodyText1!.color
                      : ColorResources.getColombiaBlue(context),
                )),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Text(
              isNoInternet ? 'No internet connection' : 'No data found',
              textAlign: TextAlign.center,
              style: titilliumRegular,
            ),
            SizedBox(height: 40),
            isNoInternet
                ? Container(
                    height: 45,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorResources.getYellow(context)),
                    child: TextButton(
                      onPressed: onPressed,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(getTranslated('RETRY', context),
                            style: titilliumSemiBold.copyWith(
                                color: Theme.of(context).accentColor,
                                fontSize: Dimensions.FONT_SIZE_LARGE)),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

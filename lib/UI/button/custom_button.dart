import 'package:flutter/material.dart';
import 'package:mobailshop/provider/theme_provider.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';

import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String buttonText;
  CustomButton({required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ColorResources.getBlue(context),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 1)),
            ],
            gradient:
                (Provider.of<ThemeProvider>(context).darkTheme || onTap == null)
                    ? null
                    : LinearGradient(colors: [
                        Theme.of(context).primaryColor,
                        ColorResources.getBlue(context),
                        ColorResources.getBlue(context),
                      ]),
            borderRadius: BorderRadius.circular(10)),
        child: Text(buttonText,
            style: titilliumSemiBold.copyWith(
              fontSize: 16,
              color: Theme.of(context).accentColor,
            )),
      ),
    );
  }
}

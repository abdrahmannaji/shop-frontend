import 'package:flutter/material.dart';

class PriceConverter {
  static String convertPrice(BuildContext context, double? price,
      {double? discount, String? discountType}) {
    if (discount != null && discountType != null) {
      if (discountType == 'amount' || discountType == 'flat') {
        price = price! - discount;
      } else if (discountType == 'percent' || discountType == 'percentage') {
        price = price! - ((discount / 100) * price);
      }
    }
    return '${(price! * (1))}';
  }

  // static double convertAmount(double amount, BuildContext context) {
  // return double.parse(
  // '${(amount * Provider.of<SplashProvider>(context).myCurrency.exchangeRate * (1 / Provider.of<SplashProvider>(context, listen: false).usdCurrency.exchangeRate)).toStringAsFixed(2)}');
  // }
}

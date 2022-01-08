import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobailshop/UI/order/order_details_screen.dart';
import 'package:mobailshop/data/model/response/order_model.dart';
import 'package:mobailshop/helper/date_converter.dart';
import 'package:mobailshop/helper/price_converter.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/utill/dimensions.dart';

class OrderWidget extends StatelessWidget {
  final Ordre orderModel;
  OrderWidget({required this.orderModel});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(
                  orderId: orderModel.id,
                  orderModel: orderModel,
                )));
      },
      child: Container(
        margin: EdgeInsets.only(
            bottom: Dimensions.PADDING_SIZE_SMALL,
            left: Dimensions.PADDING_SIZE_SMALL,
            right: Dimensions.PADDING_SIZE_SMALL),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(5)),
        child: Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              // Text(getTranslated('ORDER_ID', context),
              //     style: titilliumRegular.copyWith(
              //         fontSize: Dimensions.FONT_SIZE_SMALL)),
              // SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

              Text(orderModel.productModel.name, style: titilliumSemiBold),
              Text(":"),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text(orderModel.productModel.typePhone, style: titilliumSemiBold),
            ]),
            // Text(orderModel.id.toString(), style: titilliumSemiBold),
            Row(children: [
              Text(getTranslated('order_date', context),
                  style: titilliumRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_SMALL)),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text("${DateConverter.formatDate(orderModel.createdAt)}",
                  style: titilliumRegular.copyWith(
                    fontSize: Dimensions.FONT_SIZE_SMALL,
                    color: Theme.of(context).hintColor,
                  )),
            ]),
          ]),
          SizedBox(width: Dimensions.PADDING_SIZE_LARGE),

          Expanded(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                      color: ColorResources.getLowGreen(context),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(orderModel.orderStatus.toUpperCase(),
                        style: TextStyle(
                          color: orderModel.orderStatus == 'delivered'
                              ? ColorResources.GREEN
                              : orderModel.orderStatus == "pending"
                                  ? ColorResources.YELLOW
                                  : orderModel.orderStatus == "processing"
                                      ? ColorResources.colorMap[400]
                                      : ColorResources.RED,
                          fontFamily: 'TitilliumWeb',
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                  Container(
                    height: 10,
                    width: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: orderModel.paymentStatus == true
                            ? ColorResources.GREEN
                            : ColorResources.RED),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("${getTranslated('total_price', context)}:",
                      style: titilliumRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_SMALL)),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                  Text(
                      PriceConverter.convertPrice(
                          context, orderModel.orderAmount.ceilToDouble()),
                      style: titilliumSemiBold),
                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                ],
              ),
            ]),
          ),

          // Text(getTranslated(orderModel.orderStatus.toUpperCase(), context),
          //     style: titilliumBold.copyWith(
          // color: orderModel.orderStatus == 'delivered'
          //     ? ColorResources.GREEN
          //     : ColorResources.RED,
          //         fontSize: 14)),
        ]),
      ),
    );
  }
}
// '${AppConstants.BASE_URL}api/v1/${orderModel.productDetails.}',

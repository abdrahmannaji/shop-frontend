import 'package:flutter/material.dart';
import 'package:mobailshop/UI/widget/custom_app_bar.dart';
import 'package:mobailshop/UI/widget/no_data_screen.dart';
import 'package:mobailshop/UI/widget/no_internet_screen.dart';
import 'package:mobailshop/data/model/body/order_place_model.dart';
import 'package:mobailshop/helper/date_converter.dart';
import 'package:mobailshop/data/model/response/order_model.dart';
import 'package:mobailshop/helper/price_converter.dart';

import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/provider/order_provider.dart';
import 'package:mobailshop/provider/theme_provider.dart';
import 'package:mobailshop/utill/app_constants.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/utill/dimensions.dart';
import 'package:mobailshop/utill/images.dart';

import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Ordre orderModel;
  final String orderId;
  OrderDetailsScreen({required this.orderModel, required this.orderId});

  void _loadData(BuildContext context) async {
    // if (orderModel == null) {
    // await Provider.of<SplashProvider>(context, listen: false).initConfig(context);
    // }
    // Provider.of<OrderProvider>(context, listen: false).getOrderDetails(orderId.toString(), context);
    Provider.of<OrderProvider>(context, listen: false)
        .initOrderStatusList(context);
  }

  @override
  Widget build(BuildContext context) {
    _loadData(context);

    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      body: Consumer<OrderProvider>(builder: (context, order, child) {
        double _itemsPrice = 0;
        double _discount = 0;
        double _tax = 0;
        double _shipping = 0;
        if (order.orderList != null) {
          // order.orderList.forEach((orderDetails) {
          _itemsPrice = _itemsPrice +
              (orderModel.productModel.unitPrice * orderModel.orderAmount);
          _discount = _discount +
              (orderModel.productModel.dscount * orderModel.orderAmount);
          _tax = _tax + (orderModel.productModel.tax * orderModel.orderAmount);
          // _shipping = _shipping + (orderDetails.shopId.cost);
          // });
        }
        double _subTotal = _itemsPrice + _tax - _discount;
        double _totalPrice = _subTotal + _shipping;

        return order.orderList != null
            ? order.orderList.length > 0
                ? Column(
                    children: [
                      CustomAppBar(
                          title: getTranslated('order_details', context)),
                      Expanded(
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          children: [
                            // for details

                            Container(
                              margin: EdgeInsets.only(
                                  left: 5, right: 5, bottom: 15),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                color:
                                    ColorResources.getBottomSheetColor(context),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[
                                          Provider.of<ThemeProvider>(context)
                                                  .darkTheme
                                              ? 800
                                              : 200]!,
                                      spreadRadius: 0.5,
                                      blurRadius: 0.3)
                                ],
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${getTranslated('order_no', context)} : #${orderModel.id}',
                                            style: titilliumSemiBold.copyWith(
                                                color:
                                                    ColorResources.getTextColor(
                                                        context),
                                                fontSize: 14),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .PADDING_SIZE_SMALL),
                                            decoration: BoxDecoration(
                                              color:
                                                  ColorResources.getFloatingBtn(
                                                      context),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                                order
                                                    .orderList[0].deliveryStatus
                                                    .toUpperCase(),
                                                style: titilliumSemiBold),
                                          ),
                                        ]),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          '${getTranslated('payment_method', context)}:',
                                          style: titilliumSemiBold.copyWith(
                                              color:
                                                  ColorResources.getTextColor(
                                                      context),
                                              fontSize: 14),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          (orderModel.paymentMethod != null &&
                                                  orderModel.paymentMethod
                                                          .length >
                                                      0)
                                              ? '${orderModel.paymentMethod[0].toUpperCase()}${orderModel.paymentMethod.substring(1).replaceAll('_', ' ')}'
                                              : 'Digital Payment',
                                          style: titilliumSemiBold.copyWith(
                                              color: ColorResources.getBlue(
                                                  context),
                                              fontSize: 14),
                                        ),
                                        Expanded(child: SizedBox()),
                                        Text(
                                            DateConverter.localDateToIsoString(
                                                DateTime.parse(orderModel
                                                    .createdAt
                                                    .toString())),
                                            style: titilliumBold.copyWith(
                                                color:
                                                    ColorResources.getTextColor(
                                                        context),
                                                fontSize: Dimensions
                                                    .FONT_SIZE_DEFAULT)),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          getTranslated('details', context),
                                          style: titilliumSemiBold.copyWith(
                                              fontSize: 12),
                                        ),
                                        Expanded(child: SizedBox()),
                                        Container(
                                          height: 10,
                                          width: 15,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: orderModel.paymentStatus ==
                                                      true
                                                  ? ColorResources.GREEN
                                                  : ColorResources.RED),
                                        ),
                                        Text(
                                            orderModel.paymentStatus == true
                                                ? "تم الدفع"
                                                : "لم يتم الدفع",
                                            style: titilliumBold.copyWith(
                                                fontSize: 14)),
                                      ],
                                    )
                                  ]),
                            ),

                            // for product view
                            Container(
                              margin: EdgeInsets.only(
                                  left: 5, right: 5, bottom: 15),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                color:
                                    ColorResources.getBottomSheetColor(context),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[
                                          Provider.of<ThemeProvider>(context)
                                                  .darkTheme
                                              ? 800
                                              : 200]!,
                                      spreadRadius: 0.5,
                                      blurRadius: 0.3)
                                ],
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      SizedBox(
                                        width: 130,
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          getTranslated('item', context),
                                          style: titilliumSemiBold.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL,
                                              color:
                                                  ColorResources.getTextColor(
                                                      context)),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(width: 35),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            getTranslated('price', context),
                                            style: titilliumSemiBold.copyWith(
                                                color:
                                                    ColorResources.getTextColor(
                                                        context)),
                                          )),
                                    ]),
                                    // ListView.builder(
                                    //   shrinkWrap: true,
                                    //   physics: NeverScrollableScrollPhysics(),
                                    //   itemCount: order.orderList.length,
                                    //   itemBuilder: (context, index) {
                                    // return
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    Images.placeholder_image,
                                                image:
                                                    '${AppConstants.BASE_URL}uploads/${orderModel.productModel.mainimage}',
                                                height: 70,
                                                width: 80,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                                width: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL),
                                            Text(' x ${orderModel.orderAmount}',
                                                style:
                                                    titilliumRegular.copyWith(
                                                        color: ColorResources
                                                            .getHintColor(
                                                                context))),
                                            SizedBox(
                                                width: Dimensions
                                                    .PADDING_SIZE_EXTRA_LARGE),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                orderModel.productModel.name,
                                                style: titilliumSemiBold
                                                    .copyWith(
                                                        fontSize: Dimensions
                                                            .FONT_SIZE_SMALL,
                                                        color: ColorResources
                                                            .getPrimary(
                                                                context)),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(
                                                width: Dimensions
                                                    .PADDING_SIZE_DEFAULT),
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  PriceConverter.convertPrice(
                                                      context,
                                                      orderModel.productModel
                                                          .unitPrice
                                                          .toDouble()),
                                                  style: titilliumSemiBold
                                                      .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                ))
                                          ],
                                        ),

                                        SizedBox(height: 10),
                                        // Total
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  getTranslated(
                                                      'item_price', context),
                                                  style:
                                                      titilliumRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_LARGE)),
                                              Text(
                                                  PriceConverter.convertPrice(
                                                      context, _itemsPrice),
                                                  style:
                                                      titilliumRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_LARGE)),
                                            ]),

                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  getTranslated('tax', context),
                                                  style:
                                                      titilliumRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_LARGE)),
                                              Text(
                                                  '(+) ${PriceConverter.convertPrice(context, _tax)}',
                                                  style:
                                                      titilliumRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_LARGE)),
                                            ]),

                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  getTranslated(
                                                      'discount', context),
                                                  style:
                                                      titilliumRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_LARGE)),
                                              Text(
                                                  '(-) ${PriceConverter.convertPrice(context, _discount)}',
                                                  style:
                                                      titilliumRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_LARGE)),
                                            ]),

                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  getTranslated(
                                                      'sub_total', context),
                                                  style:
                                                      titilliumRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_LARGE)),
                                              Text(
                                                  PriceConverter.convertPrice(
                                                      context, _subTotal),
                                                  style:
                                                      titilliumRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_LARGE)),
                                            ]),

                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  getTranslated(
                                                      'shipping_fee', context),
                                                  style:
                                                      titilliumRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_LARGE)),
                                              Text(
                                                  '(+) ${PriceConverter.convertPrice(context, _shipping)}',
                                                  style:
                                                      titilliumRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_LARGE)),
                                            ]),
                                        Divider()
                                      ],
                                    ),
                                    //   },
                                    // ),
                                    SizedBox(
                                        height: Dimensions.PADDING_SIZE_SMALL),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              getTranslated(
                                                  'total_amount', context),
                                              style: titilliumSemiBold.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_EXTRA_LARGE,
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          Text(
                                            PriceConverter.convertPrice(
                                                context, _totalPrice),
                                            style: titilliumSemiBold.copyWith(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_LARGE,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ]),
                                  ]),
                            ),

                            // for address
                            Container(
                              margin: EdgeInsets.only(
                                  left: 5, right: 5, bottom: 15),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                color:
                                    ColorResources.getBottomSheetColor(context),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[
                                          Provider.of<ThemeProvider>(context)
                                                  .darkTheme
                                              ? 800
                                              : 200]!,
                                      spreadRadius: 0.5,
                                      blurRadius: 0.3)
                                ],
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        getTranslated(
                                            'shipping_address', context),
                                        style: titilliumSemiBold.copyWith(
                                            fontSize: 14)),
                                    Text(
                                      '${getTranslated('name', context)} : shdfh jsldhjlasg',
                                      style: titilliumRegular,
                                    ),
                                    Text(
                                        '${getTranslated('address', context)} : صنعاء اليمن',
                                        style: titilliumRegular),
                                    Text("sfhxljsa",
                                        // '${getTranslated('phone', context)} : ${orderModel.customer.phone ?? ''}',
                                        style: titilliumRegular),
                                  ]),
                            ),

                            // for Customer Details
                            Container(
                              margin: EdgeInsets.only(
                                  left: 5, right: 5, bottom: 15),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                color:
                                    ColorResources.getBottomSheetColor(context),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[
                                          Provider.of<ThemeProvider>(context)
                                                  .darkTheme
                                              ? 800
                                              : 200]!,
                                      spreadRadius: 0.5,
                                      blurRadius: 0.3)
                                ],
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        getTranslated(
                                            'customer_contact_details',
                                            context),
                                        style: titilliumSemiBold.copyWith(
                                            color: ColorResources.getTextColor(
                                                context))),
                                    SizedBox(
                                        height: Dimensions.PADDING_SIZE_SMALL),
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  Images.placeholder_image,
                                              image:
                                                  '${AppConstants.BASE_URL}uploads/avatars/${orderModel.usersModel.photoUrl}',
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.cover),
                                        ),
                                        SizedBox(
                                            width:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                '${orderModel.usersModel.fName} ${orderModel.usersModel.lName}',
                                                style: titilliumBold.copyWith(
                                                    color: ColorResources
                                                        .getTextColor(context),
                                                    fontSize: 14)),
                                            Text(
                                                '${getTranslated('email', context)} : ${orderModel.usersModel.email}',
                                                style:
                                                    titilliumSemiBold.copyWith(
                                                        color: ColorResources
                                                            .getHintColor(
                                                                context),
                                                        fontSize: 12)),
                                            Text(
                                                '${getTranslated('contact', context)} : ${orderModel.usersModel.phone}',
                                                style:
                                                    titilliumSemiBold.copyWith(
                                                        color: ColorResources
                                                            .getHintColor(
                                                                context),
                                                        fontSize: 12)),
                                          ],
                                        ))
                                      ],
                                    )
                                  ]),
                            ),

                            order.addOrderStatusErrorText != null &&
                                    order.addOrderStatusErrorText!.isNotEmpty
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      order.addOrderStatusErrorText!
                                              .contains('updated')
                                          ? "تم التعديل"
                                          : "هناك مشكلة حاول مرة اخرى",
                                      style: titilliumRegular.copyWith(
                                          color: order.addOrderStatusErrorText!
                                                  .contains('updated')
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                            !order.isLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                        key: Key(''),
                                        valueColor: AlwaysStoppedAnimation<
                                                Color>(
                                            Theme.of(context).primaryColor)))
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Consumer<OrderProvider>(
                                        builder: (context, order, child) {
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                left: Dimensions
                                                    .PADDING_SIZE_DEFAULT,
                                                right: Dimensions
                                                    .PADDING_SIZE_DEFAULT,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        1), // changes position of shadow
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              alignment: Alignment.center,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                value: order.orderStatusType,
                                                isExpanded: true,
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none),
                                                iconSize: 24,
                                                elevation: 16,
                                                style: titilliumRegular,
                                                //underline: SizedBox(),

                                                onChanged: order.updateStatus,
                                                items: order.orderStatusList
                                                    .map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                        getTranslated(
                                                            value, context),
                                                        style: titilliumRegular
                                                            .copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .color)),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                                onTap: () async {
                                                  if (Provider.of<OrderProvider>(
                                                              context,
                                                              listen: false)
                                                          .orderStatusType ==
                                                      Provider.of<OrderProvider>(
                                                              context,
                                                              listen: false)
                                                          .orderStatusList[0]) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(getTranslated(
                                                          'select_order_type',
                                                          context)),
                                                      backgroundColor:
                                                          Colors.red,
                                                    ));
                                                  } else {
                                                    Provider.of<OrderProvider>(
                                                            context,
                                                            listen: false)
                                                        .setOrderStatusErrorText(
                                                            '');

                                                    //  List<String> _productIds = [];
                                                    // order.orderList
                                                    //     .forEach((orderDetails) {
                                                    //   _productIds
                                                    //       .add(orderDetails.id);
                                                    // });
                                                    print(Provider.of<
                                                                OrderProvider>(
                                                            context,
                                                            listen: false)
                                                        .orderStatusType);
                                                    await Provider.of<
                                                                OrderProvider>(
                                                            context,
                                                            listen: false)
                                                        .updateOrderStatus(
                                                      orderModel.id,
                                                      Provider.of<OrderProvider>(
                                                              context,
                                                              listen: false)
                                                          .orderStatusType,
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: Dimensions
                                                            .PADDING_SIZE_SMALL,
                                                        vertical: Dimensions
                                                            .PADDING_SIZE_SMALL),
                                                    padding: EdgeInsets.all(12),
                                                    decoration: BoxDecoration(
                                                        color: ColorResources
                                                            .getSellerTxt(
                                                                context),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(getTranslated(
                                                        'submit', context)))),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),

                            SizedBox(height: Dimensions.PADDING_SIZE_LARGE)
                          ],
                        ),
                      ),
                    ],
                  )
                : NoDataScreen()
            : Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor)));
      }),
    );
  }
}

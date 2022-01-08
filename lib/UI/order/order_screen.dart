import 'package:flutter/material.dart';
import 'package:mobailshop/UI/widget/custom_app_bar.dart';
import 'package:mobailshop/UI/order/widget/order_widget.dart';
import 'package:mobailshop/data/model/response/order_model.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/provider/order_provider.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/utill/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderProvider>(context, listen: false).getOrder(context);
    print(Provider.of<OrderProvider>(context, listen: false).isLoading);
  }

  @override
  Widget build(BuildContext context) {
    // OrderModel orderList;

    return Provider.of<OrderProvider>(context, listen: false).isLoading == true
        ? Scaffold(
            backgroundColor: ColorResources.getIconBg(context),
            body: Consumer<OrderProvider>(
              builder: (context, order, child) {
                List<Ordre> ordres;
                if (order.orderTypeIndex == 0) {
                  ordres = order.orderList;
                } else if (order.orderTypeIndex == 1) {
                  ordres = order.pendingList;
                } else if (order.orderTypeIndex == 2) {
                  ordres = order.processing;
                } else if (order.orderTypeIndex == 3) {
                  ordres = order.deliveredList;
                } else if (order.orderTypeIndex == 4) {
                  ordres = order.returnList;
                } else if (order.orderTypeIndex == 5) {
                  ordres = order.canceledList;
                } else {
                  ordres = [];
                }
                return Column(children: [
                  CustomAppBar(
                      title: getTranslated('my_order', context),
                      isBackButtonExist: true),
                  order.orderList != []
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL,
                              vertical: Dimensions.PADDING_SIZE_SMALL),
                          child: SizedBox(
                            height: 60,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                OrderTypeButton(
                                  text: getTranslated('all', context),
                                  index: 0,
                                ),
                                SizedBox(width: 5),
                                OrderTypeButton(
                                  text: getTranslated('pending', context),
                                  index: 1,
                                  // orderList: order.orderList
                                ),
                                SizedBox(width: 5),
                                OrderTypeButton(
                                  text: getTranslated('processing', context),
                                  index: 2,
                                  // orderList: order.orderList
                                ),
                                SizedBox(width: 5),
                                OrderTypeButton(
                                  text: getTranslated('delivered', context),
                                  index: 3,
                                  // orderList: order.orderList
                                ),
                                SizedBox(width: 5),
                                OrderTypeButton(
                                  text: getTranslated('return', context),
                                  index: 4,
                                  // orderList: order.orderList
                                ),
                                SizedBox(width: 5),
                                OrderTypeButton(
                                  text: getTranslated('failed', context),
                                  index: 5,
                                  // orderList: order.orderList
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  order.orderList != []
                      ? Expanded(
                          child: RefreshIndicator(
                            backgroundColor: Theme.of(context).primaryColor,
                            onRefresh: () async {
                              await order.getOrder(context);
                            },
                            child: ListView.builder(
                              itemCount: ordres.length,
                              padding: EdgeInsets.all(0),
                              itemBuilder: (context, index) =>
                                  OrderWidget(orderModel: ordres[index]),
                            ),
                          ),
                        )
                      : Expanded(child: OrderShimmer()),
                ]);
              },
            ),
          )
        : Container();
  }
}

class OrderShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          color: Theme.of(context).accentColor,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10, width: 150, color: ColorResources.WHITE),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: Container(height: 45, color: Colors.white)),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(height: 20, color: ColorResources.WHITE),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                  height: 10, width: 70, color: Colors.white),
                              SizedBox(width: 10),
                              Container(
                                  height: 10, width: 20, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class OrderTypeButton extends StatelessWidget {
  final String text;
  final int index;
  // final List<Ordre> orderList;
  OrderTypeButton({
    required this.text,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () =>
          Provider.of<OrderProvider>(context, listen: false).setIndex(index),
      style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
      child: Consumer<OrderProvider>(
        builder: (context, order, child) {
          return Container(
            height: 40,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: order.orderTypeIndex == index
                  ? ColorResources.getPrimary(context)
                  : Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(text,
                style: titilliumBold.copyWith(
                    color: order.orderTypeIndex == index
                        ? Theme.of(context).accentColor
                        : ColorResources.getPrimary(context))),
          );
        },
      ),
    );
  }
}

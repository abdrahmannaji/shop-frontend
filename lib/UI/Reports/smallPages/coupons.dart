import 'package:flutter/material.dart';
import 'package:mobailshop/UI/Reports/widget/report-type-button.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/dimensions.dart';
import 'package:mobailshop/utill/images.dart';

import '../../../sryle.dart';

class Coupons extends StatelessWidget {
  late bool choose = false;
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16),
    );

    return Container(
        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(children: [
          Container(
            child: Row(
              children: <Widget>[
                buildStatCard(getTranslated('Totaldiscount', context),
                    '1.890.800', ColorResources.getPrimary(context)),
                buildStatCard(getTranslated('UsedCoupons', context), '30',
                    ColorResources.getPrimary(context)),
              ],
            ),
          ),
          // sizedbox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  choose = true;
                },
                child: Container(
                    padding:
                        EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, 2),
                          color: ColorResources.backgrond,
                          blurRadius: 1.6,
                        )
                      ],
                      color: choose
                          ? ColorResources.getPrimary(context)
                          : ColorResources.getHintColor(context),
                    ),
                    child: Text(
                      "الأكثر استخدامًا",
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorResources.WHITE,
                        fontStyle: FontStyle.normal,
                      ),
                    )),
              ),
              InkWell(
                  onTap: () {
                    choose = false;
                  },
                  child: Container(
                      padding:
                          EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            Dimensions.PADDING_SIZE_SMALL),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 2),
                            color: ColorResources.backgrond,
                            blurRadius: 1.6,
                          )
                        ],
                        color: !choose
                            ? ColorResources.getPrimary(context)
                            : ColorResources.getHintColor(context),
                      ),
                      child: Text(
                        "أعلى مبلغ خصم",
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorResources.WHITE,
                          fontStyle: FontStyle.normal,
                        ),
                      )))
            ],
          ),
          sizedbox,
          Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
              boxShadow: [
                BoxShadow(
                  offset: Offset(1, 2),
                  color: ColorResources.backgrond,
                  blurRadius: 1.6,
                )
              ],
              color: ColorResources.WHITE,
            ),
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(width: 20, child: Text("#")),
                    Expanded(child: Text("الاسم")),
                    Expanded(child: Text("المبلغ")),
                    Expanded(child: Text("المنتج")),
                    Expanded(
                        child: Text(
                      "السعر بعد الخصم /\$",
                      style: TextStyle(fontSize: 12),
                    )),
                  ],
                ),
                Divider(
                  height: 4,
                  indent: 5,
                  color: ColorResources.backgrond,
                ),
                Row(
                  children: [
                    Container(width: 20, child: Text("1-")),
                    Expanded(
                        child: Text(
                      "بداية السنة",
                    )),
                    Expanded(child: Text("30%")),
                    Expanded(child: Text("نوت 20")),
                    Expanded(child: Text("800")),
                  ],
                ),
                Row(
                  children: [
                    Container(width: 20, child: Text("1-")),
                    Expanded(
                        child: Text(
                      "بداية السنة",
                    )),
                    Expanded(child: Text("30%")),
                    Expanded(child: Text("نوت 20")),
                    Expanded(child: Text("800")),
                  ],
                ),
                Row(
                  children: [
                    Container(width: 20, child: Text("1-")),
                    Expanded(
                        child: Text(
                      "بداية السنة",
                    )),
                    Expanded(child: Text("30%")),
                    Expanded(child: Text("نوت 20")),
                    Expanded(child: Text("800")),
                  ],
                ),
                Row(
                  children: [
                    Container(width: 20, child: Text("1-")),
                    Expanded(
                        child: Text(
                      "بداية السنة",
                    )),
                    Expanded(child: Text("30%")),
                    Expanded(child: Text("نوت 20")),
                    Expanded(child: Text("800")),
                  ],
                ),
                Row(
                  children: [
                    Container(width: 20, child: Text("1-")),
                    Expanded(
                        child: Text(
                      "بداية السنة",
                    )),
                    Expanded(child: Text("30%")),
                    Expanded(child: Text("نوت 20")),
                    Expanded(child: Text("800")),
                  ],
                ),
              ],
            ),
          ),
          sizedbox,
        ]));
  }
}

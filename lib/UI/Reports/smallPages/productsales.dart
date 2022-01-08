import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/sryle.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/utill/dimensions.dart';
import 'package:mobailshop/utill/images.dart';

class ProductsSales extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Column(
        children: [
          InkWell(
            // onTap: () => Navigator.push(context,
            //     MaterialPageRoute(builder: (_) => SearchScreen())),
            child: Container(
              // padding: EdgeInsets.symmetric(
              //     horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: 2),
              // color: ColorResources.getRed(context),
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                height: ScreenUtil().setHeight(40),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1, 2),
                      color: ColorResources.backgrond,
                      //  const Color(0x78414141),
                      // offset: Offset.zero,

                      blurRadius: 1.6,
                      // spreadRadius: 1.0
                    )
                  ],
                  color: ColorResources.WHITE,
                  borderRadius:
                      BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                ),
                child: Row(children: [
                  Icon(Icons.search,
                      color: ColorResources.getRed(context),
                      size: Dimensions.ICON_SIZE_LARGE),
                  SizedBox(width: ScreenUtil().setWidth(5)),
                  Text(getTranslated('SEARCH_HINT', context),
                      style: robotoRegular.copyWith(
                          color: Theme.of(context).hintColor)),
                ]),
              ),
            ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("الافضل تقييم",
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                        ),
                        strutStyle: StrutStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                        ))
                  ],
                ),
                Row(
                  children: [
                    Container(width: 20, child: Text("#")),
                    Expanded(child: Text("الصور")),
                    Expanded(child: Text("الاسم")),
                    Expanded(child: Text("الشركة")),
                    Expanded(child: Text("السعر /\$")),
                    Expanded(child: Text("التقييم")),
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
                        child: Row(
                      children: [
                        Image.asset(
                          Images.not,
                          height: 40,
                        ),
                      ],
                    )),
                    Expanded(
                        child: Text(
                      "نوت  20",
                    )),
                    Expanded(child: Text("سامسونج")),
                    Expanded(child: Text("1200")),
                    Expanded(child: Text("8 %")),
                  ],
                ),
                Row(
                  children: [
                    Container(width: 20, child: Text("2-")),
                    Expanded(
                        child: Row(
                      children: [
                        Image.asset(
                          Images.not,
                          height: 40,
                        ),
                      ],
                    )),
                    Expanded(
                        child: Text(
                      "ايفون 9",
                    )),
                    Expanded(child: Text("ابل")),
                    Expanded(child: Text("700")),
                    Expanded(child: Text("7 %")),
                  ],
                ),
                Row(
                  children: [
                    Container(width: 20, child: Text("3-")),
                    Expanded(
                        child: Row(
                      children: [
                        Image.asset(
                          Images.not,
                          height: 40,
                        ),
                      ],
                    )),
                    Expanded(
                        child: Text(
                      "ايفون 11",
                    )),
                    Expanded(child: Text("ابل")),
                    Expanded(child: Text("1100")),
                    Expanded(child: Text("6.9 %")),
                  ],
                ),
                Row(
                  children: [
                    Container(width: 20, child: Text("4-")),
                    Expanded(
                        child: Row(
                      children: [
                        Image.asset(
                          Images.not,
                          height: 40,
                        ),
                      ],
                    )),
                    Expanded(
                        child: Text(
                      "p30 pro",
                    )),
                    Expanded(child: Text("هواوي")),
                    Expanded(child: Text("500")),
                    Expanded(child: Text("6 %")),
                  ],
                ),
              ],
            ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("الافضل مبيعأ",
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                        ),
                        strutStyle: StrutStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                        ))
                  ],
                ),
                Row(
                  children: [
                    Container(width: 20, child: Text("#")),
                    Expanded(child: Text("الصور")),
                    Expanded(child: Text("الاسم")),
                    Expanded(child: Text("الشركة")),
                    Expanded(child: Text("السعر /\$")),
                    Expanded(child: Text("تم بيع")),
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
                        child: Row(
                      children: [
                        Image.asset(
                          Images.not,
                          height: 40,
                        ),
                      ],
                    )),
                    Expanded(
                        child: Text(
                      "نوت  20",
                    )),
                    Expanded(child: Text("سامسونج")),
                    Expanded(child: Text("1200")),
                    Expanded(child: Text("58")),
                  ],
                ),
                Row(
                  children: [
                    Container(width: 20, child: Text("2-")),
                    Expanded(
                        child: Row(
                      children: [
                        Image.asset(
                          Images.not,
                          height: 40,
                        ),
                      ],
                    )),
                    Expanded(
                        child: Text(
                      "نوت  20",
                    )),
                    Expanded(child: Text("سامسونج")),
                    Expanded(child: Text("1200")),
                    Expanded(child: Text("34")),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

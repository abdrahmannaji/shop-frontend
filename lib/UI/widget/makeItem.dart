import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobailshop/Animation/FadeAnimation.dart';
import 'package:mobailshop/sryle.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/utill/dimensions.dart';

Widget makeItem(
    {image,
    tag,
    context,
    required Color color,
    typephone,
    name,
    phoneSize,
    rom,
    phoneWeight,
    unitPrice}) {
  return Hero(
    tag: tag,
    child: GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Shoes(
        //               image: image,
        //             )));
      },
      child: Stack(
        children: [
          Container(
            height: ScreenUtil().setHeight(285),
            // width: double.infinity,
            padding: EdgeInsets.all(ScreenUtil().setSp(10)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).accentColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 7)
                ]),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(200),
                          height: ScreenUtil().setHeight(170),
                          // margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setSp(12)),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: ScreenUtil().setSp(4))
                            ],
                          ),
                          child: Image.network(
                            "http://172.16.0.6:3001/uploads/$image",
                          ),
                        ),
                        Positioned(
                          top: ScreenUtil().setSp(180),
                          right: ScreenUtil().setSp(110),
                          child: Container(
                            width: ScreenUtil().setWidth(60),
                            height: ScreenUtil().setHeight(20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorResources.getBlue(context),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(7),
                                  bottomLeft: Radius.circular(12)),
                            ),
                            child: Text(
                              '1100\$',
                              style: robotoRegular.copyWith(
                                  color: Theme.of(context).accentColor,
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                            ),
                          ),
                        ),
                        Positioned(
                          top: ScreenUtil().setSp(7),
                          right: ScreenUtil().setSp(7),
                          child: Container(
                              width: ScreenUtil().setWidth(30),
                              height: ScreenUtil().setHeight(30),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.1,
                                  color: ColorResources.HINT_TEXT_COLOR,
                                ),
                                color: Color(0xCCFFFFFF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setSp(8)),
                                ),
                                // borderRadius: BorderRadius.only(
                                //     topRight: Radius.circular(10),
                                //     bottomLeft: Radius.circular(10)),
                              ),
                              child: FadeAnimation(
                                1.2,
                                Center(
                                  child: Icon(
                                    Icons.favorite_border,
                                    size: ScreenUtil().setSp(22),
                                    // color: Color(0x9CEE3434),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                    sizedbox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(160),
                          child: FadeAnimation(
                              1,
                              Text(
                                "$name  $typephone",
                                style: robotoBold,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(160),
                          child: FadeAnimation(
                              1,
                              Text(
                                "$phoneSize  $rom $phoneWeight",
                                style: robotoBold.copyWith(
                                  color: ColorResources.HINT_TEXT_COLOR,
                                  // decoration: TextDecoration.lineThrough,
                                  fontSize: Dimensions.FONT_SIZE_SMALL,
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ),
                      ],
                    ),
                    //
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: ScreenUtil().setSp(285),
            child: Container(
              width: ScreenUtil().setWidth(185),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: ScreenUtil().setHeight(3),
                            ),
                            FadeAnimation(
                                1.1,
                                Text(
                                  "$unitPrice\$",
                                  style: robotoBold.copyWith(
                                      fontSize: 16,
                                      color:
                                          ColorResources.getPrimary(context)),
                                )),
                            SizedBox(
                              height: ScreenUtil().setHeight(2),
                            ),
                            FadeAnimation(
                                1.1,
                                Text("تم بيع 29",
                                    overflow: TextOverflow.ellipsis,
                                    style: robotoBold.copyWith(
                                      color: ColorResources.HINT_TEXT_COLOR,
                                      fontSize: Dimensions.FONT_SIZE_SMALL,
                                    ))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: ScreenUtil().setWidth(50),
                      height: ScreenUtil().setHeight(45),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: ScreenUtil().setWidth(0.1),
                          color: ColorResources.HINT_TEXT_COLOR,
                        ),
                        color: ColorResources.getBlue(context),
                        borderRadius: BorderRadius.only(
                            topRight:
                                Radius.circular(ScreenUtil().setHeight(7)),
                            bottomLeft:
                                Radius.circular(ScreenUtil().setHeight(18))),
                      ),
                      child: FadeAnimation(
                        1.2,
                        Center(
                          child: Icon(
                            Icons.add,
                            size: 18,
                            color: ColorResources.white,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

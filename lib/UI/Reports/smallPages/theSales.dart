import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:mobailshop/UI/Reports/widget/report-type-button.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/utill/dimensions.dart';

class TheSales extends StatelessWidget {
  final covidUSADailyNewCases = [
    12.17,
    11.15,
    10.02,
    11.21,
    13.83,
    14.16,
    14.30
  ];
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      body: Stack(
        children: [
          Container(
            color: ColorResources.getPrimary(context),
            height: 235,
            // width: 300,
          ),
          Container(
            height: 250,
            // width: width / 3.5,
            // height: width / 5,
            // decoration: BoxDecoration(
            //     color: Colors.transparent,
            // ),
            margin: EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 20.0,
                  sigmaY: 20.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: Colors.black26,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Expanded(
          //   child: ListView(
          //     children: <Widget>[
          LineChartSample2(),

          Container(margin: EdgeInsets.only(top: 260), child: StatsGrid()),
          //     ],
          //   ),260
          // ),
        ],
      ),
      // body: Container(
      //   child: Column(
      //     children: [
      //       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      //         Container(
      //           width: width / 3.5,
      //           height: width / 5,
      //           padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10),
      //             color: ColorResources.getPrimary(context),
      //           ),
      //         ),
      //         Container(
      //           width: width / 3.5,
      //           height: width / 5,
      //           padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10),
      //             color: ColorResources.getGreen(context),
      //           ),
      //         ),
      //         Container(
      //           width: width / 3.5,
      //           height: width / 5,
      //           padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10),
      //             color: ColorResources.CERISE,
      //           ),
      //         )
      //       ]),
      //       SizedBox(height: 20),
      //       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      //         Container(
      //           width: width / 3.5,
      //           height: width / 5,
      //           padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10),
      //             color: ColorResources.YELLOW,
      //           ),
      //         ),
      //         Container(
      //           width: width / 3.5,
      //           height: width / 5,
      //           padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10),
      //             color: ColorResources.RED,
      //           ),
      //         ),

      // Container(
      //   width: width / 3.5,
      //   height: width / 5,
      //   // decoration: BoxDecoration(
      //   //     color: Colors.transparent,
      //   // ),
      //   margin: EdgeInsets.all(8),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.all(Radius.circular(20)),
      //     child: BackdropFilter(
      //       filter: ImageFilter.blur(
      //         sigmaX: 20.0,
      //         sigmaY: 20.0,
      //       ),
      //       child: Container(
      //         decoration: BoxDecoration(
      //           color: Colors.white12,
      //           borderRadius: BorderRadius.all(Radius.circular(20)),
      //           border: Border.all(
      //             color: Colors.black26,
      //             width: 0.5,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // )
      //         // Container(
      //         //   width: width / 3.5,
      //         //   height: width / 5,
      //         //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      //         //   decoration: BoxDecoration(
      //         //     borderRadius: BorderRadius.circular(10),
      //         //     color: ColorResources.yelwee,
      //         //   ),
      //         // )
      //       ]),
      //     ],
      //   ),
      // )
    );
  }
}

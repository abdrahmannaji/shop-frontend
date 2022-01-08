import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/provider/order_provider.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/utill/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportTypeButton extends StatelessWidget {
  final String text;
  final int index;
  String? image;
  // final List<Ordre> orderList;
  ReportTypeButton({
    required this.text,
    required this.index,
    this.image,
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
                boxShadow: [
                  BoxShadow(
                      color: ColorResources.HINT_TEXT_COLOR, blurRadius: 2)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(text,
                    style: titilliumBold.copyWith(
                        color: order.orderTypeIndex == index
                            ? Theme.of(context).accentColor
                            : ColorResources.getPrimary(context))),
                SizedBox(
                  width: 10,
                ),
                image != null
                    ? ClipRRect(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setSp(28)),
                        child: Container(
                          padding: EdgeInsets.all(3),
                          color: Theme.of(context).accentColor,
                          child: Image.asset(
                            image!,

                            height: 30,
                            color: ColorResources.getPrimary(context),
                            width: 25,
                            // scale: 0.9,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                buildStatCard(getTranslated('gross sales', context),
                    '1.890.800', ColorResources.getPrimary(context)),
                buildStatCard(getTranslated('daily sales', context), '59.000',
                    ColorResources.getPrimary(context)),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                buildStatCard(getTranslated('net sales', context), '15.900',
                    ColorResources.HINT_TEXT_COLOR),
                buildStatCard(getTranslated('orders placed', context), '2019',
                    ColorResources.HINT_TEXT_COLOR),
                buildStatCard(getTranslated('items purchased', context), '2010',
                    ColorResources.HINT_TEXT_COLOR),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                buildStatCard(getTranslated('shipping expenses', context),
                    '1.800', ColorResources.HINT_TEXT_COLOR
                    //  Color.fromRGBO(255, 94, 120, 100.0)
                    ),
                buildStatCard(
                    getTranslated('refunds', context),
                    '1.200',
                    // Color.fromRGBO(224, 36, 1, 100)
                    ColorResources.HINT_TEXT_COLOR),
                buildStatCard(
                    getTranslated('refunds', context),
                    '90',
                    // Color.fromRGBO(81, 5, 15, 100)
                    ColorResources.HINT_TEXT_COLOR),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

buildStatCard(String title, String count, Color color) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

class LineChartSample2 extends StatefulWidget {
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xFF333837),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              // color: Color(0xff232d37)
            ),
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 4.0, top: 24, bottom: 10),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: ColorResources.WHITE,
            //  Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: ColorResources.WHITE,
            // const Color(0xff37434d),

            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 15,
          interval: 1,
          getTextStyles: (value) => TextStyle(
              color: ColorResources.WHITE,
              //  Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'التاريخ';
              case 1:
                return '1/10';
              case 2:
                return '2/10';
              case 3:
                return '3/10';
              case 4:
                return '4/10';
              case 5:
                return '5/10';
              case 6:
                return '6/10';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (value) => const TextStyle(
            color: ColorResources.WHITE,
            //  Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'المبلغ';
              case 1:
                return '10k';
              case 2:
                return '20k';
              case 3:
                return '30k';
              case 4:
                return '40k';
              case 5:
                return '50k';
              case 6:
                return '60k';
              case 7:
                return '70k';
              // case 8:
              //   return '80k';
            }
            return '';
          },
          reservedSize: 32,
          margin: 20,
        ),
      ),
      borderData: FlBorderData(
          // show: true,
          border: Border.all(color: ColorResources.WHITE, width: 1)),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(1, 4),
            FlSpot(2, 6.5),
            FlSpot(3, 5),
            FlSpot(4, 3.5),
            FlSpot(5, 4),
            FlSpot(6, 7),
            // FlSpot(0, 0),
          ],
          // isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,

          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.5)).toList(),
          ),
        ),
      ],
    );
  }
}

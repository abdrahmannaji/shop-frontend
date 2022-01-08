import 'package:flutter/material.dart';
import 'package:mobailshop/utill/color_resources.dart';

class BottomBar extends StatefulWidget {
  var onPressed;
  bool bottomIcons;
  String text;
  var image;
  Color color;
  BottomBar(
      {required this.onPressed,
      required this.bottomIcons,
      required this.image,
      required this.color,
      required this.text});
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onPressed,
        child: widget.bottomIcons == true
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                child: Row(
                  children: <Widget>[
                    Image.asset(widget.image,
                        color: widget.color, height: 25, width: 25),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.text,
                      style: TextStyle(
                          color: widget.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
              )
            : Image.asset(
                widget.image,
                height: 22,
                width: 22,
                color: ColorResources.BLACK,
              ));
  }
}

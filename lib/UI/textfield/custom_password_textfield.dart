import 'package:flutter/material.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintTxt;
  final FocusNode focusNode;
  final FocusNode? nextNode;
  final TextInputAction textInputAction;

  CustomPasswordTextField(
      {required this.controller,
      required this.hintTxt,
      required this.focusNode,
      this.nextNode,
      required this.textInputAction});

  @override
  _CustomPasswordTextFieldState createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 1)) // changes position of shadow
        ],
      ),
      child: TextFormField(
        cursorColor: ColorResources.Red0001,
        controller: widget.controller,
        obscureText: _obscureText,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: (v) {
          setState(() {
            widget.textInputAction == TextInputAction.done
                ? FocusScope.of(context).consumeKeyboardToken()
                : FocusScope.of(context).requestFocus(widget.nextNode);
          });
        },
        validator: (value) {
          return null;
        },
        decoration: InputDecoration(
            suffixIcon: IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: _toggle),
            hintText: widget.hintTxt,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
            isDense: true,
            filled: true,
            fillColor: Theme.of(context).accentColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorResources.Red0001
                    // Theme.of(context).primaryColor
                    )),
            hintStyle:
                titilliumRegular.copyWith(color: Theme.of(context).hintColor),
            border: InputBorder.none),
      ),
    );
  }
}

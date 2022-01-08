import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  void Function(String)? onChanged;
  final String? hintText;
  final bool border;
  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool? isPhoneNumber;
  final bool? isValidator;
  final String? validatorMessage;
  final Color? fillColor;
  final TextCapitalization capitalization;

  CustomTextField(
      {required this.controller,
      this.hintText,
      this.border = true,
      this.textInputType,
      this.maxLine,
      this.focusNode,
      this.nextNode,
      this.textInputAction,
      this.isPhoneNumber = false,
      this.isValidator = false,
      this.onChanged,
      this.validatorMessage,
      this.capitalization = TextCapitalization.none,
      this.fillColor});

  @override
  Widget build(context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: isPhoneNumber!
            ? BorderRadius.only(
                topRight: Radius.circular(6), bottomRight: Radius.circular(6))
            : BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1)) // changes position of shadow
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLine,
        // cursorHeight: 100,

        textCapitalization: capitalization,
        maxLength: isPhoneNumber! ? 15 : null,
        focusNode: focusNode,
        keyboardType: textInputType,
        //keyboardType: TextInputType.number,
        initialValue: null,
        textInputAction: textInputAction,
        onChanged: onChanged,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(nextNode);
        },
        autovalidate: true,
        inputFormatters: [
          isPhoneNumber!
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter
        ],
        validator: (input) {
          if (input!.isEmpty) {
            if (isValidator!) {
              return validatorMessage;
            }
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hintText,
          // ignore: unnecessary_null_comparison
          filled: fillColor != null,
          fillColor: fillColor,
          // contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
          isDense: true,
          counterText: '',
          focusedBorder: border == true
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: ColorResources.Red0001))
              : InputBorder.none,

          contentPadding: EdgeInsets.all(10),

          hintStyle:
              titilliumRegular.copyWith(color: Theme.of(context).hintColor),
          errorStyle: TextStyle(height: 1.5),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobailshop/UI/auth/widget/seller_wodget.dart';
import 'package:mobailshop/mainshop.dart';
import 'package:mobailshop/data/model/body/otpmodeil.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/provider/auth_provider.dart';
import 'package:mobailshop/provider/profile_provider.dart';
import 'package:mobailshop/provider/theme_provider.dart';

import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/sryle.dart';
import 'package:mobailshop/utill/images.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import 'package:flutter/gestures.dart';

class Otp extends StatefulWidget {
  Otp({
    this.verify_by = "email",
  });
  final String verify_by;

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  OtpModel otpModel = OtpModel();

  TextEditingController _verificationCodeController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  var _userid;
  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
    _userid = (Provider.of<AuthProvider>(context, listen: false).getUserid());
    //on Splash Screen hide statusbar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  @override
  void dispose() {
    errorController!.close();
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  void verificationCode() async {
    // if (_formKeyLogin.currentState!.validate()) {
    //   _formKeyLogin.currentState!.save();

    String _verificationCode = _verificationCodeController.text.trim();

    if (_verificationCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(getTranslated('EMAIL_MUST_BE_REQUIRED', context)),
        backgroundColor: Colors.red,
      ));
    } else {
      if (Provider.of<AuthProvider>(context, listen: false).isRemember) {
        Provider.of<AuthProvider>(context, listen: false)
            .saveUserEmail(_verificationCode, _userid);
      } else {
        Provider.of<AuthProvider>(context, listen: false)
            .clearUserEmailAndPassword();
      }
      print(_userid);
      otpModel.verificationCode = int.parse(_verificationCode);
      otpModel.id = _userid;
      await Provider.of<AuthProvider>(context, listen: false)
          .verificationCode(otpModel, route);
    }
  }

  route(bool isRoute, String errorMessage) async {
    if (isRoute) {
      await Provider.of<ProfileProvider>(context, listen: false)
          .getUserInfo(context);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => ShopupWidget()), (route) => true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    String _verify_by = widget.verify_by; //phone or email
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Provider.of<ThemeProvider>(context).darkTheme
              ? SizedBox()
              : Image.asset(Images.background,
                  fit: BoxFit.fill,
                  colorBlendMode: BlendMode.clear,
                  // color:
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width),
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Image.asset(Images.logo_with_name_image,
                    height: 150,
                    width: 200,
                    color: ColorResources.getRed(context)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Verify your " +
                        (_verify_by == "email"
                            ? "Email Account"
                            : "Phone Number"),
                    style: TextStyle(
                        color: ColorResources.getRed(context),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                      width: _screen_width * (3 / 4),
                      child: _verify_by == "email"
                          ? Text(
                              "Enter the verification code that sent to your email recently.",
                              textAlign: TextAlign.center,
                              style: titilliumRegular.copyWith(
                                  color: ColorResources.getRed(context)))
                          : Text(
                              "Enter the verification code that sent to your phone recently.",
                              textAlign: TextAlign.center,
                              style: titilliumRegular.copyWith(
                                  color: ColorResources.getRed(context)))),
                ),
                Container(
                    child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: ColorResources.getRed(context),
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  obscureText: true,
                  obscuringCharacter: '*',
                  // obscuringWidget: FlutterLogo(
                  //   size: 24,
                  // ),
                  blinkWhenObscuring: true,
                  animationType: AnimationType.slide,
                  validator: (v) {
                    if (v!.length < 3) {
                      return "I'm from validator";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor:
                        hasError ? Colors.blue.shade100 : Colors.white,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: _verificationCodeController,
                  keyboardType: TextInputType.number,
                  boxShadows: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    print("Completed");
                  },
                  // onTap: () {
                  //   print("Pressed");
                  // },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");

                    return true;
                  },
                )),
                Container(
                  width: _screen_width * (3 / 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 36,
                              child: TextField(
                                controller: _verificationCodeController,
                                autofocus: false,
                                keyboardType: TextInputType.phone,
                                decoration: buildInputDecoration_1(
                                    hint_text: "A X B 4 J H"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorResources.getRed(context),
                                width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12.0))),
                        child: FlatButton(
                          minWidth: MediaQuery.of(context).size.width,
                          //height: 50,
                          color: ColorResources.getRed(context),
                          shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0))),
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            verificationCode();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: InkWell(
                    onTap: () {
                      // onTapResend();
                      Navigator.pop(context);
                    },
                    child: Text("Resend Code",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorResources.getRed(context),
                            decoration: TextDecoration.underline,
                            fontSize: 13)),
                  ),
                ),
              ],
            )),
          )
        ],
      ),
    );
  }
}

class ShopupWidgetMainShop {}

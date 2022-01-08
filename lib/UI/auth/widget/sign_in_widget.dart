import 'package:flutter/material.dart';
import 'package:mobailshop/UI/auth/forget_password_screen.dart';
import 'package:mobailshop/UI/button/custom_button.dart';
import 'package:mobailshop/UI/dialog/animated_custom_dialog.dart';
import 'package:mobailshop/UI/dialog/my_dialog.dart';
import 'package:mobailshop/UI/dialog/show_custom_modal_dialog.dart';
import 'package:mobailshop/UI/textfield/custom_password_textfield.dart';
import 'package:mobailshop/UI/textfield/custom_textfield.dart';
import 'package:mobailshop/data/model/body/login_model.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/main.dart';
import 'package:mobailshop/provider/auth_provider.dart';
import '../../../provider/profile_provider.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/utill/dimensions.dart';

import 'package:provider/provider.dart';

import '../../../mainshop.dart';

late bool singInGuest;

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKeyLogin;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.text =
        (Provider.of<AuthProvider>(context, listen: false).getUserEmail());
    _passwordController.text =
        Provider.of<AuthProvider>(context, listen: false).getUserPassword();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();
  LoginModel loginBody = LoginModel();

  void loginUser() async {
    if (_formKeyLogin.currentState!.validate()) {
      _formKeyLogin.currentState!.save();

      String _email = _emailController.text.trim();
      String _password = _passwordController.text.trim();

      if (_email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('EMAIL_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else if (_password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else {
        if (Provider.of<AuthProvider>(context, listen: false).isRemember) {
          Provider.of<AuthProvider>(context, listen: false)
              .saveUserEmail(_email, _password);
        } else {
          Provider.of<AuthProvider>(context, listen: false)
              .clearUserEmailAndPassword();
        }

        loginBody.email = _email;
        loginBody.password = _password;
        await Provider.of<AuthProvider>(context, listen: false)
            .login(loginBody, route);
        getUserToken =
            Provider.of<AuthProvider>(context, listen: false).getUserToken();
      }
    }
  }

  route(bool isRoute, String errorMessage) async {
    if (isRoute) {
      await Provider.of<ProfileProvider>(context, listen: false)
          .getUserInfo(context);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => MainShop()), (route) => true);
    } else {
      showAnimatedDialog(
          context,
          MyDialog(
            title: 'عفوا',
            description: "$errorMessage",
            icon: Icons.outlet,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).isRemember;

    return Form(
      key: _formKeyLogin,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
        children: [
          // for Email
          Hero(
              transitionOnUserGestures: true,
              tag: 'email',
              child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.MARGIN_SIZE_LARGE,
                      right: Dimensions.MARGIN_SIZE_LARGE,
                      bottom: Dimensions.MARGIN_SIZE_SMALL),
                  child: CustomTextField(
                    hintText: getTranslated('ENTER_YOUR_EMAIL', context),
                    focusNode: _emailNode,
                    nextNode: _passNode,
                    textInputType: TextInputType.emailAddress,
                    controller: _emailController,
                  ))),

          // for Password
          Hero(
              transitionOnUserGestures: true,
              tag: 'pas',
              child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.MARGIN_SIZE_LARGE,
                      right: Dimensions.MARGIN_SIZE_LARGE,
                      bottom: Dimensions.MARGIN_SIZE_DEFAULT),
                  child: CustomPasswordTextField(
                    hintTxt: getTranslated('ENTER_YOUR_PASSWORD', context),
                    textInputAction: TextInputAction.done,
                    focusNode: _passNode,
                    controller: _passwordController,
                  ))),

          // for remember and forgetpassword
          Container(
            margin: EdgeInsets.only(
                left: Dimensions.MARGIN_SIZE_SMALL,
                right: Dimensions.MARGIN_SIZE_SMALL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) => Checkbox(
                        checkColor: ColorResources.WHITE,
                        activeColor: ColorResources.COLOR_PRIMARY,
                        value: authProvider.isRemember,
                        onChanged: (bool? value) {
                          authProvider.updateRemember(value!);
                        },
                      ),
                    ),
                    Text(getTranslated('REMEMBER', context),
                        style: titilliumRegular),
                  ],
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ForgetPasswordScreen())),
                  child: Text(getTranslated('FORGET_PASSWORD', context),
                      style: titilliumRegular.copyWith(
                          color: ColorResources.getRed(context))),
                ),
              ],
            ),
          ),

          // for signin button
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
            child: Provider.of<AuthProvider>(context).isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                : Hero(
                    transitionOnUserGestures: true,
                    child: CustomButton(
                        onTap: loginUser,
                        buttonText: getTranslated('SIGN_IN', context)),
                    tag: 'button',
                  ),
          ),

          SizedBox(height: 20),
          Center(
              child: Text(getTranslated('OR', context),
                  style: titilliumRegular.copyWith(fontSize: 12))),

          //for order as guest
          InkWell(
            onTap: () {
              setState(() {
                singInGuest = true;
              });
              print(singInGuest);

              if (!Provider.of<AuthProvider>(context, listen: false)
                  .isLoading) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainShop(),
                    ));
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 50, right: 50, top: 30),
              width: double.infinity,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: ColorResources.getHint(context), width: 1.0),
              ),
              child: Text(getTranslated('CONTINUE_AS_GUEST', context),
                  style: titilliumSemiBold.copyWith(
                      color: ColorResources.getRed(context))),
            ),
          ),
        ],
      ),
    );
  }
}

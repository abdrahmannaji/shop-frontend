import 'package:flutter/material.dart';
import 'package:mobailshop/UI/auth/auth_screen.dart';
import 'package:mobailshop/UI/auth/widget/otp.dart';
import 'package:mobailshop/UI/auth/widget/seller_wodget.dart';
import 'package:mobailshop/UI/button/custom_button.dart';
import 'package:mobailshop/mainshop.dart';
import 'package:mobailshop/UI/textfield/custom_password_textfield.dart';
import 'package:mobailshop/UI/textfield/custom_textfield.dart';
import 'package:mobailshop/data/model/body/register_model.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/provider/auth_provider.dart';
import 'package:mobailshop/provider/database.dart';
import '../../../provider/profile_provider.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/utill/dimensions.dart';

import 'package:provider/provider.dart';

bool typeaccont = false;

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  late GlobalKey<FormState> _formKey;

  FocusNode _fNameFocus = FocusNode();
  FocusNode _lNameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _confirmPasswordFocus = FocusNode();

  RegisterModel register = RegisterModel();
  bool isEmailVerified = false;

  addUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      isEmailVerified = true;

      String _firstName = _firstNameController.text.trim();
      String _email = _emailController.text.trim();
      String _phone = _phoneController.text.trim();
      String _password = _passwordController.text.trim();
      String _confirmPassword = _confirmPasswordController.text.trim();
      if (_firstName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('NAME_FIELD_MUST_BE_REQUIRED', context)),
          backgroundColor: ColorResources.red0001,
        ));
      } else if (_email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('EMAIL_MUST_BE_REQUIRED', context)),
          backgroundColor: ColorResources.red0001,
        ));
      } else if (_phone.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)),
          backgroundColor: ColorResources.red0001,
        ));
      } else if (_password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)),
          backgroundColor: ColorResources.red0001,
        ));
      } else if (_confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                getTranslated('CONFIRM_PASSWORD_MUST_BE_REQUIRED', context)),
            backgroundColor: ColorResources.red0001));
      } else if (_password != _confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_DID_NOT_MATCH', context)),
          backgroundColor: ColorResources.red0001,
        ));
      } else {
        if (typeaccont) {
          valueSign = true;
        } else {
          valueSign = false;
        }
        // ShopupWidget
        print(typeaccont);
        register.fName = _firstNameController.text;
        register.lName = _lastNameController.text;
        register.email = _emailController.text;
        register.phone = _phoneController.text;
        register.password = _passwordController.text;
        // register. = _confirmPasswordController.text;
        register.userType = typeaccont ? 'admin' : 'user';
        await Provider.of<AuthProvider>(context, listen: false)
            .registration(register, route);
      }
    } else {
      isEmailVerified = false;
    }
  }

  route(bool isRoute, String errorMessage) async {
    if (isRoute) {
      await Provider.of<ProfileProvider>(context, listen: false)
          .getUserInfo(context);
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (_) => Otp()), (route) => false);
      _emailController.clear();
      _passwordController.clear();
      _firstNameController.clear();
      _lastNameController.clear();
      _phoneController.clear();
      _confirmPasswordController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          backgroundColor: ColorResources.red0001));
    }
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  int _value = 0;
  @override
  Widget build(BuildContext context) {
    List nameRadio = [
      "USER",
      "SELLEER",
    ];
    return ListView(
      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
      children: [
        Row(
          children: [
            for (int i = 0; i < nameRadio.length; i++)
              Expanded(
                child: ListTile(
                  title: Text(
                    getTranslated(nameRadio[i], context),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: i == nameRadio.length ? Colors.black38 : null),
                  ),
                  leading: Radio(
                    value: i,
                    activeColor: ColorResources.red0001,
                    groupValue: _value,
                    onChanged: i == nameRadio.length
                        ? null
                        : (int? value) {
                            setState(() {
                              _value = value!;
                            });
                            if (i == 0) {
                              setState(() {
                                typeaccont = false;
                              });
                              print(typeaccont);
                            } else {
                              setState(() {
                                typeaccont = true;
                              });
                              print(typeaccont);
                            }
                          },
                  ),
                ),
              ),
          ],
        ),

        Form(
          key: _formKey,
          child: Column(
            children: [
              // for first and last name
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT),
                child: Row(
                  children: [
                    Expanded(
                        child: Hero(
                            tag: 'email',
                            child: CustomTextField(
                              hintText: getTranslated('FIRST_NAME', context),
                              textInputType: TextInputType.name,
                              focusNode: _fNameFocus,
                              nextNode: _lNameFocus,
                              isPhoneNumber: false,
                              capitalization: TextCapitalization.words,
                              controller: _firstNameController,
                            ))),
                    SizedBox(width: 15),
                    Expanded(
                        child: Hero(
                            tag: 'email',
                            child: CustomTextField(
                              hintText: getTranslated('LAST_NAME', context),
                              focusNode: _lNameFocus,
                              nextNode: _emailFocus,
                              capitalization: TextCapitalization.words,
                              controller: _lastNameController,
                            ))),
                  ],
                ),
              ),

              // for email
              Hero(
                  transitionOnUserGestures: true,
                  tag: 'email',
                  child: Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.MARGIN_SIZE_DEFAULT,
                        right: Dimensions.MARGIN_SIZE_DEFAULT,
                        top: Dimensions.MARGIN_SIZE_SMALL),
                    child: CustomTextField(
                      hintText: getTranslated('ENTER_YOUR_EMAIL', context),
                      focusNode: _emailFocus,
                      nextNode: _phoneFocus,
                      textInputType: TextInputType.emailAddress,
                      controller: _emailController,
                    ),
                  )),

              // for phone

              Hero(
                  transitionOnUserGestures: true,
                  tag: 'pas',
                  child: Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.MARGIN_SIZE_DEFAULT,
                        right: Dimensions.MARGIN_SIZE_DEFAULT,
                        top: Dimensions.MARGIN_SIZE_SMALL),
                    child: CustomTextField(
                      textInputType: TextInputType.number,
                      hintText: getTranslated('ENTER_MOBILE_NUMBER', context),
                      focusNode: _phoneFocus,
                      nextNode: _passwordFocus,
                      controller: _phoneController,
                      isPhoneNumber: true,
                    ),
                  )),

              // for password
              Hero(
                  transitionOnUserGestures: true,
                  tag: 'pas',
                  child: Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.MARGIN_SIZE_DEFAULT,
                        right: Dimensions.MARGIN_SIZE_DEFAULT,
                        top: Dimensions.MARGIN_SIZE_SMALL),
                    child: CustomPasswordTextField(
                      hintTxt: getTranslated('PASSWORD', context),
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      nextNode: _confirmPasswordFocus,
                      textInputAction: TextInputAction.next,
                    ),
                  )),

              // for re-enter password
              Hero(
                transitionOnUserGestures: true,
                tag: 'pas',
                child: Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.MARGIN_SIZE_DEFAULT,
                        right: Dimensions.MARGIN_SIZE_DEFAULT,
                        top: Dimensions.MARGIN_SIZE_SMALL),
                    child: CustomPasswordTextField(
                      hintTxt: getTranslated('RE_ENTER_PASSWORD', context),
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocus,
                      textInputAction: TextInputAction.done,
                    )),
              ),
            ],
          ),
        ),

        // for register button
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 40),
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
                      onTap: addUser,
                      buttonText: getTranslated('SIGN_UP', context)),
                  tag: 'button',
                ),
        ),

        // for skip for now
        Provider.of<AuthProvider>(context).isLoading
            ? SizedBox()
            : Center(
                child: TextButton(
                onPressed: () {
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (_) => DashBoardScreen()));
                },
                child: Text(getTranslated('SKIP_FOR_NOW', context),
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_SMALL,
                        color: ColorResources.getRed(context))),
              )),
      ],
    );
  }
}

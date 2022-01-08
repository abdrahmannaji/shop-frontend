import 'package:flutter/material.dart';
import 'package:mobailshop/UI/button/custom_button.dart';
import 'package:mobailshop/mainshop.dart';
import 'package:mobailshop/UI/textfield/custom_password_textfield.dart';
import 'package:mobailshop/UI/textfield/custom_textfield.dart';
import 'package:mobailshop/data/model/body/login_model.dart';
import 'package:mobailshop/data/model/body/registershop_model.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/provider/auth_provider.dart';
import 'package:mobailshop/provider/profile_provider.dart';
import 'package:mobailshop/provider/shop_provder.dart';
import 'package:mobailshop/provider/theme_provider.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/dimensions.dart';
import 'package:mobailshop/utill/images.dart';
import 'package:mobailshop/main.dart';
import 'package:provider/provider.dart';

import 'otp.dart';

class ShopupWidget extends StatefulWidget {
  @override
  _ShopupWidgetState createState() => _ShopupWidgetState();
}

class _ShopupWidgetState extends State<ShopupWidget> {
  late TextEditingController _nameShopController;
  late TextEditingController _adrssecShopController;
  TextEditingController controller = TextEditingController();
  late TextEditingController _phoneShopController;
  late GlobalKey<FormState> _formKeyLogin;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();

    _nameShopController = TextEditingController();
    _adrssecShopController = TextEditingController();
    _phoneShopController = TextEditingController();

    print('as$userid');
    // _nameShopController.text =
    //     (Provider.of<ShopProvider>(context, listen: false).getShopName());
    // _adrssecShopController.text =
    //     Provider.of<ShopProvider>(context, listen: false).getUserPassword();
  }

  @override
  void dispose() {
    _nameShopController.dispose();
    _adrssecShopController.dispose();
    _phoneShopController.dispose();
    super.dispose();
  }

  FocusNode _nameNode = FocusNode();
  FocusNode _adrssecNode = FocusNode();
  FocusNode _phoneNode = FocusNode();
  ShopModel shopModel = ShopModel();

  void loginShop() async {
    if (_formKeyLogin.currentState!.validate()) {
      _formKeyLogin.currentState!.save();

      String _nameShop = _nameShopController.text.trim();
      String _adrssecShop = _adrssecShopController.text.trim();
      String _phoneShop = _adrssecShopController.text.trim();

      if (_nameShop.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('EMAIL_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else if (_adrssecShop.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else {
        if (Provider.of<ShopProvider>(context, listen: false).isRemember) {
          Provider.of<ShopProvider>(context, listen: false)
              .saveShopNameandAdrssec(_nameShop, _adrssecShop);
        } else {
          Provider.of<ShopProvider>(context, listen: false)
              .clearUserEmailAndPassword();
        }
        print('as$userid');
        shopModel.nameShop = _nameShop;
        shopModel.userid = userid;
        shopModel.address = _adrssecShop;
        shopModel.phone = _phoneShop;
        await Provider.of<ShopProvider>(context, listen: false)
            .registration(shopModel, route);
      }
    }
  }

  route(bool isRoute, String? errorMessage) async {
    if (isRoute) {
      await Provider.of<ProfileProvider>(context, listen: false)
          .getUserInfo(context);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => MainShop()), (route) => true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKeyLogin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // padding:
            //     EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
            children: [
              Image.asset(Images.logo_with_name_image,
                  height: 150,
                  width: 200,
                  color: ColorResources.getRed(context)),
              Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.MARGIN_SIZE_LARGE,
                      right: Dimensions.MARGIN_SIZE_LARGE,
                      bottom: Dimensions.MARGIN_SIZE_SMALL),
                  child: CustomTextField(
                    hintText: getTranslated('ENTER_ShopName', context),
                    focusNode: _nameNode,
                    textInputAction: TextInputAction.next,
                    nextNode: _adrssecNode,
                    controller: _nameShopController,
                  )),
              Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.MARGIN_SIZE_LARGE,
                      right: Dimensions.MARGIN_SIZE_LARGE,
                      bottom: Dimensions.MARGIN_SIZE_DEFAULT),
                  child: CustomTextField(
                    hintText: getTranslated('ENTER_SHOPADRSSEC', context),
                    textInputAction: TextInputAction.next,
                    focusNode: _adrssecNode,
                    nextNode: _phoneNode,
                    controller: _adrssecShopController,
                  )),
              Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.MARGIN_SIZE_LARGE,
                      right: Dimensions.MARGIN_SIZE_LARGE,
                      bottom: Dimensions.MARGIN_SIZE_SMALL),
                  child: CustomTextField(
                    hintText: getTranslated('ENTER_PHONEDHOP', context),
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    focusNode: _phoneNode,
                    controller: _phoneShopController,
                  )),
              Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
                child: Provider.of<AuthProvider>(context).isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    : CustomButton(
                        onTap: loginShop,
                        buttonText: getTranslated('SIGN_UP', context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

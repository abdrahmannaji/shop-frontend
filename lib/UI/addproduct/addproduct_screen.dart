
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:mobailshop/UI/dialog/animated_custom_dialog.dart';
import 'package:mobailshop/UI/dialog/my_dialog.dart';
import 'package:mobailshop/mainaccont.dart';

import 'package:mobailshop/mainshop.dart';

import 'package:mobailshop/UI/addproduct/widget/dropdown_widget.dart';
import 'package:mobailshop/UI/button/custom_button.dart';
import 'package:mobailshop/UI/textfield/custom_textfield.dart';
import 'package:mobailshop/UI/widget/viewImage.dart';

import 'package:mobailshop/data/model/body/addproduct_modil.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/main.dart';
import 'package:mobailshop/provider/addproduct_provider.dart';
import '../../provider/get_shop_provider.dart';
import 'package:mobailshop/provider/profile_provider.dart';
import 'package:mobailshop/sryle.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/dimensions.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

var shopid;

class Addproduct extends StatefulWidget {
  @override
  _AddproductState createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  late GlobalKey<FormState> _formKey;
  AddproductModile addproductModile = AddproductModile();
  Color? _color;
  void addproduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String _battery = _battery_capacityController.text.trim();
      String _phonesize = _phone_sizeController.text.trim();
      String _phoneWeight = _phone_WeightController.text.trim();
      String _phoneVersion = _phone_VersionController.text.trim();
      String _unitprice = unitpriceController.text.trim();
      String _purchaseprice = purchasepriceController.text.trim();
      String _tax = taxController.text.trim();
      String _dscount = dscountController.text.trim();
      String _description = product_DescriptionController.text.trim();
      String _quantity = quantityController.text.trim();
      String _typephone = typephone.trim();
      String _colors = colors.trim();
      String _status = status.trim();
      String _ram = ram.trim();
      String _rom = rom.trim();

      addproductModile.name = namephone;
      addproductModile.typePhone = _typephone;
      addproductModile.batteryCapacity = _battery;
      addproductModile.colors = _colors;
      addproductModile.description = _description;
      addproductModile.dscount = int.parse(_dscount);
      addproductModile.phoneSize = _phonesize;
      addproductModile.phoneVersion = _phoneVersion;
      addproductModile.phoneWeight = _phoneWeight;
      addproductModile.status = _status;
      addproductModile.rom = _rom;
      addproductModile.rem = _ram;
      addproductModile.purchasePrice = int.parse(_purchaseprice);
      addproductModile.quantity = int.parse(_quantity);
      addproductModile.tax = int.parse(_tax);
      addproductModile.unitPrice = int.parse(_unitprice);
      _getColor();
      await Provider.of<AddproductProvider>(context, listen: false)
          .addproduct(addproductModile, route, imageget, _color);
    }
  }

  route(bool isRoute, String? errorMessage) async {
    if (isRoute) {
      await Provider.of<ProfileProvider>(context, listen: false)
          .getUserInfo(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("errorMessage"), backgroundColor: Colors.red));
      // Navigator.pushAndRemoveUntil(
      //     context, MaterialPageRoute(builder: (_) => Otp()), (route) => true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!), backgroundColor: Colors.red));
    }
  }

  TextEditingController _nameProductController = TextEditingController();

  FocusNode _phoneFocus = FocusNode();
  bool phoneFocus = false;
  bool valueSign = false;

  @override
  void initState() {
    super.initState();

    _battery_capacityController = TextEditingController();
    _phone_sizeController = TextEditingController();
    _phone_WeightController = TextEditingController();
    _phone_VersionController = TextEditingController();
    unitpriceController = TextEditingController();
    purchasepriceController = TextEditingController();
    taxController = TextEditingController();
    dscountController = TextEditingController();
    product_DescriptionController = TextEditingController();
    quantityController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _battery_capacityController.dispose();
    _phone_sizeController.dispose();
    _phone_WeightController.dispose();
    _phone_VersionController.dispose();
    unitpriceController.dispose();
    purchasepriceController.dispose();
    taxController.dispose();
    dscountController.dispose();
    product_DescriptionController.dispose();
    quantityController.dispose();

    super.dispose();
  }

  bool valimage = false;
  getImage() async {
    PickedFile? pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image1 = pickedFile.path;
      final mimeType = lookupMimeType(image1!);
      if (mimeType == "image/png") {
        setState(() {
          imageget = File(image1!);
          valimage = true;
        });

        print("dsd${mimeType}");
        print("file path...");
        return imageget;
      } else {
        print('No image ');
        showAnimatedDialog(
            context,
            MyDialog(
              title: 'عفوا',
              description: "يجب ان تكون الصورة بصيغة (png)",
              icon: Icons.outlet,
            ));
      }
    } else {
      print('No image selected.');
      imageget = File(
          '/data/user/0/com.necn.mobailshop/cache/image_picker7531158760295821214.jpg');
    }
  }

  // late PaletteColor paletteColor;

  void _getColor() async {
    print('Before palette generator');
    PaletteGenerator palette =
        await PaletteGenerator.fromImageProvider(FileImage(imageget));
    print(palette.lightMutedColor!.color);
    // palette.vibrantColor.color==null?
    setState(() {
      _color = palette.lightVibrantColor!.color;
    });
    print("colorimg$_color");
  }

  String? image1;

  String namephone = '';
  String typephone = '';
  String colors = '';
  String status = '';
  String ram = '';
  String rom = '';
  late TextEditingController _phone_sizeController;
  late TextEditingController _phone_WeightController;
  late TextEditingController _battery_capacityController;
  late TextEditingController _phone_VersionController;
  late TextEditingController unitpriceController;
  late TextEditingController purchasepriceController;
  late TextEditingController taxController;
  late TextEditingController dscountController;
  late TextEditingController quantityController;
  late TextEditingController product_DescriptionController;
  FocusNode _phone_sizeFocus = FocusNode();
  FocusNode _phone_WeightFocus = FocusNode();
  FocusNode _battery_capacityFocus = FocusNode();
  FocusNode _phone_VersionFocus = FocusNode();
  FocusNode unitprice = FocusNode();
  FocusNode purchaseprice = FocusNode();
  FocusNode product_Description = FocusNode();
  FocusNode tax = FocusNode();
  FocusNode iscount = FocusNode();
  FocusNode quantity = FocusNode();
  bool descriptionval = false;
  bool valueprice = false;
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.backgrond,
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              controller: controller,
              child: Column(children: [
                Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.MARGIN_SIZE_DEFAULT,
                        right: Dimensions.MARGIN_SIZE_DEFAULT,
                        top: 30),
                    child: Row(
                      children: [
                        Container(
                          // height: 100,
                          // width: 100,

                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  getImage();
                                  print(image1);
                                },
                                child: Container(
                                    height: 87,
                                    width: 93,
                                    decoration: BoxDecoration(
                                      color: ColorResources.getBlue(context),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorResources.HINT_TEXT_COLOR,
                                          blurRadius: 0.5,
                                        ),
                                      ],
                                    ),
                                    margin: EdgeInsets.all(3),
                                    child: valimage == true
                                        ? Container(
                                            child: Image.file(
                                              imageget,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .add_photo_alternate_rounded,
                                                color: ColorResources.white,
                                                size: 30,
                                              ),
                                              Text(
                                                'الصورة الرئيسية',
                                                style: TextStyle(
                                                    color: ColorResources.white,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 120,
                                    child: Text(
                                      'اضف الصورة الرئيسية بصيغة png',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                  child: Column(children: [
                                Container(
                                    height: 100,
                                    margin: EdgeInsets.only(bottom: 30),
                                    child: AddImage()),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //       'الصور تزيد البيع بنسبة 80%',
                                //       style: TextStyle(
                                //           color: Colors.red, fontSize: 14),
                                //     ),
                                //   ],
                                // ),
                              ])),
                            ],
                          ),
                        ),
                      ],
                    )),
                sizedbox,
                Text(
                  'معلومات عامة',
                  style: TextStyle(
                    fontFamily: 'TitilliumWeb',
                    // color: ColorResources.getHint(context),
                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Divider(
                  height: 12,
                  // endIndent: 4,
                  color: ColorResources.BLACK,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   margin: EdgeInsets.only(
                    //       left: Dimensions.MARGIN_SIZE_DEFAULT,
                    //       right: Dimensions.MARGIN_SIZE_DEFAULT,
                    //       top: Dimensions.MARGIN_SIZE_SMALL),
                    //   child: CustomTextField(
                    //     hintText: getTranslated('Product_Name', context),
                    //     // focusNode: _emailFocus,
                    //     nextNode: _phoneFocus,

                    //     textInputType: TextInputType.emailAddress,
                    //     controller: _nameProductController,
                    //   ),
                    // ),
                    Dropdown(
                      showSearchBox: false,
                      intTayp: 0,
                      margin: EdgeInsets.only(
                          left: Dimensions.MARGIN_SIZE_DEFAULT,
                          right: Dimensions.MARGIN_SIZE_DEFAULT,
                          top: Dimensions.MARGIN_SIZE_SMALL),
                      onChanged: (userModel) {
                        idphone = userModel!.phone.names.id;
                        // setState(() {
                        namephone = userModel.phone.names.name;
                        // });
                        print(namephone);
                      },
                      selectItem: "الشركة",
                      // showSearchBox: true,
                    ),
                    Dropdown(
                      showSearchBox: true,
                      intTayp: 1,
                      margin: EdgeInsets.only(
                          left: Dimensions.MARGIN_SIZE_DEFAULT,
                          right: Dimensions.MARGIN_SIZE_DEFAULT,
                          top: Dimensions.MARGIN_SIZE_SMALL),
                      onChanged: (userModel) {
                        setState(() {
                          valueSign = true;
                          typephone = userModel!.phone.phonetypes.phonetype!;
                        });
                        print(typephone);
                      },
                      selectItem: "الفئه",
                      // showSearchBox: true,
                    ),
                  ],
                ),
                valueSign
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              // width: 370,
                              margin: EdgeInsets.only(
                                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                                  right: Dimensions.MARGIN_SIZE_DEFAULT,
                                  top: 30),
                              child: Column(
                                children: [
                                  Text(
                                    'مواصفات الهاتف',
                                    style: TextStyle(
                                      fontFamily: 'TitilliumWeb',
                                      // color: ColorResources.getHint(context),
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Divider(
                                    height: 12,
                                    // endIndent: 4,
                                    color: ColorResources.BLACK,
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.only(
                                      top: Dimensions.MARGIN_SIZE_SMALL,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: CustomTextField(
                                          hintText: getTranslated(
                                              'Phone_size', context),
                                          textInputType: TextInputType.name,
                                          focusNode: _phone_sizeFocus,
                                          nextNode: _phone_WeightFocus,
                                          capitalization:
                                              TextCapitalization.words,
                                          controller: _phone_sizeController,
                                        )),
                                        SizedBox(width: 15),
                                        Expanded(
                                            child: CustomTextField(
                                          hintText: getTranslated(
                                              'Phone_Weight', context),
                                          focusNode: _phone_WeightFocus,
                                          nextNode: _battery_capacityFocus,

                                          capitalization:
                                              TextCapitalization.words,
                                          // isValidator: ,
                                          controller: _phone_WeightController,
                                        )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.only(
                                      top: Dimensions.MARGIN_SIZE_SMALL,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: CustomTextField(
                                          hintText: getTranslated(
                                              'Battery_capacity', context),
                                          textInputType: TextInputType.name,
                                          focusNode: _battery_capacityFocus,
                                          nextNode: _phone_VersionFocus,
                                          capitalization:
                                              TextCapitalization.words,
                                          controller:
                                              _battery_capacityController,
                                        )),
                                        SizedBox(width: 15),
                                        Expanded(
                                            child: CustomTextField(
                                          hintText: getTranslated(
                                              'Phone_Version', context),
                                          focusNode: _phone_VersionFocus,
                                          nextNode: _phone_VersionFocus,
                                          capitalization:
                                              TextCapitalization.words,
                                          controller: _phone_VersionController,
                                        )),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Dropdown(
                                          showSearchBox: false,
                                          onChanged: (userModel) {
                                            setState(() {
                                              colors = userModel!.color;
                                            });
                                          },
                                          intTayp: 2,
                                          margin: EdgeInsets.only(
                                              top:
                                                  Dimensions.MARGIN_SIZE_SMALL),
                                          selectItem: "اللون",
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Dropdown(
                                          showSearchBox: false,
                                          intTayp: 5,
                                          onChanged: (userModel) {
                                            setState(() {
                                              status = userModel!.status;
                                            });
                                          },
                                          margin: EdgeInsets.only(
                                              left: 2,
                                              right: 2,
                                              top:
                                                  Dimensions.MARGIN_SIZE_SMALL),
                                          selectItem: "الحالة",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Dropdown(
                                          showSearchBox: false,
                                          intTayp: 3,
                                          onChanged: (userModel) {
                                            setState(() {
                                              ram = userModel!.ram;
                                            });
                                          },
                                          margin: EdgeInsets.only(
                                              top:
                                                  Dimensions.MARGIN_SIZE_SMALL),
                                          selectItem: "رام الهاتف",
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Dropdown(
                                          showSearchBox: false,
                                          onChanged: (userModel) {
                                            setState(() {
                                              valueprice = true;
                                              rom = userModel!.rom;
                                            });
                                          },
                                          intTayp: 4,
                                          margin: EdgeInsets.only(
                                              left: 2,
                                              right: 2,
                                              top:
                                                  Dimensions.MARGIN_SIZE_SMALL),
                                          selectItem: "سعة التخزين",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      )
                    : Container(),
                valueprice
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              // width: 370,
                              margin: EdgeInsets.only(
                                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                                  right: Dimensions.MARGIN_SIZE_DEFAULT,
                                  top: 30),
                              child: Column(
                                children: [
                                  Text(
                                    'سعر المنتج والمخزون',
                                    style: TextStyle(
                                      fontFamily: 'TitilliumWeb',
                                      // color: ColorResources.getHint(context),
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Divider(
                                    height: 12,
                                    // endIndent: 4,
                                    color: ColorResources.BLACK,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: Dimensions.MARGIN_SIZE_SMALL),
                                      child: CustomTextField(
                                        hintText:
                                            getTranslated('Quantity', context),
                                        focusNode: quantity,
                                        nextNode: quantity,
                                        capitalization:
                                            TextCapitalization.words,
                                        textInputType: TextInputType.number,
                                        controller: quantityController,
                                      )),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.only(
                                      top: Dimensions.MARGIN_SIZE_SMALL,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: CustomTextField(
                                          hintText: getTranslated(
                                              'Unit_price', context),
                                          textInputType: TextInputType.number,
                                          focusNode: unitprice,
                                          nextNode: _phone_WeightFocus,
                                          capitalization:
                                              TextCapitalization.words,
                                          controller: unitpriceController,
                                        )),
                                        SizedBox(width: 15),
                                        Expanded(
                                            child: CustomTextField(
                                          hintText: getTranslated(
                                              'Purchase_price', context),
                                          textInputType: TextInputType.number,
                                          focusNode: purchaseprice,
                                          nextNode: purchaseprice,

                                          capitalization:
                                              TextCapitalization.words,
                                          // isValidator: ,
                                          controller: purchasepriceController,
                                        )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.only(
                                      top: Dimensions.MARGIN_SIZE_SMALL,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: CustomTextField(
                                          hintText:
                                              getTranslated('Tax', context),
                                          textInputType: TextInputType.number,
                                          focusNode: tax,
                                          nextNode: _phone_VersionFocus,
                                          capitalization:
                                              TextCapitalization.words,
                                          controller: taxController,
                                        )),
                                        SizedBox(width: 15),
                                        Expanded(
                                            child: CustomTextField(
                                          onChanged: (dscountController) {
                                            setState(() {
                                              descriptionval = true;
                                            });
                                          },
                                          hintText: getTranslated(
                                              'Discount', context),
                                          textInputType: TextInputType.number,
                                          focusNode: iscount,
                                          textInputAction: TextInputAction.done,
                                          capitalization:
                                              TextCapitalization.none,
                                          controller: dscountController,
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      )
                    : Container(),
                descriptionval == true
                    ? Container(
                        // width: 370,
                        margin: EdgeInsets.only(
                            left: Dimensions.MARGIN_SIZE_DEFAULT,
                            right: Dimensions.MARGIN_SIZE_DEFAULT,
                            top: 30),
                        child: Column(children: [
                          Text(
                            'تفاصيل المنتج',
                            style: TextStyle(
                              fontFamily: 'TitilliumWeb',
                              // color: ColorResources.getHint(context),
                              fontSize: Dimensions.FONT_SIZE_DEFAULT,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Divider(
                            height: 12,
                            // endIndent: 4,
                            color: ColorResources.BLACK,
                          ),
                          Container(
                              height: 150,
                              margin: EdgeInsets.only(
                                  top: Dimensions.MARGIN_SIZE_SMALL),
                              child: CustomTextField(
                                border: false,
                                hintText: getTranslated(
                                    'Product_Description', context),
                                focusNode: product_Description,
                                textInputAction: TextInputAction.done,
                                capitalization: TextCapitalization.none,
                                controller: product_DescriptionController,
                              )),
                        ]))
                    : Container(),
                Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 40),
                  child:
                      //  Provider.of<AuthProvider>(context).isLoading
                      //     ? Center(
                      //         child: CircularProgressIndicator(
                      //           valueColor: new AlwaysStoppedAnimation<Color>(
                      //             Theme.of(context).primaryColor,
                      //           ),
                      //         ),
                      //       )
                      //     :
                      CustomButton(
                          onTap: addproduct,
                          buttonText: getTranslated('SIGN_UP', context)),
                ),
              ]),
            )));
  }
}

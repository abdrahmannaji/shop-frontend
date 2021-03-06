import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobailshop/UI/Reports/reports_screen.dart';
import 'package:mobailshop/UI/dialog/animated_custom_dialog.dart';
import 'package:mobailshop/UI/chat/home.dart';
import 'package:mobailshop/UI/dialog/my_dialog.dart';
import 'package:mobailshop/UI/more/web_view_screen.dart';
import 'package:mobailshop/UI/more/widget/app_info_dialog.dart';
import 'package:mobailshop/UI/more/widget/sign_out_confirmation_dialog.dart';
import 'package:mobailshop/UI/notification/notification_screen.dart';
import 'package:mobailshop/UI/order/order_screen.dart';
import 'package:mobailshop/UI/profile/address_list_screen.dart';
import 'package:mobailshop/UI/profile/profile_screen.dart';
import 'package:mobailshop/UI/wishlistuser/wishli_screen.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/mainaccont.dart';
import 'package:mobailshop/mainshop.dart';
import 'package:mobailshop/provider/auth_provider.dart';
import 'package:mobailshop/provider/get_shop_provider.dart';
import 'package:mobailshop/provider/profile_provider.dart';
import 'package:mobailshop/provider/theme_provider.dart';
import 'package:mobailshop/utill/app_constants.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/utill/dimensions.dart';
import 'package:mobailshop/utill/images.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isGuestMode =
        Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (!isGuestMode) {
      // Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
    }

    return Scaffold(
      body: Stack(children: [
        // Background
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            Images.more_page_header,
            height: 150,
            fit: BoxFit.fill,
            color: Provider.of<ThemeProvider>(context).darkTheme
                ? Colors.black
                : ColorResources.getPrimary(context),
          ),
        ),

        // AppBar
        Positioned(
          top: 40,
          left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL,
          child: Consumer<GetShopProvider>(
            builder: (context, profile, child) {
              return Row(children: [
                // Image.asset(Images.logo_with_name_image,
                //     height: 35, color: ColorResources.WHITE),
                Expanded(child: SizedBox.shrink()),
                InkWell(
                  onTap: () {
                    // print(isGuestMode);
                    if (!isGuestMode) {
                      return showAnimatedDialog(
                        context,
                        MyDialog(
                          title: '????????',
                          description: "k",
                          icon: Icons.outlet,
                        ),
                      );
                    } else {
                      print('Providerid');
                      // if (Provider.of<ProfileProvider>(context, listen: false)
                      //     .userInfoModel !=
                      // null) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen()));
                      // }
                    }
                  },
                  child: Row(children: [
                    Column(
                      children: [
                        Text(
                            isGuestMode
                                ? profile.status == true
                                    ? '${profile.getshop.nameShop}'
                                    : 'Full Name'
                                : 'Guest',
                            style: titilliumRegular.copyWith(
                                fontSize: 18, color: ColorResources.WHITE)),
                        Text(
                            isGuestMode
                                ? profile.status == true
                                    ? ' ${profile.getshop.address}'
                                    : 'Full Name'
                                : 'Guest',
                            style: titilliumRegular.copyWith(
                                color: ColorResources.WHITE)),
                      ],
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    !isGuestMode
                        ? CircleAvatar(child: Icon(Icons.person, size: 35))
                        : profile.status != true
                            ? CircleAvatar(child: Icon(Icons.person, size: 35))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: FadeInImage.assetNetwork(
                                  placeholder: Images.logo_image,
                                  width: 35,
                                  height: 35,
                                  fit: BoxFit.fill,
                                  image:
                                      "${AppConstants.BASE_URL}/uploads/avatars/${profile.getshop.logo}",
                                ),
                              ),
                  ]),
                ),
              ]);
            },
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 120),
          decoration: BoxDecoration(
            color: ColorResources.getIconBg(context),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: controller,
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

              // Top Row Items
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                SquareButton(
                    image: Images.shopping_image,
                    title: getTranslated('orders', context),
                    navigateTo: OrderScreen()),
                SquareButton(
                    image: Images.wishlist,
                    title: getTranslated('wishlistuser', context),
                    navigateTo: WishliScreen()),
                SquareButton(
                    image: Images.report,
                    title: getTranslated('Reports', context),
                    navigateTo: ReportsScreen()),
              ]),

              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              TitleButton(
                  image: Images.cardwallet,
                  title: getTranslated('my wallet', context),
                  navigateTo: Container()),

              TitleButton(
                  image: Images.follow,
                  title: getTranslated("Followers", context),
                  navigateTo: Container()),
              TitleButton(
                  image: Images.notification_filled,
                  title: getTranslated('notification', context),
                  navigateTo: NotificationScreen()),

              //TODO: seller

              TitleButton(
                image: Images.swap,
                title: getTranslated('switch account', context),
                // navigateTo: Container()
                navigateTo: WebViewScreen(
                  title: getTranslated('switch account', context),
                  url: Images.more_page_header,
                ),
              ),
              TitleButton(
                  image: Images.chats,
                  title: getTranslated('chats', context),
                  navigateTo: Home()),
              TitleButton(
                  image: Images.settings,
                  title: getTranslated('settings', context),
                  navigateTo: Container()),

              TitleButton(
                  image: Images.help_center,
                  title: getTranslated('faq', context),
                  navigateTo: Container()),
              TitleButton(
                  image: Images.about_us,
                  title: getTranslated('about_us', context),
                  navigateTo: Container()
                  // navigateTo: WebViewScreen(
                  //   title: getTranslated('about_us', context),
                  //   url: Provider.of<SplashProvider>(context, listen: false)
                  //       .configModel
                  //       .staticUrls
                  //       .aboutUs,
                  // )
                  ),

              ListTile(
                leading: Image.asset(Images.logo_image,
                    width: 25,
                    height: 25,
                    fit: BoxFit.fill,
                    color: ColorResources.getPrimary(context)),
                title: Text(getTranslated('app_info', context),
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE)),
                onTap: () =>
                    showAnimatedDialog(context, AppInfoDialog(), isFlip: true),
              ),

              isGuestMode
                  ? SizedBox()
                  : ListTile(
                      leading: Icon(Icons.exit_to_app,
                          color: ColorResources.getPrimary(context), size: 25),
                      title: Text(getTranslated('sign_out', context),
                          style: titilliumRegular.copyWith(
                              fontSize: Dimensions.FONT_SIZE_LARGE)),
                      onTap: () => showAnimatedDialog(
                          context, SignOutConfirmationDialog(),
                          isFlip: true),
                    ),
              SizedBox(height: 70),
            ]),
          ),
        ),
      ]),
    );
  }
}

class SquareButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;

  SquareButton(
      {required this.image, required this.title, required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 100;
    return InkWell(
      onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => navigateTo,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            transitionDuration: Duration(milliseconds: 500),
          )),
      // onTap: () => Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => navigateTo)),
      child: Column(children: [
        Container(
          width: width / 4,
          height: width / 4,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorResources.getPrimary(context),
          ),
          child: Image.asset(image, color: Theme.of(context).accentColor),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(title, style: titilliumRegular),
        ),
      ]),
    );
  }
}

class TitleButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;
  TitleButton(
      {required this.image, required this.title, required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(image,
          width: 25,
          height: 25,
          fit: BoxFit.fill,
          color: ColorResources.getPrimary(context)),
      title: Text(title,
          style:
              titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      // onTap: () => Navigator.push(
      //   context,
      //   PageRouteBuilder(
      //     transitionDuration: Duration(seconds: 1),
      //     pageBuilder: (context, animation, secondaryAnimation) => navigateTo,
      //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //       animation =
      //           CurvedAnimation(parent: animation, curve: Curves.bounceInOut);
      //       return ScaleTransition(
      //           scale: animation, child: child, alignment: Alignment.center);
      //     },
      //   ),
      // MaterialPageRoute(builder: (_) => navigateTo),
      // ),
      onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => navigateTo,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            transitionDuration: Duration(milliseconds: 500),
          )),
    );
  }
}

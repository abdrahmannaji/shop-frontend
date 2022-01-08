import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobailshop/UI/auth/auth_screen.dart';
import 'package:mobailshop/UI/auth/widget/sign_in_widget.dart';
import 'package:mobailshop/mainshop.dart';
import 'package:mobailshop/UI/theme/dark_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:mobailshop/provider/addproduct_provider.dart';
import 'package:mobailshop/provider/auth_provider.dart';
import 'provider/get_shop_provider.dart';
import 'package:mobailshop/provider/localization_provider.dart';
import 'package:mobailshop/provider/order_provider.dart';
import 'package:mobailshop/provider/product_provider.dart';
import 'package:mobailshop/provider/shop_provder.dart';
import 'provider/profile_provider.dart';
import 'package:mobailshop/provider/theme_provider.dart';
import 'package:mobailshop/utill/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UI/theme/light_theme.dart';
import 'di_container.dart' as di;
import 'localization/app_localization.dart';

var userid;
var getUserToken;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ShopProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AddproductProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<GetShopProvider>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  StatelessElement createElement() => StatelessElement(this);
  getsingInGuest() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    singInGuest = _prefs.getBool("Guest") ?? false;
    print(singInGuest);
    return singInGuest;
  }

  @override
  Widget build(BuildContext context) {
    userid = (Provider.of<AuthProvider>(context, listen: false).getUserid());
    // Provider.of<AuthProvider>(context, listen: false).clearSharedData();
    getUserToken =
        Provider.of<AuthProvider>(context, listen: false).getUserToken();
    // Provider.of<AuthProvider>(context, listen: false).clearSharedData();
    var isLoggedIn =
        Provider.of<AuthProvider>(context, listen: false).isLoggedIn();

    print("التوكن الخاص بك هو :$getUserToken");
    print(isLoggedIn);
    getsingInGuest();

    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ScreenUtilInit(
            designSize: Size(410, 690),
            builder: () => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                          create: (context) => di.sl<AuthProvider>()),
                    ],
                    child: MaterialApp(
                      // navigatorKey: navigatorKey,
                      debugShowCheckedModeBanner: false,
                      theme: Provider.of<ThemeProvider>(context).darkTheme
                          ? dark
                          : light,
                      locale: Provider.of<LocalizationProvider>(context).locale,
                      localizationsDelegates: [
                        AppLocalization.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: _locals,
                      routes: {
                        // 'accontuser': (context) => AccountShop(
                        //       taypshop: 'usrt',
                        //     ),
                        'accontShop': (context) => AuthScreen(
                            // taypshop: 'admin',
                            ),
                        'mainshop': (context) => MainShop()
                      },
                      initialRoute: isLoggedIn ? 'mainshop' : 'accontShop',

                      // singInGuest ? MainShop() : AuthScreen(),
                    ))));
  }
}

// Widget _buildBackground(double width) {
//   return ClipPath(
//     clipper: AppClipper(cornerSize: 25, diagonalHeight: 100),
//     child: Container(
//       color: Color(0xFFCA3434),
//       width: width,
//       child: Stack(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20),
//                   child: Icon(
//                     Icons.no_drinks,
//                     size: 30,
//                     color: Colors.white,
//                   ),
//                 ),
//                 Expanded(child: SizedBox()),
//                 Container(
//                   width: 125,
//                   child: Text(
//                     "shoeList",
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   "shoeList[index].price",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: AppColors.greenColor,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10),
//                 ),
//               ),
//               child: Center(
//                 child: Icon(
//                   Icons.add,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }

// class AppClipper extends CustomClipper<Path> {
//   final double cornerSize;
//   final double diagonalHeight;
//   final bool roundedBottom;
//   AppClipper(
//       {required this.cornerSize,
//       required this.diagonalHeight,
//       this.roundedBottom = true});

//   @override
//   Path getClip(Size size) {
//     Path path = new Path();

//     path.moveTo(0, cornerSize * 1.5);
//     path.lineTo(0, size.height - (roundedBottom ? cornerSize : 0));

//     if (roundedBottom)
//       path.quadraticBezierTo(0, size.height, cornerSize, size.height);
//     path.lineTo(size.width - (roundedBottom ? cornerSize : 0), size.height);

//     if (roundedBottom)
//       path.quadraticBezierTo(
//           size.width, size.height, size.width, size.height - cornerSize);
//     path.lineTo(size.width, diagonalHeight + cornerSize);
//     path.quadraticBezierTo(size.width, diagonalHeight, size.width - cornerSize,
//         diagonalHeight * .9);
//     path.lineTo(cornerSize * 2, cornerSize);
//     path.quadraticBezierTo(0, 0, 0, cornerSize * 1.5);

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
// }

// class AppColors {
//   static final Color blueColor = Color(0XFF0c99c3);
//   static final Color greenColor = Color(0XFF3dc39d);
//   static final Color yellowColor = Color(0XFFdac007);
//   static final Color redColor = Color(0XFFbe0b2b);
//   static final Color orangeColor = Color(0XFFbe740b);
// }

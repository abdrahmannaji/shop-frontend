import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mobailshop/UI/notification/widget/notification_dialog.dart';
import 'package:mobailshop/UI/widget/custom_app_bar.dart';
import 'package:mobailshop/helper/date_converter.dart';
import 'package:mobailshop/localization/language_constrants.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';
import 'package:mobailshop/utill/dimensions.dart';
import 'package:mobailshop/utill/images.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  final bool isBacButtonExist;
  NotificationScreen({this.isBacButtonExist = true});

  @override
  Widget build(BuildContext context) {
    // Provider.of<NotificationProvider>(context, listen: false).initNotificationList(context);

    return Scaffold(
      body: Column(children: [
        CustomAppBar(
            title: getTranslated('notification', context),
            isBackButtonExist: isBacButtonExist),
        Expanded(
            child:
                //  Consumer<NotificationProvider>(
                //   builder: (context, notification, child) {
                //     return notification.notificationList != null ? notification.notificationList.length != 0 ?
                RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            // await Provider.of<NotificationProvider>(context, listen: false).initNotificationList(context);
          },
          child: ListView.builder(
            itemCount: 2,
            // Provider.of<NotificationProvider>(context).notificationList.length,
            padding:
                EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
            itemBuilder: (context, index) {
              return InkWell(
                // onTap: () => showDialog(context: context, builder: (context) => NotificationDialog(notificationModel: notification.notificationList[index])),
                child: Container(
                  margin:
                      EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                  color: ColorResources.GREY,
                  child: ListTile(
                    leading: ClipOval(
                        child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder,
                      image: Images.placeholder,
                      //  '${Provider.of<SplashProvider>(context, listen: false).baseUrls.notificationImageUrl}/${notification.notificationList[index].image}',
                      height: 50, width: 50, fit: BoxFit.cover,
                    )),
                    title: Text("notification",
                        style: titilliumRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_SMALL,
                        )),
                    subtitle: Text(
                      // DateFormat('hh:mm  dd/MM/yyyy').format(
                      //     DateConverter.isoStringToLocalDate(
                      "22:23 2020/12/22"
                      // ))
                      ,
                      style: titilliumRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          color: ColorResources.getHint(context)),
                    ),
                  ),
                ),
              );
            },
          ),
        )
            // : NoInternetOrDataScreen(isNoInternet: false) : NotificationShimmer();
            // },
            // ),
            ),
      ]),
    );
  }
}

class NotificationShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
          color: ColorResources.GREY,
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            // enabled: Provider.of<NotificationProvider>(context).notificationList == null,
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.notifications)),
              title: Container(height: 20, color: ColorResources.WHITE),
              subtitle:
                  Container(height: 10, width: 50, color: ColorResources.WHITE),
            ),
          ),
        );
      },
    );
  }
}

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:mobailshop/data/model/response/dropdownsearchmodeil.dart';
import 'package:mobailshop/utill/app_constants.dart';
import 'package:mobailshop/utill/color_resources.dart';
import 'package:mobailshop/utill/custom_themes.dart';

late int idphone = 1;

// ignore: must_be_immutable
class Dropdown extends StatelessWidget {
  EdgeInsetsGeometry? margin;
  String selectItem;
  bool showSearchBox;
  void Function(UserModel?) onChanged;
  int intTayp;

  Dropdown(
      {required this.onChanged,
      required this.selectItem,
      required this.intTayp,
      required this.showSearchBox,
      this.margin});
  Widget listtile(
      BuildContext context, isSelected, text, itemcolors, String? img) {
    return ListTile(
      selected: isSelected,
      title: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
      leading: intTayp == 0
          ? CircleAvatar(
              backgroundColor: ColorResources.white,
              child:
                  Image.network("http://172.16.0.6:3001/uploads/avatars/$img"),
            )
          : intTayp == 2
              ? Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: itemcolors == "ابيض"
                          ? ColorResources.white
                          : itemcolors == "ازرق"
                              ? Colors.blue
                              : itemcolors == "احمر"
                                  ? ColorResources.red0001
                                  : Color(0xFF980BF7),
                      border: Border.all(
                          width: 1, color: ColorResources.getBlue(context))),
                )
              : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    // UserModel? selectedItem;
    return Container(
        height: 45,
        margin: margin,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 1))
          ],
        ),
        child: DropdownSearch<UserModel?>(
          // maxHeight: 450,
          mode: Mode.DIALOG,
          // selectedItem: selectedItem,
          dropdownBuilderSupportsNullItem: true,
          showSelectedItem: false,
          showSearchBox: showSearchBox,
          onFind: (filter) => getData(filter),
          itemAsString: (item) {
            return item!.phone.phonetypes.phonetype!;
          },

          dropdownBuilder:
              (BuildContext context, UserModel? item, String itemDesignation) {
            if (item == null) {
              return Container(
                child: Text(
                  selectItem,
                  style: titilliumRegular.copyWith(
                      color: Theme.of(context).hintColor),
                ),
              );
            }
            // print('sljh');
            return Container(
              child: ListTile(
                title: Text(
                  (intTayp == 0
                      ? item.phone.names.name
                      : intTayp == 1
                          ? item.phone.phonetypes.phonetype
                          : intTayp == 2
                              ? item.color
                              : intTayp == 3
                                  ? "${item.ram} جيجا بايت"
                                  : intTayp == 4
                                      ? "${item.rom} جيجا بايت"
                                      : item.status)!,
                ),
              ),
            );
          },

          popupItemBuilder:
              (BuildContext context, UserModel? item, bool isSelected) {
            // print(item!.phone.names.name);
            if (item == null) {
              return Container(
                child: Text(
                  "selectItem",
                  style: titilliumRegular.copyWith(
                      color: Theme.of(context).hintColor),
                ),
              );
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: !isSelected
                  ? null
                  : BoxDecoration(
                      border: Border.all(
                        color: ColorResources.getBlue(context),
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
              child: intTayp == 0
                  ? Column(
                      children: [
                        item.phone.names.name == ''
                            ? Container()
                            : listtile(
                                context,
                                isSelected,
                                item.phone.names.name,
                                item.color,
                                item.phone.logophonne)
                      ],
                    )
                  : intTayp == 1
                      ? Column(
                          children: [
                            if (item.phone.phonetypes.id == idphone)
                              item.phone.phonetypes.phonetype == ''
                                  ? Container()
                                  : listtile(
                                      context,
                                      isSelected,
                                      item.phone.phonetypes.phonetype,
                                      item.color,
                                      item.phone.logophonne),
                          ],
                        )
                      : intTayp == 2
                          ? Column(
                              children: [
                                item.color == ''
                                    ? Container()
                                    : listtile(context, isSelected, item.color,
                                        item.color, item.phone.logophonne)
                              ],
                            )
                          : intTayp == 3
                              ? Column(
                                  children: [
                                    item.ram == ''
                                        ? Container()
                                        : listtile(
                                            context,
                                            isSelected,
                                            "${item.ram} جيجا بايت",
                                            item.color,
                                            item.phone.logophonne)
                                  ],
                                )
                              : intTayp == 4
                                  ? Column(
                                      children: [
                                        item.rom == ''
                                            ? Container()
                                            : listtile(
                                                context,
                                                isSelected,
                                                "${item.rom} جيجا بايت",
                                                item.color,
                                                item.phone.logophonne)
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        item.status == ''
                                            ? Container()
                                            : listtile(
                                                context,
                                                isSelected,
                                                item.status,
                                                item.color,
                                                item.phone.logophonne)
                                      ],
                                    ),
            );
          },
          dropDownButton: Icon(Icons.arrow_drop_down_circle_outlined),
          onChanged: onChanged,
          autoFocusSearchBox: true,

          dropdownSearchDecoration: InputDecoration(
            isDense: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorResources.Red0001)),
            hintStyle:
                titilliumRegular.copyWith(color: Theme.of(context).hintColor),
            contentPadding: EdgeInsets.all(8),
            border: InputBorder.none,
          ),
          searchBoxDecoration: InputDecoration(
            isDense: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorResources.Red0001)),
            hintStyle:
                titilliumRegular.copyWith(color: Theme.of(context).hintColor),
            errorStyle: TextStyle(height: 1.5),
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(20, 5, 3, 0),
            labelText: "Search a country",
          ),

          popupShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),

          compareFn: (i, s) => i!.isEqual(s),
        ));
  }

  Future<List<UserModel>> getData(filter) async {
    var response = await Dio().get(
      "${AppConstants.BASE_URL}api/v1/prodauctItem",
      queryParameters: {"filter": filter},
    );

    final data = response.data;
    print(data);
    if (data != null) {
      return UserModel.fromJsonList(data);
    }

    return [];
  }
}

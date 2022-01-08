import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mobailshop/utill/color_resources.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

var pathimge;
List<Asset> image = <Asset>[];

class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  String _error = 'No Error Dectected';

  // late Future<ByteData> byteData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100,
          padding: EdgeInsets.all(4),
          child: Row(
            children: [
              Expanded(
                  child: ListView(
                scrollDirection: Axis.horizontal,
                // crossAxisCount: 1,
                children: [
                  for (int i = 0; i < 1 + image.length; i++)
                    i == 0
                        ? Container(
                            width: 100,
                            child: InkWell(
                              onTap: () {
                                loadAssets();
                              },
                              child: Container(
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
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_photo_alternate_rounded,
                                        color: ColorResources.white,
                                        size: 30,
                                      ),
                                      Text(
                                        'اضافة صورة',
                                        style: TextStyle(
                                            color: ColorResources.white,
                                            fontSize: 16),
                                      ),
                                    ],
                                  )),
                            ),
                          )
                        : Row(
                            children: [
                              Container(
                                  width: 100,
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorResources.HINT_TEXT_COLOR,
                                          blurRadius: 0.5,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      )),
                                  child: AssetThumb(
                                    asset: image[i - 1],
                                    width: 300,
                                    height: 300,
                                  )),
                            ],
                          )
                ],
              )),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    _error = error;
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: image,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      image = resultList;
      _error = error;
    });
    print(image);
  }
}

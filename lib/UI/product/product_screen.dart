import 'package:flutter/material.dart';
import 'package:mobailshop/Animation/FadeAnimation.dart';
import 'package:mobailshop/UI/addproduct/addproduct_screen.dart';
import 'package:mobailshop/UI/widget/makeItem.dart';
import 'package:mobailshop/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<ProductProvider>(context, listen: false)
  //       .getLatestProductList(context);
  // }

  @override
  Widget build(BuildContext context) {
    print("aqqq$shopid");
    Provider.of<ProductProvider>(context, listen: false)
        .getLatestProductList(context, shopid);
    return Container(
      child:
          Consumer<ProductProvider>(builder: (context, productProvider, child) {
        // print(
        //     'colo ${}');
        // var colo = ;
        return productProvider.firstLoading == false
            ? Wrap(
                direction: Axis.horizontal,
                // gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2),
                // itemCount: productProvider.latestProductList.data.length,
                // itemBuilder: (context, index) {

                children: [
                  for (int i = 0;
                      i < productProvider.latestProductList.product.length;
                      i++)
                    Container(
                      margin: EdgeInsets.all(5),
                      width: 180,
                      child: FadeAnimation(
                          1.5,
                          makeItem(
                            image: productProvider
                                .latestProductList.product[i].mainimage,
                            tag: 'red',
                            name: productProvider
                                .latestProductList.product[i].name,
                            phoneSize: productProvider
                                .latestProductList.product[i].phoneSize,
                            phoneWeight: productProvider
                                .latestProductList.product[i].phoneWeight,
                            rom: productProvider
                                .latestProductList.product[i].rom,
                            typephone: productProvider
                                .latestProductList.product[i].typePhone,
                            unitPrice: productProvider
                                .latestProductList.product[i].unitPrice,

                            context: context,
                            color: Color(int.parse(
                              productProvider
                                  .latestProductList.product[i].colorimg
                                  .split('(')[1]
                                  .split(')')[0],
                            )),
                            // widget.palettecolor ?? Color(0xFF5F4747),
                          )),
                    )
                ],
              )
            : Container(child: Text('sdhg'));
      }),
    );
  }
}

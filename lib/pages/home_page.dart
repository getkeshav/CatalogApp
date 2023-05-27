import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';

import '../core/store.dart';
import '../models/cart.dart';
import '../widgets/home_widgets/catalog_header.dart';
import '../widgets/home_widgets/catalog_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    //state when class is initialised, state before build method is called
    // so if we have calculated data before build method we can give give it to build method
    super.initState();
    loadData(); // method to load data of json file
  }

  loadData() async {
    await Future.delayed(Duration(
        seconds:
            2)); // it'll take some time to fetch the data from json file so we will wait till 2 sec and put loading icon at that place
    final catalogJson = await rootBundle.loadString(
        "assets/files/catalog.json"); // it'll take some time(as loadstring is a future widget) to load data from json file so await is there
    final decodedData = jsonDecode(
        catalogJson); //loaded data is in the form of string but we need objects, so decoding is done , jsonDecode gives dynamic value(like map)
    //Decoding= String to Object ,, Decoding = Object to String , here object is map
    //decodedData will give us object (whole json file is an object)
    var productData =
        decodedData["products"]; // taking products from decoded data/object
    CatalogModel.items =
        List.from(productData).map<Item>((item) => Item.fromMap(item)).toList();
    setState(() {
      //calling build again and again so that every entry comes not only one
    });
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
        backgroundColor: context.canvasColor,
        floatingActionButton: VxBuilder( // VxBuilder rebuilds the inside functionalities instead of whole widget tree
          mutations: {AddMutation, RemoveMutation},
          builder: (ctx, _, status) => FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, MyRoutes.CartRoute),
            backgroundColor: context.theme.splashColor,
            child: Icon(
              CupertinoIcons.cart,
              color: Colors.white,
            ),
          ).badge(
              color: Vx.gray200,
              size: 22,
              count: _cart.items.length,
              textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: SafeArea(
          child: Container(
            padding: Vx.m32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Catalogheader(),
                if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                  CatalogList().py16().expand()
                else
                  CircularProgressIndicator().centered().expand(),
              ],
            ),
          ),
        ));
  }
}

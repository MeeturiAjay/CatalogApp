import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:masterflutter/core/store.dart';
import 'package:masterflutter/models/cart_model.dart';
import 'package:masterflutter/models/catalog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masterflutter/core/store.dart';
import 'package:masterflutter/models/cart_model.dart';
import 'package:masterflutter/models/catalog.dart';
import 'package:masterflutter/pages/home_details.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../models/catalog.dart';
import 'cart.dart';
//import '../screens/cart_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../models/catalog.dart';

class HomePage extends StatefulWidget {
  final CartModel cart;

  const HomePage({Key? key, required this.cart}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    final catalogJson =
    await rootBundle.loadString("assets/files/catalog.json");
    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatalogModels.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      floatingActionButton: VxBuilder(
        mutations: {AddMutation, RemoveMutation},
        builder: (context, store, status) => FloatingActionButton(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          onPressed: () => Navigator.pushNamed(context, "/cart"),
          child: Icon(CupertinoIcons.cart),
        ).badge(
          color: Colors.lightGreen,
          count: _cart.items.length,
          textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CatalogHeader(),
              const SizedBox(height: 30),
              _isLoading
                  ? Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        isDarkMode ? Colors.white : Colors.indigo),
                  ),
                ),
              )
                  : CatalogList(),
            ],
          ),
        ),
      ),
    );
  }
}



class CatalogHeader extends StatelessWidget {
  const CatalogHeader({Key? key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Catalog Application",
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Trending products",
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.indigo,
          ),
        )
      ],
    );
  }
}

class CatalogList extends StatelessWidget {
  //final CartModel cart;

  const CatalogList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final catalog = CatalogModels.items[index];
          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeDetailsPage(catalog: catalog),
              ),
            ),
            child: CatalogItem(catalog: catalog),
          );
        },
        itemCount: CatalogModels.items.length,
      ),
    );
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({Key? key, required this.catalog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: isDarkMode ? Colors.white : null,
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.all(8),
            child: Hero(
              tag: Key(catalog.id.toString()), // Unique tag for each item
              child: Image.network(catalog.image),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  catalog.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.black : Colors.black,
                  ),
                ),
                Text(
                  catalog.desc,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.black : Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "\$${catalog.price}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: isDarkMode ? Colors.indigo : Colors.indigo,
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: AddToCart(catalog: catalog),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddToCart extends StatelessWidget {
  final Item catalog;

  AddToCart({
    Key? key,
    required this.catalog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxConsumer(
      mutations: {AddMutation, RemoveMutation},
      builder: (context, _, __) {
        final CartModel _cart = (VxState.store as MyStore).cart;
        bool isInCart = _cart.items.contains(catalog) ?? false;
        return ElevatedButton(
          onPressed: () {
            if (!isInCart) {
              AddMutation(catalog);
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              isInCart ? Colors.indigo : Colors.indigo,
            ),
            shape: MaterialStateProperty.all(
              StadiumBorder(),
            ),
          ),
          child: isInCart
              ? Icon(
                  Icons.done,
                  color: Colors.white,
                )
              : Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.white),
                ),
        );
      },
    );
  }
}

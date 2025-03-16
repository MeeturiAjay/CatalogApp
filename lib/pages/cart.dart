import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masterflutter/models/cart_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/store.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.indigo : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: isDarkMode ? Colors.white : Colors.indigo,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Cart",
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: CartList(),
            ),
          ),
          CartTotal(),
        ],
      ),
    );
  }
}

class CartTotal extends StatelessWidget {
  const CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartModel _cart = (VxState.store as MyStore).cart;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          VxConsumer(
            notifications: {},
            mutations: {RemoveMutation},
            builder: (context, store, status) {
              return Text(
                "\$${_cart.totalPrice}",
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.indigo,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              );
            },
          ),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                isDarkMode ? Colors.white : Colors.indigo,
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Buying not supported yet..",
                    style: TextStyle(
                      color: isDarkMode ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              );
            },
            child: Text(
              "Buy",
              style: TextStyle(
                color: isDarkMode ? Colors.indigo : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CartList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return _cart.items.isEmpty
        ? Center(
      child: Text(
        "Cart is empty!..",
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.indigo,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
      ),
    )
        : ListView.builder(
      itemCount: _cart.items?.length ?? 0,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(
          Icons.done_outline_rounded,
          color: Colors.green,
        ),
        title: Text(
          _cart.items[index].name,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.remove_circle_outline,
            color: Colors.red,
          ),
          onPressed: () => RemoveMutation(_cart.items[index]),
        ),
      ),
    );
  }
}








import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/catalog.dart';

class HomeDetailsPage extends StatelessWidget {
  final Item catalog;

  const HomeDetailsPage({Key? key, required this.catalog});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${catalog.price}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: isDarkMode ? Colors.white : Colors.indigo, // Adjust text color based on theme mode
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  isDarkMode? Colors.white : Colors.indigo,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                  color: isDarkMode? Colors.indigo : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Details",
          style: TextStyle(
            color: isDarkMode? Colors.white : Colors.black, // Text color set to white
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent, // Set app bar background color to transparent
        elevation: 0, // Remove app bar elevation
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: isDarkMode? Colors.white : Colors.indigo, // Icon color set to white
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView( // Wrap with SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Align content to center horizontally
            children: [
              Hero(
                tag: Key(catalog.id.toString()),
                child: Padding(
                  padding: const EdgeInsets.all(32.0), // Adjust padding as needed
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      child: Image.network(
                        catalog.image,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16), // Add spacing between image and title
              Text(
                catalog.name.toString(),
                textAlign: TextAlign.center, // Align text to center
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black, // Adjust text color based on theme mode
                ),
              ),
              SizedBox(height: 8), // Add spacing between title and subtitle
              Text(
                catalog.desc.toString(),
                textAlign: TextAlign.center, // Align text to center
                style: TextStyle(
                  fontSize: 14,
                  color: isDarkMode ? Colors.white : Colors.black, // Adjust text color based on theme mode
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

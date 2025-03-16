import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.indigo,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.indigo,
              ),
              currentAccountPicture: CircleAvatar(
                child: Image.asset("assets/images/profile_image.jpg",
                    fit: BoxFit.fill),
              ),
              margin: EdgeInsets.zero,
              accountName: const Text("Meeturi Ajay Kumar"),
              accountEmail: const Text("meeturiajaykumar.23@gmail.com"),
            ),
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.home,
              color: Colors.white,
            ),
            title: Text(
              "Home",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white),
            ),
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.profile_circled,
              color: Colors.white,
            ),
            title: Text(
              "Profile",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white),
            ),
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.settings,
              color: Colors.white,
            ),
            title: Text(
              "Settings",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white),
            ),
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.location,
              color: Colors.white,
            ),
            title: Text(
              "Location",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

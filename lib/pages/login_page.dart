import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool changebutton = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: isDarkMode ? Colors.indigo : Colors.white, // Adjust background color based on theme mode
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 80.0,
              ),
              SafeArea(
                minimum: EdgeInsets.all(32),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Adjust border radius as needed
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Adjust border radius as needed
                    child: Image.asset(
                      "assets/images/login_image.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Text(
                "Log in/Sign in",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.indigo), // Adjust text color based on theme mode
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                        hintText: "Enter Username",
                        hintStyle: TextStyle(fontSize: 15.0, color: isDarkMode ? Colors.white : Colors.black), // Adjust hint text color based on theme mode
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username cannot be empty.";
                        }
                        return null;
                      },
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black), // Adjust text color based on theme mode
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                        hintText: "Enter Password",
                        hintStyle: TextStyle(fontSize: 15.0, color: isDarkMode ? Colors.white : Colors.black), // Adjust hint text color based on theme mode
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the password.";
                        } else if (value.length < 8) {
                          return "Password length must be at least 8.";
                        }
                        return null;
                      },
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black), // Adjust text color based on theme mode
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              InkWell(
                onTap: () async {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    setState(() {
                      changebutton = true;
                    });
                    await Future.delayed(
                      const Duration(seconds: 1),
                    );
                    await Navigator.pushNamed(context, "/home");
                    setState(
                          () {
                        changebutton = false;
                      },
                    );
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: 40,
                  width: changebutton ? 40 : 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.white : Colors.indigo, // Adjust button color based on theme mode
                    borderRadius: BorderRadius.circular(changebutton ? 40 : 10),
                  ),
                  child: changebutton
                      ? Icon(Icons.done, color: isDarkMode ? Colors.indigo : Colors.white)
                      : Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: isDarkMode ? Colors.indigo : Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  final String expectedUsername = 'vineet123';
  final String expectedPassword = 'Vineet@886';
  String username = "";
  String password = "";
  final RegExp regExpusername = RegExp(r'^[a-zA-Z0-9_]{6,20}$');
  final RegExp regExppassword =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])(?!.*[ ]).{8,}$');
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Enter Your Details'),
          ),
        ),
        body: Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.always,
            child: Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 7,
                  right: MediaQuery.of(context).size.width / 7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter your username',
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Enter your username....',
                    ),
                    maxLength: 10,
                    onChanged: (value) {
                      username = value.isEmpty ? '0' : value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      } else if (!regExpusername.hasMatch(value)) {
                        return 'Matches alphanumeric characters and underscores Minimum length of 6 characters, maximum of 20.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enter your password',
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Enter your Password....',
                    ),
                    maxLength: 10,
                    onChanged: (value) {
                      password = value.isEmpty ? '0' : value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      } else if (!regExppassword.hasMatch(value)) {
                        return 'Requires at least one lowercase letter, one uppercase letter, one number, and one special character Minimum length of 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      print(username + password);
                      if (_formkey.currentState!.validate()) {
                        if (username.trim() == expectedUsername &&
                            password.trim() == expectedPassword) {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString(
                              'username',username+password);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Loginpage();
                            
                          }
            ));
                          
                        }
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            )));
  }
}

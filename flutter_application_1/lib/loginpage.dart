import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/assets/imageaddress.dart';
import 'package:flutter_application_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Theme/appcolors.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});
  @override
  State<StatefulWidget> createState() {
    return LoginpageState();
  }
}

class LoginpageState extends State<Loginpage> {
  final RegExp regExp = RegExp(r'^\d+$');

  String value10 = "";
  String value20 = "";
  String value50 = "";
  String value100 = "";
  String value200 = "";
  String value500 = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Make Your Record',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: appcolors.primarycolor),
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(imageaddress.bg))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UpperTitle(context),
                  TextFieldFiveHundred(context),
                  TextFieldTwoHundred(context),
                  TextFieldHundred(context),
                  TextfieldFifty(context),
                  TextfieldTwenty(context),
                  TextFieldTen(context),
                  const SizedBox(
                    height: 20,
                    width: 30,
                  ),
                  LoginButton(context),
                ],
              ),
            ),
          ),
        ));
  }

  Widget UpperTitle(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: Text(
            'Enter Number of Notes :',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  Widget TextFieldTen(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Flexible(
          flex: 1,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                '10',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
        ),
        Flexible(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      value10 = value.isEmpty ? '0' : value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    } else if (value != null && !regExp.hasMatch(value)) {
                      return "Invalid Input Format";
                    }
                  },
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Number of Ten Notes here',
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter here 10 Notes',
                  ),
                ))),
      ],
    );
  }

  Widget TextfieldTwenty(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          flex: 1,
          child: const Padding(
              padding: EdgeInsets.all(10),
              child: const Text('20',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        ),
        Flexible(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      value20 = value.isEmpty ? '0' : value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    } else if (value != null && !regExp.hasMatch(value)) {
                      return "Invalid Input Format"; // Only validate if not empty
                    }
                    return null;
                  },
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: 'Enter your Number of Twenty Notes here',
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter here 20 Notes',
                  ),
                ))),
      ],
    );
  }

  Widget Textfieldfifty(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          flex: 1,
          child: const Padding(
              padding: EdgeInsets.all(10),
              child: const Text('50',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        ),
        Flexible(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      value50 = value.isEmpty ? '0' : value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    } else if (value != null && !regExp.hasMatch(value)) {
                      return "Invalid Input Format"; // Only validate if not empty
                    }
                  },
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: 'Enter your Number of Fifty Notes here',
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter here 50 Notes',
                  ),
                ))),
      ],
    );
  }

  Widget TextfieldFifty(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          flex: 1,
          child: const Padding(
              padding: EdgeInsets.all(10),
              child: const Text('50',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        ),
        Flexible(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      value50 = value.isEmpty ? '0' : value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    } else if (value != null && !regExp.hasMatch(value)) {
                      return "Invalid Input Format"; // Only validate if not empty
                    }
                  },
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: 'Enter your Number of Fifty Notes here',
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter here 50 Notes',
                  ),
                ))),
      ],
    );
  }

  Widget TextFieldHundred(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          flex: 1,
          child: const Padding(
              padding: EdgeInsets.all(10),
              child: const Text('100',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        ),
        Flexible(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      value100 = value.isEmpty ? '0' : value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    } else if (value != null && !regExp.hasMatch(value)) {
                      return "Invalid Input Format"; // Only validate if not empty
                    }
                  },
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: 'Enter your Number of Hundred Notes here',
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter here 100 Notes',
                  ),
                ))),
      ],
    );
  }

  Widget TextFieldTwoHundred(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          flex: 1,
          child: const Padding(
              padding: EdgeInsets.all(10),
              child: const Text('200',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        ),
        Flexible(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      value200 = value.isEmpty ? '0' : value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    } else if (value != null && !regExp.hasMatch(value)) {
                      return "Invalid Input Format"; // Only validate if not empty
                    }
                  },
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: 'Enter your Number of Two Hundred Notes here',
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter here 200 Notes',
                  ),
                ))),
      ],
    );
  }

  Widget TextFieldFiveHundred(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          flex: 1,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text('500',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        ),
        Flexible(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      value500 = value.isEmpty ? '0' : value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    } else if (value != null && !regExp.hasMatch(value)) {
                      return "Invalid Input Format"; // Only validate if not empty
                    }
                    return null;
                  },
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Number of Five Hundred Notes here',
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter here 500 Notes',
                  ),
                ))),
      ],
    );
  }

  Widget LoginButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
          width: 30,
        ),
        ElevatedButton(
          onPressed: () async {
            int ten = int.parse(value10);
            int twenty = int.parse(value20);
            int fifty = int.parse(value50);
            int hundred = int.parse(value100);
            int twohundred = int.parse(value200);
            int fivehundred = int.parse(value500);

            if (_formKey.currentState!.validate()) {
              int totalMoney = ten * 10 +
                  twenty * 20 +
                  fifty * 50 +
                  hundred * 100 +
                  fivehundred * 500 +
                  twohundred * 200;
              int total =
                  ten + twenty + fifty + hundred + fivehundred + twohundred;

              final prefs = await SharedPreferences.getInstance();
              String? username = prefs.getString('username');
              print('$username at the loginpage');
              await prefs.setString('${username}login','***********RECIEPT***********');

              await prefs.setString('ten', ten.toString());
              await prefs.setString('twenty', twenty.toString());
              await prefs.setString('fifty', fifty.toString());
              await prefs.setString('hundred', hundred.toString());
              await prefs.setString('twohundred', twohundred.toString());
              await prefs.setString('fivehundred', fivehundred.toString());
              await prefs.setString('total', total.toString());
              await prefs.setString('totalmoney', totalMoney.toString());
               await prefs.setString('recieptno','1');

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MainApp(
                  ten: ten,
                  twenty: twenty,
                  fifty: fifty,
                  hundred: hundred,
                  twohundred: twohundred,
                  fivehundred: fivehundred,
                  totalmoney: totalMoney,
                  total: total,recieptno: 1,
                );
              }));
            }
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Login'),
        ),
      ],
    );
  }
  
}

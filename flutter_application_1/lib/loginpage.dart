import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebasedatabase/bloc/event.dart';
import 'package:flutter_application_1/firebasedatabase/bloc/state.dart';
import 'package:flutter_application_1/firebasedatabase/bloc/storedatabloc.dart';
import 'package:flutter_application_1/firebasedatabase/firebaserepo.dart';
import 'package:flutter_application_1/homepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Theme/appcolors.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});
  @override
  State<StatefulWidget> createState() {
    return LoginpageState();
  }
}

class LoginpageState extends State<Loginpage> {
  final RegExp regExp = RegExp(r'^\d+$');
  TextEditingController ec10 = TextEditingController();
  TextEditingController ec20 = TextEditingController();

  TextEditingController ec50 = TextEditingController();

  TextEditingController ec100 = TextEditingController();
  TextEditingController ec200 = TextEditingController();
  TextEditingController ec500 = TextEditingController();

  String value10 = "";
  String value20 = "";
  String value50 = "";
  String value100 = "";
  String value200 = "";
  String value500 = "";
  String remark = "";
  String recieptno = "";
  String loss = "";
  String profit = "";

  String text10 = "";
  String text20 = "";
  String text50 = "";
  String text100 = "";
  String text200 = "";
  String text500 = "";

  final _formKey = GlobalKey<FormState>();

  Future<void> firsttimeornot() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');

    // if (username == null) {
    //   // Handle missing username gracefully.
    //   ScaffoldMessenger.maybeOf(context)?.showSnackBar(
    //     const SnackBar(content: Text("No username found!")),
    //   );
    //   return;
    // }

    final isFirstTime = await FirebaseRepository().isFirstTimeLogin(username!);
    if (isFirstTime) {
      // First-time login, add data to Firebase
      // Map<String, dynamic> initialData = {
      //   'ten': 0,
      //   'twenty': 0,
      //   'fifty': 0,
      //   'hundred': 0,
      //   'twohundred': 0,
      //   'fivehundred': 0,
      //   'total': 0,
      //   'totalMoney': 0,
      // };

      BlocProvider.of<FirebaseBloc>(context).add(FetchUsersEvent());

      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(
            content: Text("Already a user ! Data fetched Successfully")),
      );
    } else {}
  }

  @override
  void initState() {
    super.initState();
    firsttimeornot();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Scaling factor for responsiveness
    double scaleFactor = screenWidth > 800 ? 0.5 : 1.0;

    return BlocListener<FirebaseBloc, FirebaseState>(
        listener: (context, state) {
          if (state is FirebaseLoading) {
          } else if (state is UsersFetchedState) {
            final data = state.users;

            if (data.isNotEmpty) {
              final user = data
                  .last; 
              setState(() {
                
                value10 = user['ten']?.toString() ?? '0';
                value20 = user['twenty']?.toString() ?? '0';
                value50 = user['fifty']?.toString() ?? '0';
                value100 = user['hundred']?.toString() ?? '0';
                value200 = user['twohundred']?.toString() ?? '0';
                value500 = user['fivehundred']?.toString() ?? '0';
                 remark = user['remark']?.toString() ?? '0';
                  recieptno = user['recieptno']?.toString() ?? '0';
                   loss = user['loss']?.toString() ?? '0';
                    profit = user['profit']?.toString() ?? '0';

                // Populate TextEditingController values
                ec10.text = value10;
                ec20.text = value20;
                ec50.text = value50;
                ec100.text = value100;
                ec200.text = value200;
                ec500.text = value500;
              });
            }

            // ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            //   const SnackBar(content: Text("Data fetched successfully!")),
            // );
          } else if (state is FirebaseSuccess) {
            // ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            //   const SnackBar(content: Text("Data stored successfully!")),
            // );
          } else if (state is FirebaseError) {
            ScaffoldMessenger.maybeOf(context)?.showSnackBar(
              SnackBar(content: Text("Error: ${state.message}")),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: const Center(
              child: Text(
                'Make Your Record',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          body: Center(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UpperTitle(context, screenWidth, scaleFactor),
                      TextFieldFiveHundred(context, screenWidth, scaleFactor,
                          screenHeight, ec500),
                      TextFieldTwoHundred(context, screenWidth, scaleFactor,
                          screenHeight, ec200),
                      TextFieldHundred(context, screenWidth, scaleFactor,
                          screenHeight, ec100),
                      TextFieldFifty(context, screenWidth, scaleFactor,
                          screenHeight, ec50),
                      TextFieldTwenty(context, screenWidth, scaleFactor,
                          screenHeight, ec20),
                      TextFieldTen(context, screenWidth, scaleFactor,
                          screenHeight, ec10),
                      SizedBox(
                        height: screenHeight * 0.02, // Reduced vertical spacing
                      ),
                      LoginButton(context, screenWidth, scaleFactor),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget UpperTitle(
      BuildContext context, double screenWidth, double scaleFactor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: Text(
            'Enter Number of Notes ',
            style: TextStyle(
              fontSize: screenWidth * 0.05 * scaleFactor * 0.50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextField(
      String label,
      String hint,
      ValueChanged<String> onChanged,
      double screenWidth,
      double scaleFactor,
      double screenheight,
      TextEditingController ec) {
    return Padding(
        padding: EdgeInsets.only(bottom: screenheight * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  label,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: TextFormField(
                  controller: ec,
                  onChanged: onChanged,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    } else if (!regExp.hasMatch(value)) {
                      return "Invalid Input Format";
                    }
                    return null;
                  },
                  maxLength: 10,
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: appcolors.textformfieldcolor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: appcolors.textformfieldcolor),
                    ),
                    errorBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: appcolors.textformfielderrorcolor),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: screenWidth * 0.015,
                        horizontal: screenWidth * 0.02),
                    hintText: hint,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget TextFieldTen(BuildContext context, double screenWidth,
      double scaleFactor, double screenheight, TextEditingController ec10) {
    return buildTextField(
        '10Rs',
        'Enter here count of 10 Rs Notes',
        (value) => setState(() => value10 = value.isEmpty ? '0' : value),
        screenWidth,
        scaleFactor,
        screenheight,
        ec10);
  }

  Widget TextFieldTwenty(BuildContext context, double screenWidth,
      double scaleFactor, double screenheight, TextEditingController ec20) {
    return buildTextField(
        '20Rs',
        'Enter here count of 20 Rs Notes',
        (value) => setState(() => value20 = value.isEmpty ? '0' : value),
        screenWidth,
        scaleFactor,
        screenheight,
        ec20);
  }

  Widget TextFieldFifty(BuildContext context, double screenWidth,
      double scaleFactor, double screenheight, TextEditingController ec50) {
    return buildTextField(
        '50Rs',
        'Enter here count of 50 Rs Notes',
        (value) => setState(() => value50 = value.isEmpty ? '0' : value),
        screenWidth,
        scaleFactor,
        screenheight,
        ec50);
  }

  Widget TextFieldHundred(BuildContext context, double screenWidth,
      double scaleFactor, double screenheight, TextEditingController ec100) {
    return buildTextField(
        '100Rs',
        'Enter here count of 100 Rs Notes',
        (value) => setState(() => value100 = value.isEmpty ? '0' : value),
        screenWidth,
        scaleFactor,
        screenheight,
        ec100);
  }

  Widget TextFieldTwoHundred(BuildContext context, double screenWidth,
      double scaleFactor, double screenheight, TextEditingController ec200) {
    return buildTextField(
        '200Rs',
        'Enter here count of 200 Rs Notes',
        (value) => setState(() => value200 = value.isEmpty ? '0' : value),
        screenWidth,
        scaleFactor,
        screenheight,
        ec200);
  }

  Widget TextFieldFiveHundred(BuildContext context, double screenWidth,
      double scaleFactor, double screenheight, TextEditingController ec500) {
    return buildTextField(
        '500Rs',
        'Enter here count of 500 Rs Notes',
        (value) => setState(() => value500 = value.isEmpty ? '0' : value),
        screenWidth,
        scaleFactor,
        screenheight,
        ec500);
  }

  Widget LoginButton(
      BuildContext context, double screenWidth, double scaleFactor) {
    return ElevatedButton(
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
              
          int total = ten + twenty + fifty + hundred + fivehundred + twohundred;

          final prefs = await SharedPreferences.getInstance();
          String? username = prefs.getString('username');
          print('$username at the loginpage');
          await prefs.setString(
              '${username}login',remark);

          await prefs.setString('ten', ten.toString());
          await prefs.setString('twenty', twenty.toString());
          await prefs.setString('fifty', fifty.toString());
          await prefs.setString('hundred', hundred.toString());
          await prefs.setString('twohundred', twohundred.toString());
          await prefs.setString('fivehundred', fivehundred.toString());
          await prefs.setString('total', total.toString());
          await prefs.setString('totalmoney', totalMoney.toString());
          await prefs.setString('recieptno', recieptno);


//firsttime open or not state saved in sharedpreference.

          // await prefs.setString('firsttimeopenornot', 'false');

          Map<String, dynamic> data = {
            'ten': ten,
            'twenty': twenty,
            'fifty': fifty,
            'hundred': hundred,
            'twohundred': twohundred,
            'fivehundred': fivehundred,
            'total': total,
            'totalmoney': totalMoney,
            'recieptno': recieptno,
            'remark': remark,
            'loss': loss,
            'profit': profit,
            'createdAt': FieldValue.serverTimestamp()
          };

          BlocProvider.of<FirebaseBloc>(context).add(AddDataEvent(data));

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                      ten: ten,
                      twenty: twenty,
                      fifty: fifty,
                      hundred: hundred,
                      twohundred: twohundred,
                      fivehundred: fivehundred,
                      totalmoney: totalMoney,
                      total: total,
                      recieptno: int.parse(recieptno))));
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: 5,
        textStyle: TextStyle(
          fontSize: screenWidth * 0.05 * scaleFactor,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: const Text('Login'),
    );
  }
}

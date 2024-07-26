import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Theme/appcolors.dart';
import 'package:flutter_application_1/Theme/theme.dart';
import 'package:flutter_application_1/assets/imageaddress.dart';
import 'package:flutter_application_1/dev.dart';
import 'package:flutter_application_1/loginpage.dart';
import 'package:flutter_application_1/splashscreen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: splashscreen(),
  ));
}

class MainApp extends StatefulWidget {
  MainApp(
      {required this.ten,
      required this.twenty,
      required this.fifty,
      required this.hundred,
      required this.twohundred,
      required this.fivehundred,
      required this.totalmoney,
      required this.total,
      super.key});
  int ten;
  int twenty;
  int fifty;
  int hundred;
  int twohundred;
  int fivehundred;
  int totalmoney;
  int total;

  @override
  State<MainApp> createState() {
    return MainAppState();
  }
}

class MainAppState extends State<MainApp> {
  final RegExp regExp = RegExp(r'^\d+$');

  final _textController10 = TextEditingController();
  final _textController20 = TextEditingController();
  final _textController50 = TextEditingController();
  final _textController100 = TextEditingController();
  final _textController200 = TextEditingController();
  final _textController500 = TextEditingController();

  String value10 = "";
  String value20 = "";
  String value50 = "";
  String value100 = "";
  String value200 = "";
  String value500 = "";

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String bodyimage = imageaddress().light;
    ThemeData theme = themeslist.lighttheme;

    // void changeimageandthemedark() {
    //   setState(() {
    //     theme = themeslist.darktheme;
    //     bodyimage = imageaddress().dark;
    //   });
    // }

    // void changeimageandthemelight() {
    //   setState(() {
    //     theme = themeslist.lighttheme;
    //     bodyimage = imageaddress().light;
    //   });
    // }

    print('bodyimage');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  'Make Your Record',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: appcolors.primarycolor),
                ),
              ),
              actions: [
                PopupMenuButton<VoidCallback>(onSelected: (callback) {
                  callback();
                }, itemBuilder: (context) {
                  return [
                    PopupMenuItem(child: Text('Developer contact'),value: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>dev()));
                    },),
                    PopupMenuItem(
                        child: Text('log Out'),
                        value: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Loginpage()),
                          );
                        })
                  ];
                })
              ],
            ),
            body: Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formkey,
                child: SingleChildScrollView(
                    child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(bodyimage), fit: BoxFit.cover),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Flexible(
                              flex: 2,
                              child: Text(
                                'Total Money(Rs):',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                widget.totalmoney.toString(),
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                              height: 5,
                            ),
                            const Flexible(
                              child: Text(
                                'Total :',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                widget.total.toString(),
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Flexible(
                              flex: 1,
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text('10',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                            ),
                            Flexible(
                                flex: 1,
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: TextFormField(
                                      controller: _textController10,
                                      onChanged: (value) {
                                        setState(() {
                                          value10 = value.isEmpty ? '0' : value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          value10='0';
                                          return null;
                                        } else if (value != null &&
                                            !regExp.hasMatch(value)) {
                                          return "Invalid Input Format"; // Only validate if not empty
                                        }
                                      },
                                      maxLength: 10,
                                      decoration: InputDecoration(
                                        labelText: 'Enter your text here',
                                        contentPadding: EdgeInsets.all(10),
                                        hintText: 'Enter here',
                                      ),
                                    ))),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(widget.ten.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),

//////////////
                            ///
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Flexible(
                              flex: 1,
                              child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: const Text('20',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                            ),
                            Flexible(
                                flex: 1,
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      controller: _textController20,
                                      onChanged: (value) {
                                        setState(() {
                                          value20 = value.isEmpty ? '0' : value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          value20='0';
                                          return null;
                                        } else if (value != null &&
                                            !regExp.hasMatch(value)) {
                                          return "Invalid Input Format";
                                        }
                                      },
                                      maxLength: 10,
                                      decoration: const InputDecoration(
                                        labelText: 'Enter your text here',
                                        contentPadding: EdgeInsets.all(10),
                                        hintText: 'Enter here',
                                      ),
                                    ))),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(widget.twenty.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Flexible(
                              flex: 1,
                              child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: const Text('50',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                            ),
                            Flexible(
                                flex: 1,
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      controller: _textController50,
                                      onChanged: (value) {
                                        setState(() {
                                          value50 = value.isEmpty ? '0' : value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          value50='0';
                                          return null;
                                        } else if (value != null &&
                                            !regExp.hasMatch(value)) {
                                          return "Invalid Input Format";
                                        }
                                      },
                                      maxLength: 10,
                                      decoration: const InputDecoration(
                                        labelText: 'Enter your text here',
                                        contentPadding: EdgeInsets.all(10),
                                        hintText: 'Enter here',
                                      ),
                                    ))),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(widget.fifty.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Flexible(
                              flex: 1,
                              child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: const Text('100',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                            ),
                            Flexible(
                                flex: 1,
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      controller: _textController100,
                                      onChanged: (value) {
                                        setState(() {
                                          value100 =
                                              value.isEmpty ? '0' : value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          value100='0';
                                          return null;
                                        } else if (value != null &&
                                            !regExp.hasMatch(value)) {
                                          return "Invalid Input Format"; // Only validate if not empty
                                        }
                                      },
                                      maxLength: 10,
                                      decoration: const InputDecoration(
                                        labelText: 'Enter your text here',
                                        contentPadding: EdgeInsets.all(10),
                                        hintText: 'Enter here',
                                      ),
                                    ))),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(widget.hundred.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Flexible(
                              flex: 1,
                              child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: const Text('200',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                            ),
                            Flexible(
                                flex: 1,
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      controller: _textController200,
                                      onChanged: (value) {
                                        setState(() {
                                          value200 =
                                              value.isEmpty ? '0' : value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          value200='0';
                                          return null;
                                        } else if (value != null &&
                                            !regExp.hasMatch(value)) {
                                          return "Invalid Input Format"; // Only validate if not empty
                                        }
                                      },
                                      maxLength: 10,
                                      decoration: const InputDecoration(
                                        labelText: 'Enter your text here',
                                        contentPadding: EdgeInsets.all(10),
                                        hintText: 'Enter here',
                                      ),
                                    ))),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(widget.twohundred.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Flexible(
                              flex: 1,
                              child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: const Text('500',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                            ),
                            Flexible(
                                flex: 1,
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      controller: _textController500,
                                      onChanged: (value) {
                                        setState(() {
                                          value500 =
                                              value.isEmpty ? '0' : value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          value500='0';
                                          return null;
                                        } else if (value != null &&
                                            !regExp.hasMatch(value)) {
                                          return "Invalid Input Format"; // Only validate if not empty
                                        }
                                      },
                                      maxLength: 10,
                                      decoration: const InputDecoration(
                                        labelText: 'Enter your text here',
                                        contentPadding: EdgeInsets.all(10),
                                        hintText: 'Enter here',
                                      ),
                                    ))),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(widget.fivehundred.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                          width: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                int ten = int.parse(value10);
                                int twenty = int.parse(value20);
                                int fifty = int.parse(value50);
                                int hundred = int.parse(value100);
                                int twohundred = int.parse(value200);
                                int fivehundred = int.parse(value500);

                                if (_formkey.currentState!.validate()) {
                                  setState(() {
                                    widget.ten += ten;
                                    widget.twenty += twenty;
                                    widget.fifty += fifty;
                                    widget.hundred += hundred;
                                    widget.twohundred += twohundred;
                                    widget.fivehundred += fivehundred;

                                    widget.totalmoney = widget.ten * 10 +
                                        widget.twenty * 20 +
                                        widget.fifty * 50 +
                                        widget.hundred * 100 +
                                        widget.fivehundred * 500 +
                                        widget.twohundred * 200;

                                    widget.total = widget.ten +
                                        widget.twenty +
                                        widget.fifty +
                                        widget.hundred +
                                        widget.fivehundred +
                                        widget.twohundred;
                                  });

                                  int totalDepositnotes = ten +
                                      twenty +
                                      fifty +
                                      hundred +
                                      twohundred +
                                      fivehundred;
                                  DateTime now = DateTime.now();
                                  DateFormat formatter =
                                  DateFormat('dd-MM-yyyy HH:mm:ss');
                                  String formattedDateTime =
                                  formatter.format(now);

                                  String t = '\nDeposit:' +
                                      '\nTotal Money:' +
                                      widget.totalmoney.toString() +
                                      '\nTotal Notes in account:' +
                                      widget.total.toString() +
                                      '\nTotal notes(w):' +
                                      totalDepositnotes.toString() +
                                      '\nTen notes(w):' +
                                      ten.toString() +
                                      ', Twenty notes(w):' +
                                      twenty.toString() +
                                      ', fifty notes (w):' +
                                      fifty.toString() +
                                      ', Hundred notes(w):' +
                                      hundred.toString() +
                                      ', Two Hundred(w):' +
                                      twohundred.toString() +
                                      ', Five Hundred:' +
                                      fivehundred.toString() +
                                      '\nDate and Time:' +
                                      formattedDateTime +
                                      '------------------------------\n';
                                  final prefs =
                                  await SharedPreferences.getInstance();
                                  final Depositrecord = prefs.getString('W');
                                  String tt = Depositrecord.toString() + t;
                                  prefs.setString('W', tt);

                                  //sharedpreference for every individual field
                                  await prefs.setString(
                                      'ten', widget.ten.toString());
                                  await prefs.setString(
                                      'twenty', widget.twenty.toString());
                                  await prefs.setString(
                                      'fifty', widget.fifty.toString());
                                  await prefs.setString(
                                      'hundred', widget.hundred.toString());
                                  await prefs.setString('twohundred',
                                      widget.twohundred.toString());
                                  await prefs.setString('fivehundred',
                                      widget.fivehundred.toString());
                                  await prefs.setString(
                                      'total', widget.total.toString());
                                  await prefs.setString('totalmoney',
                                      widget.totalmoney.toString());

                                  _textController10.clear();
                                  _textController20.clear();
                                  _textController50.clear();
                                  _textController100.clear();
                                  _textController200.clear();
                                  _textController500.clear();

                                  value10='0';
                                  value20='0';
                                  value50='0';
                                  value100='0';
                                  value200='0';
                                  value500='0';
                                }
                              },
                              child: Text('Deposit'),
                              style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              width: 30,
                            ),
                            ElevatedButton(
                              onPressed: ()  async {
                                int ten = int.parse(value10);
                                int twenty = int.parse(value20);
                                int fifty = int.parse(value50);
                                int hundred = int.parse(value100);
                                int twohundred = int.parse(value200);
                                int fivehundred = int.parse(value500);

                                if (_formkey.currentState!.validate()) {



                                    if (ten <= widget.ten &&
                                        twenty <= widget.twenty &&
                                        fifty <= widget.fifty &&
                                        hundred <= widget.hundred &&
                                        twohundred <= widget.twohundred &&
                                        fivehundred <= widget.fivehundred) {

                                      setState(() {


                                      widget.ten -= ten;
                                      widget.twenty -= twenty;
                                      widget.fifty -= fifty;
                                      widget.hundred -= hundred;
                                      widget.twohundred -= twohundred;
                                      widget.fivehundred -= fivehundred;

                                      widget.totalmoney = widget.ten * 10 +
                                          widget.twenty * 20 +
                                          widget.fifty * 50 +
                                          widget.hundred * 100 +
                                          widget.fivehundred * 500 +
                                          widget.twohundred * 200;

                                      widget.total = widget.ten +
                                          widget.twenty +
                                          widget.fifty +
                                          widget.hundred +
                                          widget.fivehundred +
                                          widget.twohundred;

                                      ///
                                      _textController10.clear();
                                      _textController20.clear();
                                      _textController50.clear();
                                      _textController100.clear();
                                      _textController200.clear();
                                      _textController500.clear();
                                      value10='0';
                                      value20='0';
                                      value50='0';
                                      value100='0';
                                      value200='0';
                                      value500='0';

                                      });


                                      ///////////////shared preferences////////////////////

                                      int totalwithdrawlnotes = ten +
                                          twenty +
                                          fifty +
                                          hundred +
                                          twohundred +
                                          fivehundred;
                                      DateTime now = DateTime.now();
                                      DateFormat formatter =
                                      DateFormat('dd-MM-yyyy HH:mm:ss');
                                      String formattedDateTime =
                                      formatter.format(now);

                                      String t = '\nWithdrawl:' +
                                          '\nTotal Money:' +
                                          widget.totalmoney.toString() +
                                          '\nTotal Notes in account:' +
                                          widget.total.toString() +
                                          '\nTotal notes(w):' +
                                          totalwithdrawlnotes.toString() +
                                          '\nTen notes(w):' +
                                          ten.toString() +
                                          ', Twenty notes(w):' +
                                          twenty.toString() +
                                          ', fifty notes (w):' +
                                          fifty.toString() +
                                          ', Hundred notes(w):' +
                                          hundred.toString() +
                                          ', Two Hundred(w):' +
                                          twohundred.toString() +
                                          ', Five Hundred:' +
                                          fivehundred.toString() +
                                          '\nDate and Time:' +
                                          formattedDateTime +
                                          '------------------------------\n';
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      final withdrawlrecord = prefs.getString('W');
                                      String tt = withdrawlrecord.toString() + t;
                                      prefs.setString('W', tt);

                                      await prefs.setString(
                                          'ten', widget.ten.toString());
                                      await prefs.setString(
                                          'twenty', widget.twenty.toString());
                                      await prefs.setString(
                                          'fifty', widget.fifty.toString());
                                      await prefs.setString(
                                          'hundred', widget.hundred.toString());
                                      await prefs.setString('twohundred',
                                          widget.twohundred.toString());
                                      await prefs.setString('fivehundred',
                                          widget.fivehundred.toString());
                                      await prefs.setString(
                                          'total', widget.total.toString());
                                      await prefs.setString('totalmoney',
                                          widget.totalmoney.toString());


                                    } else {
                                      //to do
                                    }




                                }
                              },
                              child:const Text('Withdrawl'),
                              style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              width: 30,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  final ss = prefs.getString('W');

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => StatefulBuilder(
                                      builder: (context, setState) {
                                        return AlertDialog(
                                          title: Text('Reciept'),
                                          content: SingleChildScrollView(
                                            child: Text(ss.toString()),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: Text('OK'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                final prefs = await SharedPreferences.getInstance();
                                                await prefs.setString('W', '----------------');
                                                setState(() {}); // Rebuild the widget tree
                                              },
                                              child: Text('Clear'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                saveData();
                                              },
                                              child: Text('Print'),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              child: Text('Reciept'),
                              style: ElevatedButton.styleFrom(
                                  textStyle: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                     SizedBox(height:20), Center(child:Text('Developed by Kaushal Kishore sharma \nContact me on: shadowcode007@gmail.com',style: TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.bold),)) ]),
                )))));
  }

  void saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('W');
    final bytes = utf8.encode(data!);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement()
      ..href = url
      ..style.display = 'none'
      ..download = 'banking_data.txt';
    html.document.body!.children.add(anchor);
    anchor.click();
    html.Url.revokeObjectUrl(url);
  }

}

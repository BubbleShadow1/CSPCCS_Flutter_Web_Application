import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Authentication/auth_repository.dart';
import 'package:flutter_application_1/Authentication/authbloc/auth_bloc.dart';
import 'package:flutter_application_1/Bloc/PendingBloc/bloc.dart';
import 'package:flutter_application_1/Theme/appcolors.dart';
import 'package:flutter_application_1/Theme/theme.dart';
import 'package:flutter_application_1/assets/imageaddress.dart';
import 'package:flutter_application_1/dev.dart';
import 'package:flutter_application_1/firebasedatabase/bloc/event.dart';
import 'package:flutter_application_1/firebasedatabase/bloc/state.dart';
import 'package:flutter_application_1/firebasedatabase/bloc/storedatabloc.dart';
import 'package:flutter_application_1/firebasedatabase/firebaserepo.dart';
import 'package:flutter_application_1/firebaseoptions.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_application_1/splashscreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(AuthRepository()),
      ),
      BlocProvider<FirebaseBloc>(
          create: (context) => FirebaseBloc(FirebaseRepository())),
      BlocProvider<EntryBloc>(create: (context) => EntryBloc())
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
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
      required this.recieptno,
      super.key});
  int ten;
  int twenty;
  int fifty;
  int hundred;
  int twohundred;
  int fivehundred;
  int totalmoney;
  int total;
  int recieptno;

  @override
  State<MainApp> createState() {
    return MainAppState();
  }
}

class MainAppState extends State<MainApp> {
  final RegExp regExp = RegExp(r'^\d+$');
  final RegExp regforremark = RegExp(r'.');

  final _textController10 = TextEditingController();
  final _textController20 = TextEditingController();
  final _textController50 = TextEditingController();
  final _textController100 = TextEditingController();
  final _textController200 = TextEditingController();
  final _textController500 = TextEditingController();
  final _textControllerRemark = TextEditingController();

  String value10 = "";
  String value20 = "";
  String value50 = "";
  String value100 = "";
  String value200 = "";
  String value500 = "";
  String valueRemark = "";

  String fetchedrecipt = "";

  Future<String?> user() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    return username;
  }

  Future<String?> fetchdatafromprefs(String str) async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString(str);
    return username;
  }

  @override
  void initState() {
    super.initState();
    calldatafrombackend();
  }

  void calldatafrombackend() {
    BlocProvider.of<FirebaseBloc>(context).add(FetchUsersEvent());
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String bodyimage = imageaddress.light;
    ThemeData theme = themeslist.lighttheme;

    return BlocListener<FirebaseBloc, FirebaseState>(
      listener: (context, state) {
        if (state is FirebaseLoading) {
        } else if (state is UsersFetchedState) {
          final data = state.users;

          if (data.isNotEmpty) {
            final user = data
                .last; // Assuming `data` is a list and you need the first user's data
            setState(() {
              fetchedrecipt = user['remark'];
              widget.ten = user['ten'];
              widget.twenty = user['twenty'];
              widget.fifty = user['fifty'];
              widget.hundred = user['hundred'];
              widget.twohundred = user['twohundred'];
              widget.fivehundred = user['fivehundred'];
              widget.totalmoney = user['totalmoney'];
              widget.total = user['total'];
              widget.recieptno = user['recieptno'];
            });
          }

          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            const SnackBar(content: Text("Data fetched successfully!")),
          );
        } else if (state is FirebaseSuccess) {
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            const SnackBar(content: Text("Data stored successfully!")),
          );
        } else if (state is FirebaseError) {
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            SnackBar(content: Text("Error: ${state.message}")),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Make Your Record',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: appcolors.primarycolor),
            ),
          ),
          actions: [
            PopupMenuButton<VoidCallback>(onSelected: (callback) {
              callback();
            }, itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Text('Developer contact'),
                  value: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const dev()));
                  },
                ),
                PopupMenuItem(
                    child: const Text('log Out'),
                    value: () {
                      //To do add firebase logout .
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Signup()),
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
                    UpperHeading(context),
                    TextFieldFiveHundred(context),
                    TextFieldTwoHundred(context),
                    TextFieldHundred(context),
                    TextFieldFifty(context),
                    TextFieldTwenty(context),
                    TextFieldTen(context),
                    remarktextfield(),
                    const SizedBox(
                      height: 10,
                      width: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DepositBtn(context),
                        const SizedBox(
                          height: 30,
                          width: 30,
                        ),
                        WithdrawlBtn(context),
                        const SizedBox(
                          height: 30,
                          width: 30,
                        ),
                        ReciptBtn(context),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // const Center(child:Text('Developed by Kaushal Kishore sharma \nContact me on: shadowcode007@gmail.com',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),))
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void saveData() async {
    // final prefs = await SharedPreferences.getInstance();
    // final data = prefs.getString('${user()}login');
    final bytes = utf8.encode(fetchedrecipt);
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

  Widget UpperHeading(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          flex: 2,
          child: Text(
            'Total Money(Rs):',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          child: Text(
            widget.totalmoney.toString(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 50,
          height: 5,
        ),
        const Flexible(
          child: Text(
            'Total :',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          child: Text(
            widget.total.toString(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
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
              child: Text('10',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        ),
        Flexible(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _textController10,
                  onChanged: (value) {
                    setState(() {
                      value10 = value.isEmpty ? '0' : value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      value10 = '0';
                      return null;
                    } else if (!regExp.hasMatch(value)) {
                      return "Invalid Input Format"; // Only validate if not empty
                    }
                    return null;
                  },
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Ten Notes',
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter here....',
                  ),
                ))),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Text(widget.ten.toString(),
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget TextFieldTwenty(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          flex: 1,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text('20',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
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
                      value20 = '0';
                      return null;
                    } else if (!regExp.hasMatch(value)) {
                      return "Invalid Input Format";
                    }
                    return null;
                  },
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Twenty Notes',
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter here....',
                  ),
                ))),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Text(widget.twenty.toString(),
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget TextFieldFifty(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          flex: 1,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text('50',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
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
                      value50 = '0';
                      return null;
                    } else if (!regExp.hasMatch(value)) {
                      return "Invalid Input Format";
                    }
                    return null;
                  },
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Fifty Notes',
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter here....',
                  ),
                ))),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Text(widget.fifty.toString(),
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget TextFieldHundred(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          flex: 1,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text('100',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        ),
        Flexible(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _textController100,
                  onChanged: (value) {
                    setState(() {
                      value100 = value.isEmpty ? '0' : value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      value100 = '0';
                      return null;
                    } else if (!regExp.hasMatch(value)) {
                      return "Invalid Input Format"; // Only validate if not empty
                    }
                    return null;
                  },
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Hundred Notes',
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter here....',
                  ),
                ))),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Text(widget.hundred.toString(),
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget TextFieldTwoHundred(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          flex: 1,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text('200',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        ),
        Flexible(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _textController200,
                  onChanged: (value) {
                    setState(() {
                      value200 = value.isEmpty ? '0' : value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      value200 = '0';
                      return null;
                    } else if (!regExp.hasMatch(value)) {
                      return "Invalid Input Format"; // Only validate if not empty
                    }
                    return null;
                  },
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Two Hundred',
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter here....',
                  ),
                ))),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Text(widget.twohundred.toString(),
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold))),
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
                  controller: _textController500,
                  onChanged: (value) {
                    setState(() {
                      value500 = value.isEmpty ? '0' : value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      value500 = '0';
                      return null;
                    } else if (!regExp.hasMatch(value)) {
                      return "Invalid Input Format"; // Only validate if not empty
                    }
                    return null;
                  },
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Five Hundred',
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter here....',
                  ),
                ))),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Text(widget.fivehundred.toString(),
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget DepositBtn(BuildContext context) {
    return ElevatedButton(
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

          int totalDepositnotes =
              ten + twenty + fifty + hundred + twohundred + fivehundred;

          int totalDepositAmount = ten * 10 +
              twenty * 20 +
              fifty * 50 +
              hundred * 100 +
              twohundred * 200 +
              fivehundred * 500;

          DateTime now = DateTime.now();
          DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
          String formattedDateTime = formatter.format(now);

          String t =
              '\nDeposit:${widget.recieptno}\nTotal notes(w):500->$fivehundred|200->$twohundred|100->$hundred|50->$fifty|20->$twenty|10->$ten\nTotal Deposit Amount:$totalDepositAmount\nTotal Available Amount:${widget.totalmoney}\nTotal Available Notes:${widget.total}\nRemark:$valueRemark\nDate and Time:$formattedDateTime\n------------------------------\n';

          final prefs = await SharedPreferences.getInstance();
          final username = await user();
          print(username);
          final Depositrecord = prefs.getString('${username}login');
          String tt = Depositrecord.toString() + t;
          prefs.setString('${username}login', tt);

          widget.recieptno++;

          await prefs.setString('ten', widget.ten.toString());
          await prefs.setString('twenty', widget.twenty.toString());
          await prefs.setString('fifty', widget.fifty.toString());
          await prefs.setString('hundred', widget.hundred.toString());
          await prefs.setString('twohundred', widget.twohundred.toString());
          await prefs.setString('fivehundred', widget.fivehundred.toString());
          await prefs.setString('total', widget.total.toString());
          await prefs.setString('totalmoney', widget.totalmoney.toString());
          await prefs.setString('recieptno', widget.recieptno.toString());

          String? rec = prefs.getString('recieptno');

          _textController10.clear();
          _textController20.clear();
          _textController50.clear();
          _textController100.clear();
          _textController200.clear();
          _textController500.clear();
          _textControllerRemark.clear();

          value10 = '0';
          value20 = '0';
          value50 = '0';
          value100 = '0';
          value200 = '0';
          value500 = '0';
          valueRemark = '.';

          Map<String, dynamic> data = {
            'ten': ten,
            'twenty': twenty,
            'fifty': fifty,
            'hundred': hundred,
            'twohundred': twohundred,
            'fivehundred': fivehundred,
            'total': totalDepositnotes,
            'totalmoney': totalDepositAmount,
            'recieptno': rec,
            'remark': tt,
            'createdAt': FieldValue.serverTimestamp()
          };

          BlocProvider.of<FirebaseBloc>(context).add(AddDataEvent(data));
        }
      },
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: const Text('Deposit'),
    );
  }

  Widget WithdrawlBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
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
            });

            int totalwithdrawlnotes =
                ten + twenty + fifty + hundred + twohundred + fivehundred;

            int totalWithdrawlAmount = ten * 10 +
                twenty * 20 +
                fifty * 50 +
                hundred * 100 +
                twohundred * 200 +
                fivehundred * 500;

            DateTime now = DateTime.now();
            DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
            String formattedDateTime = formatter.format(now);

            String t =
                '\nWithdrawl:${widget.recieptno}\nTotal notes(w):500->$fivehundred|200->$twohundred|100->$hundred|50->$fifty|20->$twenty|10->$ten\nTotal Withdrawl Amount:$totalWithdrawlAmount\nTotal Available Amount:${widget.totalmoney}\nTotal Available Notes:${widget.total}\nRemark:$valueRemark\nDate and Time:$formattedDateTime\n------------------------------\n';

            final prefs = await SharedPreferences.getInstance();
            final username = await user();
            print(username);
            final withdrawlrecord = prefs.getString('${username}login');

//total updated reciept
            String tt = withdrawlrecord.toString() + t;

            prefs.setString('${username}login', tt);

            widget.recieptno++;

            await prefs.setString('ten', widget.ten.toString());
            await prefs.setString('twenty', widget.twenty.toString());
            await prefs.setString('fifty', widget.fifty.toString());
            await prefs.setString('hundred', widget.hundred.toString());
            await prefs.setString('twohundred', widget.twohundred.toString());
            await prefs.setString('fivehundred', widget.fivehundred.toString());
            await prefs.setString('total', widget.total.toString());
            await prefs.setString('totalmoney', widget.totalmoney.toString());
            await prefs.setString('recieptno', widget.recieptno.toString());

            String? rec = prefs.getString('recieptno');

            _textController10.clear();
            _textController20.clear();
            _textController50.clear();
            _textController100.clear();
            _textController200.clear();
            _textController500.clear();
            _textControllerRemark.clear();

            value10 = '0';
            value20 = '0';
            value50 = '0';
            value100 = '0';
            value200 = '0';
            value500 = '0';
            valueRemark = '.';
            Map<String, dynamic> data = {
              'ten': ten,
              'twenty': twenty,
              'fifty': fifty,
              'hundred': hundred,
              'twohundred': twohundred,
              'fivehundred': fivehundred,
              'total': totalwithdrawlnotes,
              'totalmoney': totalWithdrawlAmount,
              'recieptno': rec,
              'remark': tt,
              'createdAt': FieldValue.serverTimestamp()
            };

            BlocProvider.of<FirebaseBloc>(context).add(AddDataEvent(data));
          } else {
            //to do
          }
        }
      },
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: const Text('Withdrawl'),
    );
  }

  Widget ReciptBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        BlocProvider.of<FirebaseBloc>(context).add(FetchUsersEvent());

        final prefs = await SharedPreferences.getInstance();
        final username = await user();
        print(username);
        final ss = prefs.getString('${username}login');
        print('$ss at reciept button');
        showDialog(
          context: context,
          builder: (BuildContext context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Reciept'),
                content: SingleChildScrollView(
                  child: Text(
                      //
                      fetchedrecipt),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                  // TextButton(
                  //   onPressed: () async {
                  //     final prefs = await SharedPreferences.getInstance();
                  //     await prefs.setString(
                  //         '${username}login', '***********RECIEPT***********');

                  //     widget.recieptno = 1;
                  //     await prefs.setString(
                  //         'recieptno', widget.recieptno.toString());
                  //   },
                  //   child: const Text('Clear'),
                  // ),
                  TextButton(
                    onPressed: () {
                      saveData();
                    },
                    child: const Text('Print'),
                  ),
                ],
              );
            },
          ),
        );
      },
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      )),
      child: const Text('Reciept'),
    );
  }

  Widget remarktextfield() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          flex: 1,
          child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text('Remark',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        ),
        Flexible(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  controller: _textControllerRemark,
                  onChanged: (value) {
                    setState(() {
                      valueRemark = value.isEmpty ? '.' : value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      valueRemark = '.';
                      return null;
                    } else if (!regforremark.hasMatch(value)) {
                      return "Invalid Input Format";
                    }
                    return null;
                  },
                  maxLength: 500,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Remark',
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter here....',
                  ),
                ))),
      ],
    );
  }
}

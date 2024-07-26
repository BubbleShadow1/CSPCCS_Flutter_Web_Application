import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Theme/appcolors.dart';

class Loginpage extends StatefulWidget{
  Loginpage({super.key});
  @override
  State<StatefulWidget> createState() {
    return LoginpageState();
  }
}
class LoginpageState extends State<Loginpage> {
  final RegExp regExp = RegExp(r'^\d+$');

String value10="";
String value20="";
String value50="";
String value100="";
String value200="";
String value500="";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){





    return Scaffold(appBar:AppBar(title: Center(
      child: Text(
        'Make Your Record',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: appcolors.primarycolor),
      ),
    ),),
        body: Form(
        key: _formKey,
            autovalidateMode: AutovalidateMode.always,
        child:SingleChildScrollView(child:   Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              'Enter Number of Notes :',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Flexible(
            flex: 1,
            child: Padding(padding: EdgeInsets.all(10), child: Text('10',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
          ),
          Flexible(
              flex: 1,
              child: Padding(
                  padding:const EdgeInsets.all(10),
                  child: TextFormField(
                    onChanged: (value) {setState(() {
                      value10 = value.isEmpty ? '0' : value;
                    });
                    },
                    validator: (value) {
                      if(value==null || value.isEmpty)
                        {
                          return null;
                        }
                     else if (value != null && !regExp.hasMatch(value)) {
                        return "Invalid Input Format"; // Only validate if not empty
                      }
                    },
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: 'Enter your Number of Ten Notes here',
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Enter here 10 Notes',
                    ),
                  ))),

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
                padding: EdgeInsets.all(10), child: const Text('20',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
          ),
          Flexible(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(   onChanged: (value) {setState(() {
                    value20 = value.isEmpty ? '0' : value;
                  });
                  },
                    validator: (value) {
                      if(value==null || value.isEmpty)
                      {
                        return null;
                      }
                      else if (value != null && !regExp.hasMatch(value)) {
                        return "Invalid Input Format"; // Only validate if not empty
                      }
                    },
                    maxLength: 10,

                    decoration: InputDecoration(
                      labelText: 'Enter your Number of Twenty Notes here',
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Enter here 20 Notes',
                    ),
                  ))),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Flexible(
            flex: 1,
            child: const Padding(
                padding: EdgeInsets.all(10), child: const Text('50',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
          ),
          Flexible(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(  onChanged: (value) {setState(() {
                    value50 = value.isEmpty ? '0' : value;
                  });
                  },
                    validator: (value) {
                      if(value==null || value.isEmpty)
                      {
                        return null;
                      }
                      else if (value != null && !regExp.hasMatch(value)) {
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
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Flexible(
            flex: 1,
            child: const Padding(
                padding: EdgeInsets.all(10), child: const Text('100',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
          ),
          Flexible(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(  onChanged: (value) {setState(() {
                    value100 = value.isEmpty ? '0' : value;
                  });
                  },
                    validator: (value) {
                      if(value==null || value.isEmpty)
                      {
                        return null;
                      }
                      else if (value != null && !regExp.hasMatch(value)) {
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
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Flexible(
            flex: 1,
            child: const Padding(
                padding: EdgeInsets.all(10), child: const Text('200',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
          ),
          Flexible(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(  onChanged: (value) {setState(() {
                    value200 = value.isEmpty ? '0' : value;
                  });
                  },
                    validator: (value) {
                      if(value==null || value.isEmpty)
                      {
                        return null;
                      }
                      else if (value != null && !regExp.hasMatch(value)) {
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
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Flexible(
            flex: 1,
            child: const Padding(
                padding: EdgeInsets.all(10), child: const Text('500',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
          ),
          Flexible(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(  onChanged: (value) {setState(() {
                    value500 = value.isEmpty ? '0' : value;
                  });
                  },
                    validator: (value) {
                      if(value==null || value.isEmpty)
                      {
                        return null;
                      }
                      else if (value != null && !regExp.hasMatch(value)) {
                        return "Invalid Input Format"; // Only validate if not empty
                      }
                    },
                    maxLength: 10,

                    decoration: InputDecoration(
                      labelText: 'Enter your Number of Five Hundred Notes here',
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Enter here 500 Notes',
                    ),
                  ))),
        ],
      ),
      SizedBox(
        height: 20,
        width: 30,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: 30,
          ),
          ElevatedButton(
            onPressed: () async {


              int ten =int.parse(value10);
              int twenty=int.parse(value20);
              int fifty = int.parse(value50);
              int hundred = int.parse(value100);
              int twohundred = int.parse(value200);
              int fivehundred = int.parse(value500);

              if(_formKey.currentState!.validate())
                {

                    int totalMoney = ten * 10 +
                        twenty * 20 +
                        fifty * 50 +
                        hundred * 100 +
                        fivehundred * 500 +
                        twohundred * 200;
                    int total = ten + twenty + fifty + hundred + fivehundred +
                        twohundred;



                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('W', '***********RECIEPT***********');


                    await prefs.setString('ten', ten.toString());
                    await prefs.setString('twenty', twenty.toString());
                    await prefs.setString('fifty', fifty.toString());
                    await prefs.setString('hundred', hundred.toString());
                    await prefs.setString('twohundred',twohundred.toString());
                    await prefs.setString('fivehundred', fivehundred.toString());
                    await prefs.setString('total', total.toString());
                    await prefs.setString('totalmoney', totalMoney.toString());



                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MainApp(
                      ten: ten,
                      twenty: twenty,
                      fifty: fifty,
                      hundred: hundred,
                      twohundred: twohundred,
                      fivehundred: fivehundred,
                      totalmoney: totalMoney,
                      total: total,);
                  }));

                  }


                }

      //
      //
      // //ten
      //         setState(() async {
      //           int? ten1=validator(textController10!);
      // if (textController10 == null){
      //   ten = 0;
      //   tenval = true;
      // }
      // else if (ten1 == -1){
      //   errtext1 = 'Given Value is InValid !';
      //   print('Error showed in TextField');
      // }
      // else if (ten1 == null) {
      //   tenval = true;
      //   ten=int.parse(textController10!);
      // }
      // //twenty
      //           int? twenty1=validator(textController20!);
      // if (textController20 == null) {
      //   twenty = 0;
      //   twentyval = true;
      // }
      // else if (validator(textController20!) == -1) {
      //   errtext2 = 'Given Value is InValid !';
      //
      //   print('Error showed in TextField');
      // }
      // else if (validator(textController20!) == null) {
      //   twentyval = true;
      //   twenty=int.parse(textController20!);
      // }
      // //fifty
      //
      // if (textController50 == null) {
      //   fifty = 0;
      //   fiftyval = true;
      // }
      // else if (validator(textController50!) == -1) {
      //   errtext3 = 'Given Value is InValid !';
      //
      //   print('Error showed in TextField');
      // }
      // else if (validator(textController50!) == null) {
      //   fiftyval = true;
      //   fifty=int.parse(textController50!);
      // }
      // //hundred
      //
      // if (textController100 == null) {
      //   hundred = 0;
      //   hundredval = true;
      // }
      // else if (validator(textController100!) == -1) {
      //   errtext4 = 'Given Value is InValid !';
      //
      //   print('Error showed in TextField');
      // }
      // else if (validator(textController100!) == null) {
      //   hundredval = true;
      //   hundred=int.parse(textController100!);
      // }
      // //twohundred
      //
      // if (textController200 == null) {
      //   twohundred = 0;
      //   twohundredval = true;
      // }
      // else if (validator(textController200!) == -1) {
      //   errtext5 = 'Given Value is InValid !';
      //   print('Error showed in TextField');
      // }
      // else if (validator(textController200!) == null) {
      //   twohundredval = true;
      //   twohundred=int.parse(textController200!);
      // }
      // //fivehundred
      //
      // if (textController500 == null) {
      //   fivehundred = 0;
      //   fivehundredval = true;
      // }
      // else if (validator(textController500!) == -1) {
      //   errtext6 = 'Given Value is InValid !';
      //   print('Error showed in TextField');
      // }
      // else if (validator(textController500!) == null) {
      //   fivehundredval = true;
      //   fivehundred=int.parse(textController500!);
      // }
      //         });



  ,
            child: Text('Login'),
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
               ),
        ],
      ),
    ]))
    ));
  }


}

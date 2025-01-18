// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/assets/imageaddress.dart';
// import 'package:flutter_application_1/signup.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'loginpage.dart';
// import 'main.dart';

// class splashscreen extends StatefulWidget {
//   const splashscreen({super.key});

//   @override
//   State<splashscreen> createState() {
//     return splashscreenState();
//   }
// }

// class splashscreenState extends State<splashscreen> {
//   // late VideoPlayerController _controller;
//   // late Future<void> _initializeVideoPlayerFuture;

//   @override
//   void initState() {
//     super.initState();
//     _navigateToNextScreen();

//   }

//   _navigateToNextScreen() async {
//     await Future.delayed(const Duration(seconds: 4));
//     final isLoggedIn = await _checkLoginStatus();
//     if (isLoggedIn) {
//       final prefs = await SharedPreferences.getInstance();
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => MainApp(
//             ten: _getIntFromPrefs(prefs, 'ten'),
//             twenty: _getIntFromPrefs(prefs, 'twenty'),
//             fifty: _getIntFromPrefs(prefs, 'fifty'),
//             hundred: _getIntFromPrefs(prefs, 'hundred'),
//             twohundred: _getIntFromPrefs(prefs, 'twohundred'),
//             fivehundred: _getIntFromPrefs(prefs, 'fivehundred'),
//             totalmoney: _getIntFromPrefs(prefs, 'totalmoney'),
//             total: _getIntFromPrefs(prefs, 'total'),recieptno: _getIntFromPrefs(prefs, 'recieptno') ,
//           ),
//         ),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => Signup()),
//       );
//     }
//   }

//   // Helper function to get integer from SharedPreferences with error handling
//   int _getIntFromPrefs(SharedPreferences prefs, String key) {
//     final value = prefs.getString(key);
//     if (value != null) {
//       try {
//         return int.parse(value);
//       } catch (e) {

//         print('Error parsing integer from SharedPreferences: $e');
        
//         return 0;
//       }
//     }
//     return 0;
//   }

//   Future<bool> _checkLoginStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? username = prefs.getString('username');

//     print("$username at splash screen");
//     final loginStatus =
//         prefs.getString('${username}login');
//     return loginStatus == '***********RECIEPT***********' ||
//         loginStatus != null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: _navigateToNextScreen(),
//         builder: (context, snapshot) {
//           return Center(child: Image.asset(imageaddress.logo));
//         },
//       ),
//     );
//   }

//   // @override
//   // void dispose() {
//   //   _controller.dispose();
//   //   super.dispose();
//   // }
// }


import 'package:flutter/material.dart';
import 'package:flutter_application_1/assets/imageaddress.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    // Show splash image for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // If user is logged in, navigate to MainApp
      final prefs = await SharedPreferences.getInstance();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainApp(
            ten: prefs.getInt('ten') ?? 0,
            twenty: prefs.getInt('twenty') ?? 0,
            fifty: prefs.getInt('fifty') ?? 0,
            hundred: prefs.getInt('hundred') ?? 0,
            twohundred: prefs.getInt('twohundred') ?? 0,
            fivehundred: prefs.getInt('fivehundred') ?? 0,
            totalmoney: prefs.getInt('totalmoney') ?? 0,
            total: prefs.getInt('total') ?? 0,
            recieptno: prefs.getInt('recieptno') ?? 0,
          ),
        ),
      );
    } else {
      // If user is not logged in, navigate to Signup page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  const Signup()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return    Scaffold(
      body: Center(
        child: Image.asset(imageaddress.logo), 
      ),
    );
  }
}

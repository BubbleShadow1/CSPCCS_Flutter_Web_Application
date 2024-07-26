import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_web/video_player_web.dart';
import 'loginpage.dart';
import 'main.dart';

class splashscreen extends StatefulWidget {
  @override
  State<splashscreen> createState() {
    return splashscreenState();
  }
}

class splashscreenState extends State<splashscreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();

    _controller = VideoPlayerController.network('assets/video/vv.mp4');
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      _controller.setLooping(true);
      _controller.play();
    });

    _initializeVideoPlayerFuture.then((_) {
      print('Video Player Initialized!');
    });
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3)); // Adjust delay as needed
    final isLoggedIn = await _checkLoginStatus();
    if (isLoggedIn) {
      final prefs = await SharedPreferences.getInstance();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainApp(
            ten: _getIntFromPrefs(prefs, 'ten'),
            twenty: _getIntFromPrefs(prefs, 'twenty'),
            fifty: _getIntFromPrefs(prefs, 'fifty'),
            hundred: _getIntFromPrefs(prefs, 'hundred'),
            twohundred: _getIntFromPrefs(prefs, 'twohundred'),
            fivehundred: _getIntFromPrefs(prefs, 'fivehundred'),
            totalmoney: _getIntFromPrefs(prefs, 'totalmoney'),
            total: _getIntFromPrefs(prefs, 'total'),
          ),
        ),
      );
    }else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Loginpage()),
      );
    }
  }

  // Helper function to get integer from SharedPreferences with error handling
  int _getIntFromPrefs(SharedPreferences prefs, String key) {
    final value = prefs.getString(key);
    if (value != null) {
      try {
        return int.parse(value);
      } catch (e) {
        print('Error parsing integer from SharedPreferences: $e');
        return 0;
      }
    }
    return 0;
  }

  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final loginStatus = prefs.getString('W');
    return loginStatus == '***********RECIEPT***********' || loginStatus != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(decoration: BoxDecoration(color: Colors.white),child:  Center( // Center the video
              child:SizedBox( height:300,width:300,child: FittedBox(
                  fit: BoxFit.cover, // Cover the entire area
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
            ),);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
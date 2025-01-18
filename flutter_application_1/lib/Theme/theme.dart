import 'package:flutter/material.dart';
import 'package:flutter_application_1/Theme/appcolors.dart';

class themeslist{
 static ThemeData lighttheme=ThemeData(brightness: Brightness.light,primarySwatch: Colors.blue,primaryColor: appcolors.primarycolor,textTheme: const TextTheme(bodySmall: TextStyle(color: appcolors.primarycolor,fontWeight: FontWeight.bold)));
 static ThemeData darktheme=ThemeData(brightness: Brightness.dark,primarySwatch: Colors.blue,primaryColor: appcolors.primarycolor,textTheme: const TextTheme(bodySmall: TextStyle(color: appcolors.primarycolor,fontWeight: FontWeight.bold)));

}

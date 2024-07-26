import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class dev extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar:AppBar(title: Text('About Developer'),),body: Center(child:Text('Developed by : Kaushal Kishore sharma \nContact me on: shadowcode007@gmail.com',style: TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.bold),)));
  }
}

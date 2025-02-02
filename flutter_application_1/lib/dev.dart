import 'package:flutter/material.dart';

class dev extends StatelessWidget{
  const dev({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar:AppBar(title: const Text('About Developer'),),body: const Center(child:Text('Developed by : Kaushal Kishore sharma \nContact me on: shadowcode007@gmail.com',style: TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.bold),)));
   
    
  }
}

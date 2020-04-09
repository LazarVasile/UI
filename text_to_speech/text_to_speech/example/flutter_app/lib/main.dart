
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(TheApp());

class TheApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:Scaffold(
        body: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget{

  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context){
    _speak() async{
      await flutterTts.setLanguage("ro-RO");
      await flutterTts.speak("ce");
    }
    return Container(
      alignment:Alignment.center,
      child:RaisedButton(
        child:Text("Apasa"),
        onPressed: ()=> _speak(),
      ),
    );
  }
}
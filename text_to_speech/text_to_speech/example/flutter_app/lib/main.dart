
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
      await flutterTts.speak("Moara cu noroc este o nuvelă scrisă de Ioan Slavici, tratând consecințele pe care dorința de îmbogățire le are asupra destinului uman. Majoritatea criticilor o consideră creația cea mai importantă a autorului, alături de Pădureanca și romanul Mara. ");
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
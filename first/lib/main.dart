

import 'package:flutter/material.dart';
 import 'package:speech_recognition/speech_recognition.dart';
 import 'package:flutter_tts/flutter_tts.dart';
 import 'package:http/http.dart';
 import 'dart:convert';
 import 'dart:async';


 void main() async{
   runApp(MyApp());
 }


class Book {
  final String id;
  final String title;
  final String author;

  Book(this.id, this.title, this.author);
}

 class MyApp extends StatelessWidget {


   Future<List<Book>> _getAllBooks() async {
    var data = await get('http://192.168.0.100:5000/api/v1/resources/books/all');

    var jsonData = jsonDecode(data.body);
//    print(jsonData[100]['id'].runtimeType);
//    print(jsonData.length);
//    print(jsonData);
    List<Book> books = [];
    for(var i = 0; i < jsonData.length; i++) {
//      print(b);
      Book book = Book(jsonData[i]['id'], jsonData[i]['title'], jsonData[i]['author']);
      books.add(book);
    }
//    print("dsadjsajdsa");
//    print(books.length);
    return books;
   }


   @override
   Widget build(BuildContext context) {
     final title = 'Books list';

         return MaterialApp(
           title: title,
           home: Scaffold(
             appBar: AppBar(
               title: Text(title),
             ),
             body: Container(
            child:FutureBuilder(
            future : _getAllBooks(),

             builder : (BuildContext context, AsyncSnapshot snapshot){
               if(snapshot.data == null) {
                 return Container(child: Center(child: Text("Loading")));
               }
               else
              return ListView.builder(
               itemCount: snapshot.data.length,
               // Let the ListView know how many items it needs to build.
               // Provide a builder function. This is where the magic happens.
               // Convert each item into a widget based on the type of item it is.
               itemBuilder: (BuildContext context, int index) {
                 

                 return ListTile(

                   title: Text(snapshot.data[index].title, style: const TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 20.0,
                   )),
                   subtitle: Text(snapshot.data[index].author, style: const TextStyle(
                     fontWeight: FontWeight.w400,
                     fontSize: 15.0,

                   )),
                   trailing: Icon(Icons.keyboard_arrow_right),

                   onTap:  (){
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => VoiceHome(id1 : snapshot.data[index].id, title1 : snapshot.data[index].title, author1 : snapshot.data[index].author)),
                     );
                   } ,
                 );
               },
         );
             },
         )
         )
       ),
     );
   }
 }


 class VoiceHome extends StatefulWidget {
   VoiceHome({Key key, this.id1, this.title1, this.author1});
   final String id1;
   final String title1;
   final String author1;
   @override
   _VoiceHomeState createState() => _VoiceHomeState(id : id1, title : title1, author : author1);
 }

 class _VoiceHomeState extends State<VoiceHome> {
   _VoiceHomeState({Key key, this.id, this.title, this.author});
   final String id;
   final String title;
   final String author;
   SpeechRecognition _speechRecognition;
   final FlutterTts flutterTts = FlutterTts();
   bool _isAvailable = false;
   bool _isListening = false;

   String resultText = "";
   String finalResult = "";

   Future<String> _getResponse(id, question) async {
     String url = 'http://192.168.0.100:5000/api/v1/resources/books';
    Map<String, String> headers = {"Content-type": "application/json"};

   // make POST request
   var data = {"id" : id, "question" : question};
   var sendData = jsonEncode(data);
   Response response = await post(url, headers: headers, body: sendData);

   String fragment = response.body;
  //  print(fragment);x`
   return fragment;

   }
   @override
   void initState() {
     super.initState();
     initSpeechRecognizer();
   }
   void initSpeechRecognizer() {
     _speechRecognition = SpeechRecognition();

     _speechRecognition.setAvailabilityHandler(
           (bool result) => setState(() => _isAvailable = result),
     );

     _speechRecognition.setRecognitionStartedHandler(
           () => setState(() => _isListening = true),
     );

     _speechRecognition.setRecognitionResultHandler(
           (String speech) => setState(() => resultText = speech),
     );

     _speechRecognition.setRecognitionCompleteHandler(
           () => setState(() => _isListening = false),
     );

     _speechRecognition.activate().then(
           (result) => setState(() => _isAvailable = result),
     );
   }


   @override
   Widget build(BuildContext context) {

     _speak(String message) async{
       await flutterTts.setLanguage("ro-RO");
       await flutterTts.speak(message);
     }
     return Scaffold(
         appBar: AppBar(
         title: Text(this.title + " written by " + this.author),
       ),
       body: Container(
         color: Colors.cyanAccent[100],
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 FloatingActionButton(
                   heroTag: null,
                   child: Icon(Icons.cancel),
                   mini: true,
                   backgroundColor: Colors.deepOrange,
                   onPressed: () {
                     if (_isListening)
                       _speechRecognition.cancel().then(
                             (result) => setState(() {
                           _isListening = result;
                           resultText = "";
                         }),
                       );
                   },
                 ),
                 FloatingActionButton(
                   heroTag: null,
                   child: Icon(Icons.mic),
                   onPressed: () {
                     if (_isAvailable && !_isListening)
                       _speechRecognition
                           .listen(locale: "ro_RO")
                           .then((result) => print('$result'));
                   },
                   backgroundColor: Colors.pink,
                 ),
                 FloatingActionButton(
                   heroTag: null,
                   child: Icon(Icons.stop),
                   mini: true,
                   backgroundColor: Colors.deepPurple,
                   onPressed: () {
                     if (_isListening)
                       _speechRecognition.stop().then(
                             (result) => setState(() => _isListening = result),
                       );
                   },
                 ),
               ],
             ),
             Container(
               width: MediaQuery.of(context).size.width * 0.8,
               decoration: BoxDecoration(
                 color: Colors.lightGreenAccent,
                 borderRadius: BorderRadius.circular(6.0),
               ),
               padding: EdgeInsets.symmetric(
                 vertical: 8.0,
                 horizontal: 12.0,
               ),
               child: Text(
                 resultText,
                 style: TextStyle(fontSize: 24.0),
               ),
             ),
              Container(
                alignment:Alignment.center,
                child: FutureBuilder(
                future : _getResponse(id, resultText),
                builder : (BuildContext context, AsyncSnapshot snapshot) {
                return RaisedButton(
                child:Text("Apasa pentru raspuns!",
                style: TextStyle(fontSize: 24.0, color: Colors.white)),
                onPressed: ()=> {
//                   apelare post pe result
//                  finalResult = _makePostRequest(this.id, resultText) as String;
//                  finalResult = resultText,
//                    _speak("Fragmentula  fost găsit!"),
                  print(snapshot.data),
                  _speak(snapshot.data),

                },
                color : Colors.blue,
              );
                },
                ),
            ),
           ],
         ),
       ),
     );
   }
 }


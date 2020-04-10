import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart';
import 'package:get_ip/get_ip.dart';

main() async{
  String title = 'Harry Potter';
  String question  = 'Who is the enemy of Harry Potter?';
//  String _ip = await _getIpAdress();
//  print(_ip);
  var book = await _makeGetRequest();
  List<dynamic> books = jsonDecode(book);
//  print(books);
  print(books.length);
  for(var i = 0; i < books.length; i++){
    print(books[i]);
  }
//  String fragment = await _makePostRequest(book, question);
//  print(fragment);


  // print(await _makePostRequest());
}


Future<String> _makeGetRequest() async {
  // make GET request

  print("Pas1");
  String url = 'http://192.168.0.100:5000/api/v1/resources/books/all';
  Response response = await get(url);
  // sample info available in response
  // int statusCode = response.statusCode;

  Map<String, String> headers = response.headers;
  String contentType = headers['content-type'];

  String json = response.body;
  const Latin1Codec latin1 = Latin1Codec();
  var decoded = utf8.encode(json);
  var encode = utf8.decode(decoded);
//  print(encode);
//  print(json);
  // TODO convert json to object...
  // print(statusCode);
  return encode;
}

Future<String> _makePostRequest(book, question) async {
  String url = 'http://10.0.2.2:5000/api/v1/resources/books';
  Map<String, String> headers = {"Content-type": "application/json"};
  
  // make POST request
  var bookJson = jsonDecode(book);
  bookJson['question'] = question;

  book = jsonEncode(bookJson);
  print(book);
  Response response = await post(url, headers: headers, body: book);
  // int statusCode = response.statusCode;

  // a
  String fragment = response.body;
  return fragment;
}

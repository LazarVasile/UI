import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart';

main() async{
  String title = 'Harry Potter';
  String question  = 'Who is the enemy of Harry Potter?';
  String book = await _makeGetRequest();
  print(book);

//  String fragment = await _makePostRequest(book, question);
//  print(fragment);


  // print(await _makePostRequest());
}

Future<String> _makeGetRequest() async {
  // make GET request
  String url = 'http://10.0.2.2:5000/api/v1/resources/books/all';
  Response response = await get(url);
  // sample info available in response
  // int statusCode = response.statusCode;

  Map<String, String> headers = response.headers;
  String contentType = headers['content-type'];

  String json = response.body;
  print(json);
  // TODO convert json to object...
  // print(statusCode);
  return json;
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

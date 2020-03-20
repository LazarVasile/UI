import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final title = 'Books list';
    final List<String> names = ["After", "Harry Potter", "Lord of the rings"];
    final List<String> authors= ["Anna Todd", "J.K. Rowling", "J.R.R. Tolkein"];

        return MaterialApp(
          title: title,
          home: Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: ListView.builder(
              itemCount: names.length,
              // Let the ListView know how many items it needs to build.
              // Provide a builder function. This is where the magic happens.
              // Convert each item into a widget based on the type of item it is.
              itemBuilder: (context, index) {
    
                return ListTile(
                  title: Text(names[index], style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  )),
                  subtitle: Text(authors[index], style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                    
                  )),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondRoute()),
                    );
                  } ,
                  
                );
              },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String text = "   October arrived, spreading a damp chill over the grounds and into the castle. dlsadsaldlsad sdladl asldas dsall dsaldsal  Madam Pomfrey, the nurse, was kept busy by a sudden spate of colds among the staff and students. Her Pepperup potion worked instantly, though it left the drinker smoking at the ears for several hours afterward. Ginny Weasley, who had been looking pale, was bullied into taking some by Percy. The steam pouring from under her vivid hair gave the impression that her whole head was on fire. Raindrops the size of bullets thundered on the castle windows for days on end; the lake rose, the flower beds turned into muddy streams, and Hagrid's pumpkins swelled to the size of garden sheds. Oliver Wood's enthusiasm for regular training sessions, however, was not dampened, which was why Harry was to be found, late one stormy Saturday afternoon a few days before Halloween, returning to Gryffindor Tower, drenched to the skin and splattered with mud.";
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Harry Potter"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget> [
            new Text(text, style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18.0,
            )),
            new Container(
              margin: const EdgeInsets.only(top: 40.0),
              width: width,
              height: 60,
              child: new RaisedButton(
                onPressed: () {},
                child: const Text('Inregistrare vocala!', style: TextStyle(fontSize: 20)),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 5,
                
                
                
              ),
            ),
          ]
        ),
      ),
    );
  }
}
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grapevineapp/Strucuture/Response.dart';
import 'package:http/http.dart' as http;
class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}
final List<ChatMessage> _messages = <ChatMessage>[];
String prevmessage='';

final TextEditingController _textController = new TextEditingController();

class _ChatState extends State<Chat> {
  @override
  void initState() {
    // TODO: implement initState
    Response("Hi");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height*0.15,
                width: MediaQuery.of(context).size.width,

                decoration: BoxDecoration(
                    color: Color(0xFFABB1D6),
                    borderRadius: BorderRadius.only(bottomRight:  Radius.circular(30),bottomLeft:  Radius.circular(30)), boxShadow: [new BoxShadow(

                ),]


                ),
                child: Row(children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Image.asset('assets/logo.png'),

                  ),
                  Container(
                      child:Text('GRAPEVINE',style: TextStyle(fontSize: 35,color: Color(0xff3C2C59),fontWeight: FontWeight.bold),)
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child:CircleAvatar(
                    radius: 25,
                      backgroundColor: Color(0xffF3F2F6),
                      child: Icon(Icons.person,size: 40,color: Color(0xff0E0128),),
                  )),
                ],
                ),
              ),
              new Flexible(
                  child: new ListView.builder(
                    padding: new EdgeInsets.all(8.0),
                    reverse: true,
                    itemBuilder: (_, int index) => _messages[index],
                    itemCount: _messages.length,
                  )),
              new Divider(height: 1.0),
              new Container(
                decoration: new BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),

      ],
          ),
    );
  }
  

Widget _buildTextComposer() {
  return new IconTheme(
    data: new IconThemeData(color: Theme
        .of(context)
        .accentColor),
    child: new Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          new Flexible(
            child: new TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration:
              new InputDecoration.collapsed(hintText: "Send a message"),
            ),
          ),
          new Container(
            margin: new EdgeInsets.symmetric(horizontal: 4.0),
            child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text)),
          ),
        ],
      ),
    ),
  );
}
void Response(query) async {
  _textController.clear();
  Dio dio = new Dio();

  String token = '5SBAEAMO2OKBF5P6HEKZP4NO42MN4GZP';
  Map<String, String> qParams = {
    'v': '20200513',
    'q': query.toString(),
  };
  var options = new Options();
  options.headers['Authorization'] = 'Bearer $token';
  var response = await dio.get(
      'https://api.wit.ai/message', options: options, queryParameters: qParams);
  print(response);
  Welcome welcome = new Welcome.fromJson(response.data);
  String message1;
  if (welcome.intents.length != 0)
    message1 = welcome.intents[0].name;

  if (message1 == 'greeting') {
    message1 = 'Hello! Welcome to Grapevine! \nHow May I help you?';
    ChatMessage message = new ChatMessage(
      text: message1,
      name: "Grapevine Bot",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
    return;
  }
  if (message1 == 'get_hired') {
    message1 =
    'Thank you for using out platform. We will be sending your profile to potential employers. Please be patient.';
    ChatMessage message = new ChatMessage(
      text: message1,
      name: "Grapevine Bot",
      type: false,
    );
    setState(() {
      _messages.insert(0,message);
    });
    return;
  }
  if (message1 == 'to_hire') {
    message1 = 'What skills are you looking for?';
    prevmessage = 'What skills are you looking for?';
    ChatMessage message = new ChatMessage(
      text: message1,
      name: "Grapevine Bot",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
    return;
  }
  if (prevmessage == 'What skills are you looking for?') {
    message1 = 'What personal qualities are you looking for ?';
    prevmessage = 'What personal qualities are you looking for ?';
    ChatMessage message = new ChatMessage(
      text: message1,
      name: "Grapevine Bot",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
    return;
  }
  if (prevmessage == 'What personal qualities are you looking for ?');
  {
    message1 = 'Thank you for using our platform. \n' +
        'We shall soon notify you about potential candidates.';
    String message2;

    /*if(welcome.entities.qualityQuality[0].body!=null)
    message2=welcome.entities.qualityQuality[0].body;

    List<Welcome> response;
    if(message2=="nice")
      {
        FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
        firebaseDatabase.reference().child("Get Hired").once().then((DataSnapshot snapshot)
        {
          Map<dynamic, dynamic> values = snapshot.value;
          values.forEach((key,values) {
            print(values["desc"]);
          });
        });
      }*/
    ChatMessage message = new ChatMessage(
      text: message1,
      name: "Grapevine Bot",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
    return;
  }






}
void _handleSubmitted(String text) {
  _textController.clear();
  ChatMessage message = new ChatMessage(
    text: text,
    name: "Abhijeet Swain",
    type: true,
  );
  setState(() {
    _messages.insert(0, message);
  });
  Response(text);
}}
class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: new CircleAvatar(backgroundColor: Color(0xffABB1D6),radius:20,child: Image.asset('assets/logo.png')),
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(this.name,
                style: new TextStyle(fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(this.name, style: Theme.of(context).textTheme.subhead),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
      new Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: new CircleAvatar(
            child: new Text(
              this.name[0],
              style: new TextStyle(fontWeight: FontWeight.bold),
            )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}


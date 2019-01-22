import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main()=>runApp(MaterialApp(
  home:HomePage(),
));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final String url = "https://swapi.co/api/people";
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData()async{
    var response=await http.get(
      //encode the url
      Uri.encodeFull(url),
      //only accept json
      headers: {"Accept": "application/json"}
    );
    print(response.body);
    setState((){
      var convertDataToJson=json.decode(response.body);
      data=convertDataToJson['results'];
    });
    return "Success";
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP_JSON"),
      ),
      body:ListView.builder(
        itemCount: data==null?0:data.length,
        itemBuilder: (BuildContext context,int index){
          return Container(
            child: Center(
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: <Widget>[
                   Card(
                     child:Container(
                       child:Column(
                        children: <Widget>[
                          Text(data[index]['name']),
                          Text(data[index]['height']),
                          Text(data[index]['mass']),
                          Text(data[index]['hair_color']),
                          Text(data[index]['skin_color']),
                          Text(data[index]['eye_color']),
                          Text(data[index]['birth_year']),
                          Text(data[index]['gender']),
                          Text(data[index]['homeworld']),
                          Column(
                            children: <Widget>[
                              Text(data[index]['films'][0]),
                          ],),
                        ],
                       ),
                       padding: const EdgeInsets.all(20.0),
                       ),

                   ),
                 ],
              ),
            ),
          );
        },
      ),

    );
  }
}
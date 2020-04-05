import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ApiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api layout demo',
      theme: ThemeData(
          primaryColor: Colors.amberAccent),
      home: CallApi(),
    );
  }
}

Future<Town> fetchTowns() async {
  var link = 'http://192.168.1.101:3000/towns';
  final response = await http.get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
  if(response.statusCode == 200) {
    var body = response.body;
    Map<String, dynamic> json = jsonDecode(body);
    return Town.fromJson(json["town"]);
  } else {
    throw Exception('Failed to load town');
  }

}

class CallApiState extends State<CallApi> {
  Future<Town> futureTown;
  @override
  void initState() {
    super.initState();
    futureTown = fetchTowns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api layout demo'),
      ),
      body: Center(
        child: FutureBuilder<Town>(
          future: futureTown,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return Text(snapshot.data.name);
            } else if (snapshot.hasError){
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          }
        ),
      ),
    );
  }

}

class CallApi extends StatefulWidget {
  @override
  CallApiState createState() => CallApiState();
}

class Town {
  final int id;
  final String name;

  Town({this.id, this.name});

  factory Town.fromJson(Map<String, dynamic> json) => Town (
    id: json['id'],
    name: json['name'],
  );
}


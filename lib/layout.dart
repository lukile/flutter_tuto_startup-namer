import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Flutter layout demo',
        theme: ThemeData(
            primaryColor: Colors.lightBlueAccent),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter layout demo'),
          ),
          body: Center(
            child: Text('Hello World'),
          ),
        ),
      );
  }
}
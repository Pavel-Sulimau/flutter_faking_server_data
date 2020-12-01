import 'package:flutter/material.dart';
import 'package:flutter_faking_server_data/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: SafeArea(
            top: false,
            child: HomeScreen(),
          ),
        ),
      ),
    );
  }
}

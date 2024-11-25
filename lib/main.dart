import 'Homepage1.dart';
import 'Homepage2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/homepage1',
    routes: {
      '/homepage1': (context) => Homepage1(),
      '/homepage2': (context) => Homepage2(),
    },
  ),
  );
}
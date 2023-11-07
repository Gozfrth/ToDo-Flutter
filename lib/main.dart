import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/pages/graph_page.dart';
import 'package:todo/pages/home_page.dart';

// import 'themes/theme.dart';

void main() async {
  //init hive
  await Hive.initFlutter();

  //open a box?
  // ignore: unused_local_variable
  var box = await Hive.openBox('mybox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

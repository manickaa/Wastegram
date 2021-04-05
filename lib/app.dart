import 'package:flutter/material.dart';
import './screens/waste_list_screen.dart';
import 'screens/new_waste_entry_screen.dart';
import 'screens/waste_detail_screen.dart';

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  static final routes = {
    WasteDetail.routeName: (context) => WasteDetail(),
    NewWasteEntry.routeName: (context) => NewWasteEntry()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste-A-Gram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: WasteList(),
      routes: routes,
    );
  }
}

import 'package:flutter/material.dart';

import '../screens/new_waste_entry_screen.dart';

class FloatingAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          onPressed: () =>
              Navigator.of(context).pushNamed(NewWasteEntry.routeName),
        ));
  }
}

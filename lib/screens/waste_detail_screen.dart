import 'package:flutter/material.dart';
import 'package:wastegram/models/waste_post.dart';
import 'package:date_format/date_format.dart';
import 'package:wastegram/widgets/image_placeholder.dart';

class WasteDetail extends StatelessWidget {
  static final routeName = 'waste-detail';
  @override
  Widget build(BuildContext context) {
    final WastePost wasteRecord = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('Waste-A-Gram')),
        body: Center(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text(
                      formatDate(wasteRecord.date.toDate(),
                          [DD, ', ', MM, ' ', d, ', ', yyyy]),
                      style: TextStyle(fontSize: 25))),
              ImagePlaceholder(
                post: wasteRecord,
              ),
              Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(wasteRecord.quantity.toString() + ' items',
                      style: TextStyle(fontSize: 22.0))),
              SizedBox(
                height: 120,
              ),
              Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                          'Location: ' +
                              wasteRecord.latitude.toString() +
                              ', ' +
                              wasteRecord.longitude.toString(),
                          style: TextStyle(fontSize: 22.0))))
            ],
          ),
        ));
  }
}

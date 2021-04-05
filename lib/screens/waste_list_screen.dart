import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';

import 'package:wastegram/widgets/floating_action.dart';
import 'package:wastegram/models/waste_post.dart';

import 'waste_detail_screen.dart';

class WasteList extends StatefulWidget {
  static final routeName = '/';
  @override
  _WasteListState createState() => _WasteListState();
}

class _WasteListState extends State<WasteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Waste-A-Gram')),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('date', descending: true)
              .snapshots(),
          builder: (content, snapshot) {
            if (snapshot.hasData &&
                snapshot.data.docs != null &&
                snapshot.data.docs.length > 0) {
              return Column(children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          var post = snapshot.data.docs[index];

                          final wasteRecord = WastePost.fromFirestore(post);
                          return Container(
                            child: Semantics(
                              enabled: true,
                              label: 'Entry of waste item',
                              onTapHint: 'Entry of waste item',
                              child: ListTile(
                                  title: Text(
                                    formatDate(wasteRecord.date.toDate(),
                                        [DD, ', ', MM, ' ', d, ', ', yyyy]),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  trailing: Text(
                                      wasteRecord.quantity.toString(),
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, WasteDetail.routeName,
                                        arguments: wasteRecord);
                                  }),
                            ),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide())),
                          );
                        })),
              ]);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Semantics(
        child: FloatingAction(),
        button: true,
        enabled: true,
        onTapHint: 'Select an image',
      ),
    );
  }
}

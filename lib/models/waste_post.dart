import 'package:cloud_firestore/cloud_firestore.dart';

class WastePost {
  Timestamp date;
  String imageURL;
  double latitude;
  double longitude;
  int quantity;

  WastePost(
      {this.date, this.imageURL, this.latitude, this.longitude, this.quantity});

  factory WastePost.fromFirestore(DocumentSnapshot documentSnapshot) {
    return WastePost(
        date: documentSnapshot['date'],
        imageURL: documentSnapshot['imageURL'],
        quantity: documentSnapshot['quantity'],
        latitude: (documentSnapshot['latitude'] == null)
            ? null
            : documentSnapshot['latitude'],
        longitude: (documentSnapshot['longitude'] == null)
            ? null
            : documentSnapshot['longitude']);
  }

  void addDocumentToPosts() {
    FirebaseFirestore.instance.collection('posts').add({
      'date': this.date,
      'quantity': this.quantity,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'imageURL': this.imageURL
    });
  }
}

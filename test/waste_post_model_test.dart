// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wastegram/models/waste_post.dart';

void main() {
  final fakeDate = Timestamp.fromDate(DateTime.parse('2020-01-01'));
  const fakeImageURL = "Sample_Url";
  const fakeQuantity = 1;
  const fakeLatitude = 1.0;
  const fakeLongitude = 5.0;

  final waste_post = WastePost(
      date: fakeDate,
      imageURL: fakeImageURL,
      quantity: fakeQuantity,
      latitude: fakeLatitude,
      longitude: fakeLongitude);

  test('Post created with constructor should have appropriate property values',
      () {
    expect(waste_post.date, fakeDate);
    expect(waste_post.imageURL, fakeImageURL);
    expect(waste_post.quantity, fakeQuantity);
    expect(waste_post.latitude, fakeLatitude);
    expect(waste_post.longitude, fakeLongitude);
  });

  test('The type of Date created must be TimeStamp', () {
    expect(waste_post.date.runtimeType, Timestamp);
  });

  test('The type of Quantity created must be integer', () {
    expect(waste_post.quantity.runtimeType, int);
  });
}

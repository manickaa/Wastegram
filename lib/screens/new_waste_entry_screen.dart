import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:wastegram/models/waste_post.dart';

class NewWasteEntry extends StatefulWidget {
  static final routeName = 'new-entry';
  @override
  _NewWasteEntryState createState() => _NewWasteEntryState();
}

class _NewWasteEntryState extends State<NewWasteEntry> {
  File finalImage;
  LocationData locationData;

  final wastePost = WastePost();
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    if (mounted) {
      setState(() {});
    }
  }

  void savePostToCloud() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      var currentDateTime = DateTime.now();
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child(currentDateTime.toString() + '.jpg');
      await storageReference.putFile(finalImage);
      final String url = await storageReference.getDownloadURL();
      wastePost.imageURL = url.toString();
      wastePost.date = Timestamp.fromDate(currentDateTime);
      wastePost.latitude = locationData.latitude;
      wastePost.longitude = locationData.longitude;
      wastePost.addDocumentToPosts();
      navigateBack(context);
    }
  }

  void navigateBack(context) {
    Navigator.of(context).pop();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    var image = File(pickedFile.path);
    if (mounted) {
      setState(() {
        finalImage = image;
      });
    }
  }

  Future takePicture() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    var image = File(pickedFile.path);
    if (mounted) {
      setState(() {
        finalImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Waste-A-Gram')),
      body: Center(
          child: (finalImage == null) ? promptForPhoto() : promptForUpload()),
    );
  }

  Widget promptForPhoto() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Semantics(
        button: true,
        enabled: true,
        onTapHint: 'Choose image from gallery',
        child: RaisedButton(
          onPressed: () {
            getImage();
          },
          child: Text('Choose Photo'),
        ),
      ),
      Semantics(
        button: true,
        enabled: true,
        onTapHint: 'Take picture from camera',
        child: RaisedButton(
          onPressed: () {
            takePicture();
          },
          child: Text('Take Picture'),
        ),
      )
    ]);
  }

  Widget quantityFormField() {
    return TextFormField(
      autofocus: true,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]+'))],
      decoration: InputDecoration(
          hintText:
              Translations(Localizations.localeOf(context)).quantityFieldHint),
      style: Theme.of(context).textTheme.headline5,
      textAlign: TextAlign.center,
      onSaved: (value) {
        wastePost.quantity = int.parse(value);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Wasted Items cannot be empty';
        } else {
          return null;
        }
      },
    );
  }

  Widget promptForUpload() {
    return Container(
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Semantics(
                image: true,
                label: 'Image of the wasted item',
                child: Image.file(finalImage,
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.height * 0.3),
              ),
              SizedBox(
                height: 40,
              ),
              Semantics(
                  textField: true,
                  label: 'Form field for number of wasted items',
                  enabled: true,
                  child: quantityFormField()),
              SizedBox(
                height: 20,
              ),
              Semantics(
                child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: RaisedButton(
                        child: Icon(Icons.cloud_upload),
                        color: Colors.lightGreen,
                        onPressed: () {
                          savePostToCloud();
                        })),
                button: true,
                enabled: true,
                onTapHint: 'Save the image to the cloud',
              )
            ]))));
  }
}

class Translations {
  Locale locale;
  Translations(Locale locale) {
    this.locale = locale;
  }

  final labels = {
    'en': {'quantityFieldHint': 'Number of wasted items'},
    'de': {'quantityFieldHint': 'Anzahl der verschwendeten Gegenstände'}
  };

  String get quantityFieldHint =>
      labels[locale.languageCode]['quantityFieldHint'];
}

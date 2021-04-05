import 'package:flutter/material.dart';
import 'package:wastegram/models/waste_post.dart';

class ImagePlaceholder extends StatelessWidget {
  final WastePost post;

  ImagePlaceholder({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        height: 400.0,
        width: 350.0,
        child: Image.network(
          post.imageURL,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

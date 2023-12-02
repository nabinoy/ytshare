import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  static const String routeName = '/image_viewer';
  final String imagePath;

  const ImageViewer({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Hero(
            tag: imagePath,
            child: PhotoView(
              imageProvider: NetworkImage(imagePath),
              backgroundDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background),
              initialScale: PhotoViewComputedScale.contained,
            ),
          ),
        ),
      ),
    );
  }
}

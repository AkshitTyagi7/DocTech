import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../utility/common.dart';

class ImageWidget extends StatefulWidget {
  final ValueChanged<File> onImageSelected;
  const ImageWidget({super.key, required this.onImageSelected});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  File? image;
  Future pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        image = File(pickedFile!.path);
      });
      widget.onImageSelected(image!);
    } catch (e) {
      log(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: pickImage,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: image == null
                      ? Container(
                          color: Theme.of(context).colorScheme.primaryContainer,
                        )
                      : Image.file(
                          image!,
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ),
                ),
                Align(alignment: Alignment.bottomRight, child: Image.asset('assets/icons/pickImage.png', height: 30, width: 30))
              ],
            ),
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}

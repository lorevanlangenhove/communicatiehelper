import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CameraPage extends StatefulWidget {
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? img;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.img = imageTemporary);
    } on PlatformException catch (e) {
      print('Geen foto geselecteerd: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          SizedBox(
            height: 50.0,
            width: 200.0,
            child: TextButton.icon(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
              onPressed: () {
                pickImage();
              },
              label: const Text(
                'Kies een foto',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              icon: const Icon(
                Icons.image,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
            width: 20,
          ),
          img != null
              ? const Text('Er is geen foto geselecteerd')
              : Image.file(
                  img!,
                  height: 200,
                  width: 200,
                ),
        ],
      ),
    );
  }
}

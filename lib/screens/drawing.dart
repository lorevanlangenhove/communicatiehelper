import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:whiteboard/whiteboard.dart';
import 'package:file_saver/file_saver.dart';

class DrawingPage extends StatefulWidget {
  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  WhiteBoardController whiteBoardController = WhiteBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tekenen'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              whiteBoardController.redo();
            },
            icon: const Icon(Icons.redo),
          ),
          IconButton(
            onPressed: () {
              whiteBoardController.undo();
            },
            icon: const Icon(Icons.undo),
          ),
          IconButton(
            onPressed: () {
              whiteBoardController.convertToImage();
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              whiteBoardController.clear();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: WhiteBoard(
                strokeColor: Colors.black,
                controller: whiteBoardController,
                onConvertImage: (Uint8List imageList) async {
                  await FileSaver.instance
                      .saveAs('Tekening', imageList, 'png', MimeType.PNG);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whiteboard/whiteboard.dart';
import 'package:file_saver/file_saver.dart';

class DrawingPage extends StatefulWidget {
  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  WhiteBoardController whiteBoardController = WhiteBoardController();
  Color color = Colors.red;
  bool erasing = false;
  @override
  initState() {
    super.initState();
  }

  WhiteBoard getColor() {
    return WhiteBoard(
      strokeColor: color,
      isErasing: erasing,
      controller: whiteBoardController,
      onConvertImage: (Uint8List imageList) async {
        await FileSaver.instance
            .saveAs('Tekening', imageList, 'png', MimeType.PNG);
      },
    );
  }

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
                strokeColor: color,
                isErasing: erasing,
                controller: whiteBoardController,
                onConvertImage: (Uint8List imageList) async {
                  await FileSaver.instance
                      .saveAs('Tekening', imageList, 'png', MimeType.PNG);
                },
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    color = Colors.black;
                    print(color);
                  },
                  icon: const Icon(
                    Icons.circle,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    color = Colors.blue;
                    print(color);
                  },
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    color = Colors.green;
                    print(color);
                  },
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    color = Colors.red;
                    print(color);
                  },
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

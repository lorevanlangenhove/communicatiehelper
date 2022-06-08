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
  WhiteBoardController controller = WhiteBoardController();

  WhiteBoard changeColor(Color color) {
    return WhiteBoard(
      strokeColor: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tekenen'),
        actions: [
          IconButton(
            onPressed: () {
              controller.clear();
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              controller.convertToImage();
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              controller.redo();
            },
            icon: const Icon(Icons.redo),
          ),
          IconButton(
            onPressed: () {
              controller.undo();
            },
            icon: const Icon(Icons.undo),
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
                controller: controller,
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
                    changeColor(Colors.black);
                  },
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    changeColor(Colors.blue);
                  },
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    changeColor(Colors.green);
                  },
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    changeColor(Colors.red);
                  },
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.clear();
                  },
                  icon: const Icon(
                    CupertinoIcons.delete,
                    color: Colors.black,
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

class ColorWhiteboard extends StatelessWidget {
  ColorWhiteboard({required this.color});

  Color color;

  @override
  Widget build(BuildContext context) {
    return WhiteBoard(
      strokeColor: color,
    );
  }
}

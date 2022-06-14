import 'package:flutter/material.dart';
import 'package:whiteboard/whiteboard.dart';

class DrawingPage extends StatefulWidget {
  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  late WhiteBoardController whiteBoardController;
  WhiteBoard whiteBoard = const WhiteBoard(
    strokeColor: Colors.black,
  );

  void _whiteboardController(WhiteBoardController controller) {
    whiteBoardController = controller;
  }

  @override
  initState() {
    super.initState();
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
              //_whiteboardController;
              whiteBoardController.redo();
            },
            icon: const Icon(Icons.redo),
          ),
          IconButton(
            onPressed: () {
              _whiteboardController;
              whiteBoardController.undo();
            },
            icon: const Icon(Icons.undo),
          ),
          IconButton(
            onPressed: () {
              //_whiteboardController;
              whiteBoardController.convertToImage();
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              //_whiteboardController;
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
                controller: WhiteBoardController(),
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    whiteBoard.strokeColor.blue;
                  },
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    whiteBoard.strokeColor.green;
                  },
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    whiteBoard.strokeColor.red;
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

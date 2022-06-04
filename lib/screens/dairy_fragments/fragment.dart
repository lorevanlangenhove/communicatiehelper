import 'package:communicatiehelper/database/db.dart';
import 'package:flutter/material.dart';

class Fragment extends StatefulWidget {
  final int id;

  const Fragment({Key? key, required this.id}) : super(key: key);

  @override
  State<Fragment> createState() => _FragmentState();
}

class _FragmentState extends State<Fragment> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late AppDb _db;
  late DairyData _dairyData;

  @override
  void initState() {
    super.initState();
    _db = AppDb();
    getFragment();
  }

  @override
  void dispose() {
    _db.close();
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Future<void> getFragment() async {
    _dairyData = await _db.getFragment(widget.id);
    _titleController.text = _dairyData.title;
    _descriptionController.text = _dairyData.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Een dagboek fragment'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/update_fragment');
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/update_fragment');
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'TEST1',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'DESCRIPTION1',
            style: TextStyle(fontSize: 40.0),
          ),
        ],
      ),
    );
  }
}

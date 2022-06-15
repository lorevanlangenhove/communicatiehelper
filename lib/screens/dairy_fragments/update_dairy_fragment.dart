import 'dart:io';

import 'package:communicatiehelper/components/custom_multiline.dart';
import 'package:communicatiehelper/components/custom_text_form_field.dart';
import 'package:communicatiehelper/database/db.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateDairyFragment extends StatefulWidget {
  final int id;

  const UpdateDairyFragment({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateDairyFragment> createState() => _UpdateDairyFragmentState();
}

class _UpdateDairyFragmentState extends State<UpdateDairyFragment> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late DairyData _dairyData;
  final _formKey = GlobalKey<FormState>();
  File? img;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => img = imageTemp);
    } on PlatformException catch (e) {
      print('Niet gelukt om foto te kiezen: $e');
    }
  }

  Future takePhoto() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => img = imageTemp);
    } on PlatformException catch (e) {
      print('Niet gelukt om foto te maken: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getFragment();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void updateDairyFragment() {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      final entity = DairyCompanion(
        id: drift.Value(widget.id),
        title: drift.Value(_titleController.text),
        description: drift.Value(_descriptionController.text),
        created: drift.Value(DateTime.now()),
      );
      Provider.of<AppDb>(context, listen: false).updateFragment(entity).then(
            (value) => ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                backgroundColor: Colors.green,
                content: const Text(
                  'Dagboek fragment is gewijzigd',
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    },
                    child: const Text(
                      'Sluit',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          );
    }
  }

  Future<void> getFragment() async {
    _dairyData =
        await Provider.of<AppDb>(context, listen: false).getFragment(widget.id);
    _titleController.text = _dairyData.title;
    _descriptionController.text = _dairyData.description;
  }

  void deleteFragment() {
    Provider.of<AppDb>(context, listen: false).deleteFragment(widget.id).then(
          (value) => ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              backgroundColor: Colors.red,
              content: const Text(
                'Dagboek fragment is verwijdert',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  },
                  child: const Text(
                    'Sluit',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wijzig dagboek fragment'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              deleteFragment();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Form(
                child: CustomTextFormField(
                    controller: _titleController, inputLabel: 'Titel'),
                key: _formKey,
              ),
              const SizedBox(
                height: 8.0,
              ),
              CustomMultiline(
                  controller: _descriptionController, inputLabel: 'Tekst'),
              const SizedBox(
                height: 50.0,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    Icons.photo,
                    color: Colors.black,
                  ),
                ),
              ),
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
                    takePhoto();
                  },
                  label: const Text(
                    'Neem een foto',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.0,
                width: 200.0,
                child: TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                  onPressed: () {
                    updateDairyFragment();
                  },
                  label: const Text(
                    'Opslaan',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  icon: const Icon(
                    Icons.check,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
                width: 200.0,
                child: TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: const Text(
                    'Annuleren',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
            width: 20,
          ),
          img == null
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communicatiehelper/components/custom_multiline.dart';
import 'package:communicatiehelper/components/custom_text_form_field.dart';
import '../../models/fragment.dart';
import 'package:flutter/material.dart';

class UpdateDairyFragment extends StatefulWidget {
  final Fragment fragment;

  const UpdateDairyFragment({Key? key, required this.fragment})
      : super(key: key);

  @override
  State<UpdateDairyFragment> createState() => _UpdateDairyFragmentState();
}

class _UpdateDairyFragmentState extends State<UpdateDairyFragment> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final fragment = widget.fragment;
    _titleController.text = fragment.title;
    _descriptionController.text = fragment.description;
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Future updateFragment(Fragment fragment) async {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      final docFragment =
          FirebaseFirestore.instance.collection('fragments').doc(fragment.id);
      final json = fragment.toJson();
      await docFragment.update(json).then(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wijzig dagboek fragment'),
        centerTitle: true,
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
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                  onPressed: () {
                    final fragment = Fragment(
                        id: widget.fragment.id,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        created: DateTime.now());
                    updateFragment(fragment);
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
        ],
      ),
    );
  }
}

import 'package:communicatiehelper/components/custom_text_form_field.dart';
import 'package:communicatiehelper/database/db.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:provider/provider.dart';

class AddDairyFragment extends StatefulWidget {
  @override
  State<AddDairyFragment> createState() => _AddDairyFragmentState();
}

class _AddDairyFragmentState extends State<AddDairyFragment> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void addDairyFragment() {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      final entity = DairyCompanion(
        title: drift.Value(_titleController.text),
        description: drift.Value(_descriptionController.text),
        created: drift.Value(DateTime.now()),
      );
      Provider.of<AppDb>(context, listen: false).insertFragment(entity).then(
            (value) => ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                backgroundColor: Colors.green,
                content: const Text(
                  'Nieuw dagboek fragment is opgeslagen',
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
        title: const Text('Nieuw dagboek fragment'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            child: Column(
              children: [
                CustomTextFormField(
                    controller: _titleController, inputLabel: 'Titel'),
                const SizedBox(
                  height: 8.0,
                ),
                CustomTextFormField(
                    controller: _descriptionController, inputLabel: 'Tekst'),
              ],
            ),
            key: _formKey,
          ),
          const SizedBox(
            height: 50.0,
          ),
          SizedBox(
            height: 50.0,
            width: 200.0,
            child: TextButton.icon(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              onPressed: () {
                //alert
              },
              label: const Text(
                'Voeg foto toe',
                style: TextStyle(fontSize: 20.0),
              ),
              icon: const Icon(
                Icons.add_a_photo,
                color: Colors.black,
              ),
            ),
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
                    addDairyFragment();
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

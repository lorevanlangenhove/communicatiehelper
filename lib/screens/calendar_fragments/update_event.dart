import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communicatiehelper/components/custom_multiline.dart';
import 'package:communicatiehelper/screens/calendar_fragments/utils.dart';
import 'package:flutter/material.dart';
import '../../components/custom_text_form_field.dart';
import '../../models/event.dart';

class UpdateEvent extends StatefulWidget {
  const UpdateEvent({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  State<UpdateEvent> createState() => _UpdateEvent();
}

class _UpdateEvent extends State<UpdateEvent> {
  late DateTime fromDate;
  late DateTime toDate;
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool value = false;

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
    } else {
      final event = widget.event;
      _titleController.text = event.title;
      _descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  Widget buildDateTimePickers() {
    return Column(
      children: [buildFrom(), buildTo()],
    );
  }

  Widget buildFrom() {
    return buildHeader(
      header: 'VAN',
      child: Row(
        children: [
          Expanded(
            child: buildDropdownField(
                text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true)),
          ),
          Expanded(
            child: buildDropdownField(
                text: Utils.toTime(fromDate),
                onClicked: () => pickFromDateTime(pickDate: false)),
          ),
        ],
      ),
    );
  }

  Widget buildTo() {
    return buildHeader(
      header: 'TOT',
      child: Row(
        children: [
          Expanded(
            child: buildDropdownField(
              text: Utils.toDate(toDate),
              onClicked: () => pickToDateTime(pickDate: true),
            ),
          ),
          Expanded(
            child: buildDropdownField(
              text: Utils.toTime(toDate),
              onClicked: () => pickToDateTime(pickDate: false),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownField(
      {required String text, required VoidCallback onClicked}) {
    return ListTile(
      title: Text(text),
      trailing: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
      ),
      onTap: onClicked,
    );
  }

  Widget buildHeader({required String header, required Row child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        child
      ],
    );
  }

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);

    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() => fromDate = date);
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );

    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() => toDate = date);
  }

  Future<DateTime?> pickDateTime(DateTime initialDate,
      {required bool pickDate, DateTime? firstDate}) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Future saveForm(Event event) async {
    final isValid = _formKey.currentState!.validate();
    final isValid1 = _formKey1.currentState!.validate();
    if (isValid && isValid1) {
      final docEvent =
          FirebaseFirestore.instance.collection('events').doc(event.id);
      final json = event.toJson();
      await docEvent
          .update(json)
          .then((value) => ScaffoldMessenger.of(context).showMaterialBanner(
                MaterialBanner(
                  backgroundColor: Colors.green,
                  content: const Text(
                    'Afspraak is gewijzigd',
                    style: TextStyle(color: Colors.black),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .hideCurrentMaterialBanner();
                      },
                      child: const Text(
                        'Sluit',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maak een afspraak'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              child: CustomTextFormField(
                  controller: _titleController, inputLabel: 'Titel'),
              key: _formKey,
            ),
            const SizedBox(height: 12),
            CustomMultiline(
                controller: _descriptionController, inputLabel: 'Beschrijving'),
            const SizedBox(height: 20),
            Form(
              child: buildDateTimePickers(),
              key: _formKey1,
            ),
            const SizedBox(height: 20),
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
                      final event = Event(
                          id: widget.event.id,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          from: fromDate,
                          to: toDate);
                      saveForm(event);
                      //Navigator.pop(context);
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
      ),
    );
  }
}

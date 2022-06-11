import 'package:communicatiehelper/utils.dart';
import 'package:flutter/material.dart';
import '../../event.dart';
import 'package:communicatiehelper/components/custom_text_form_field.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key, this.event}) : super(key: key);
  final Event? event;

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  late DateTime fromDate;
  late DateTime toDate;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
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

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final event = Event(
        title: _titleController.text,
        description: 'Description',
        from: fromDate,
        to: toDate,
      );
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                  controller: _titleController, inputLabel: 'Titel'),
              const SizedBox(height: 12),
              buildDateTimePickers(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class DateTimeInputField extends StatefulWidget {
  final TextEditingController controller;

  const DateTimeInputField({super.key, required this.controller});

  @override
  State<DateTimeInputField> createState() => _DateTimeInputFieldState();
}

class _DateTimeInputFieldState extends State<DateTimeInputField> {
  Future<void> _pickDateTime() async {
    final DateTime? date = await showDatePicker(
      context: Navigator.of(context, rootNavigator: true).context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    final TimeOfDay? time = await showTimePicker(
      context: Navigator.of(context, rootNavigator: true).context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    final DateTime dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    final formatted = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    widget.controller.text = formatted;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      onTap: _pickDateTime,
      decoration: InputDecoration(
        hintText: 'Select date & time',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.blue),
        ),
      ),
    );
  }
}

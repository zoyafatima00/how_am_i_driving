import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  CustomDateInputField({required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await _selectDate(context);
        if (pickedDate != null) {
          // Format the picked date and update the controller's text
          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
          controller.text =
              formattedDate; // Set the formatted date to the controller
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: Icon(Icons.calendar_today),
          ),
        ),
      ),
    );
  }

  // Function to show DatePicker and get selected date
  Future<DateTime?> _selectDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
  }
}

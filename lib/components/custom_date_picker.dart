import 'package:flutter/material.dart';
import 'package:pyscore/components/custom_button.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.date,
    required this.handleChange,
  });

  final DateTime date;
  final Function(DateTime) handleChange;

  @override
  CustomDatePickerState createState() => CustomDatePickerState();
}

class CustomDatePickerState extends State<CustomDatePicker> {
  void _showDatePickerDialog(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: widget.date,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return; // User canceled the date picker
      }

      showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.now(),
      ).then((selectedTime) {
        if (selectedTime == null) {
          return; // User canceled the time picker
        }

        // Combine selected date and time
        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        // Call the handleChange function with the selected DateTime
        widget.handleChange(selectedDateTime);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: "Pick a date",
      onTap: () => _showDatePickerDialog(context),
    );
  }
}

import 'package:flutter/material.dart';

Future<DateTime?> getDate({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final DateTime? date = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime.now().subtract(const Duration(days: 28)),
    lastDate: lastDate ?? DateTime.now().add(const Duration(days: 365)),
    confirmText: "Save",
    helpText: "Select Completion Date",
  );

  return date;
}

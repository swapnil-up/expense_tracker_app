import 'dart:io';

import 'package:csv/csv.dart';
import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> ExportExpensesToCsv(context, List<Expense> expenses) async {
  List<List<dynamic>> rows = [
    [
      "Title",
      "Amount",
      "Date",
      "Category",
    ]
  ];

  for (var expense in expenses) {
    rows.add([
      expense.title,
      expense.amount,
      expense.dateTime.toIso8601String(),
      expense.category.toString().split('.').last,
    ]);
  }

  await requestStoragePermission();

  String csvData = const ListToCsvConverter().convert(rows);

  Directory appDir = await getApplicationDocumentsDirectory();
  String filepath = '${appDir.path}/expenses.csv';

  File file = File(filepath);
  await file.writeAsString(csvData);

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('File saved at $filepath'),
    action: SnackBarAction(
        label: 'Show',
        onPressed: () {
          OpenFile.open(filepath);
        }),
  ));
}

Future<void> requestStoragePermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
}

import 'package:expense_tracker_app/models/expense_categories.dart';

class Expense {
  final String title;
  final int amount;
  final DateTime dateTime;
  final ExpenseCategory category;

  Expense(
      {required this.title,
      required this.amount,
      required this.dateTime,
      required this.category});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
      'date': dateTime.toIso8601String(),
      'category': category.toString().split('.').last,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      title: map['title'],
      amount: map['amount'],
      dateTime: DateTime.parse(map['date']),
      category: ExpenseCategory.values.firstWhere(
          (element) => element.toString().split('.').last == map['category']),
    );
  }
}

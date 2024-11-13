import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:expense_tracker_app/services/db_helper.dart';
import 'package:flutter/material.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;

  Future<void> loadExpense() async {
    try {
      _expenses = await DBHelper.instance.fetchAllExpense();
      print("successful load");
      notifyListeners();
    } catch (error) {
      print("Error loading expenses: $error");
    }
  }

  void addExpenses(Expense expense) async {
    await DBHelper.instance.insertExpense(expense);
    await loadExpense();
  }

  void removeExpenses(int id) async {
    await DBHelper.instance.removeExpense(id);
    await loadExpense();
  }

  void clearExpenses() async {
    await DBHelper.instance.clearAllExpense();
    _expenses = [];
    notifyListeners();
  }
}

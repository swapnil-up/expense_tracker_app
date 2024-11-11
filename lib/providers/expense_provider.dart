import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseProvider with ChangeNotifier{
  List<Expense> _expenses=[];
  List<Expense> get expenses=>_expenses;

  void addExpenses(Expense expense){
    _expenses.add(expense);
    notifyListeners();
  }

  void removeExpenses(Expense expense){
    _expenses.remove(expense);
    notifyListeners();
  }

  void clearExpenses(Expense expense){
    _expenses=[];
    notifyListeners();
  }
}
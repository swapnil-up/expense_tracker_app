import 'package:expense_tracker_app/models/expense_categories.dart';
import 'package:expense_tracker_app/providers/expense_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPieChart extends StatelessWidget {
  const CategoryPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryTotals =
        Provider.of<ExpenseProvider>(context).getCategoryTotals();

    return AspectRatio(
      aspectRatio: 1.3,
      child: PieChart(
        PieChartData(
          sections: categoryTotals.entries.map((entry) {
            final category = entry.key;
            final amount = entry.value;
            final color = _getCategoryColor(category);

            return PieChartSectionData(
              color: color,
              value: amount,
              title: amount.toStringAsFixed(1),
              radius: 50,
              titleStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Color _getCategoryColor(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.Food:
        return Colors.blue;
      case ExpenseCategory.Transport:
        return Colors.green;
      case ExpenseCategory.Entertainment:
        return Colors.red;
      case ExpenseCategory.Others:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

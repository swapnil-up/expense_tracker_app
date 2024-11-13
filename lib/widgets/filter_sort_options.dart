import 'package:expense_tracker_app/models/expense_categories.dart';
import 'package:flutter/material.dart';

class FilterSortOptions extends StatefulWidget {
  const FilterSortOptions({super.key});

  @override
  State<FilterSortOptions> createState() => _FilterSortOptionsState();
}

class _FilterSortOptionsState extends State<FilterSortOptions> {
  ExpenseCategory _selectedCategory = ExpenseCategory.Food;
  String _sortOption = 'Amount';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Filter and Sort'),
          DropdownButton<ExpenseCategory>(
              value: _selectedCategory,
              items: ExpenseCategory.values
                  .skip(1)
                  .map((ExpenseCategory category) {
                return DropdownMenuItem<ExpenseCategory>(
                  value: category,
                  child: Text(category.toString().split('.').last),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              }),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop({
                'category': _selectedCategory,
                'sort': _sortOption,
              });
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}

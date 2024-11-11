class Expense {
  final String title;
  final int amount;
  final DateTime dateTime;
  final Enum category;

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
      'category': category
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      title: map['title'],
      amount: map['amount'],
      dateTime: DateTime.parse(map['date']),
      category: map['category'],
    );
  }
}

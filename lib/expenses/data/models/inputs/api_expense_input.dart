import 'package:masareef_app/expenses/domian/entities/inputs/expense_input.dart';

class ApiExpenseInput {
  final int id;
  final String title;
  final double amount;
  final DateTime date;

  ApiExpenseInput({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  factory ApiExpenseInput.mapFormEntity(ExpenseInput input) {
    return ApiExpenseInput(
      id: input.id,
      title: input.title,
      amount: input.amount,
      date: input.date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toUtc().toString(),
    };
  }
}

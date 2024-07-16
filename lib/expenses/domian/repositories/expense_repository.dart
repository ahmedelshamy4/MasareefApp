import 'package:masareef_app/expenses/domian/entities/expense_entity.dart';
import 'package:masareef_app/expenses/domian/entities/inputs/expense_input.dart';

abstract class ExpenseRepository {
  Future<List<ExpenseEntity>> getExpenses();

  Future<void> addExpense(ExpenseInput input);

  Future<void> deleteExpense(int id);
}

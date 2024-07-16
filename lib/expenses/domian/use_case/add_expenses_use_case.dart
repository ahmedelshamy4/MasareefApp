import 'package:masareef_app/expenses/domian/entities/inputs/expense_input.dart';
import 'package:masareef_app/expenses/domian/repositories/expense_repository.dart';

class AddExpensesUseCase {
  final ExpenseRepository _repository;

  AddExpensesUseCase(this._repository);

  Future<void> execute(ExpenseInput input) async {
    return await _repository.addExpense(input);
  }
}

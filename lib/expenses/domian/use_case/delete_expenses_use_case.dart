import 'package:masareef_app/expenses/domian/repositories/expense_repository.dart';

class DeleteExpensesUseCase {
  final ExpenseRepository _repository;

  DeleteExpensesUseCase(this._repository);

  Future<void> execute(int id) async {
    return await _repository.deleteExpense(id);
  }
}

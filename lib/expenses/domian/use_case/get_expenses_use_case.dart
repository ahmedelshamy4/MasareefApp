import 'package:masareef_app/expenses/domian/entities/expense_entity.dart';
import 'package:masareef_app/expenses/domian/repositories/expense_repository.dart';

class GetExpensesUseCase {
  final ExpenseRepository _repository;

  GetExpensesUseCase(this._repository);

  Future<List<ExpenseEntity>> execute() async {
    return await _repository.getExpenses();
  }
}

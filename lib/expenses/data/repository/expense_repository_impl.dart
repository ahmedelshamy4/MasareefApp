import 'package:masareef_app/expenses/data/data_sources/expense_local_data_source.dart';
import 'package:masareef_app/expenses/data/models/inputs/api_expense_input.dart';
import 'package:masareef_app/expenses/domian/entities/expense_entity.dart';
import 'package:masareef_app/expenses/domian/entities/inputs/expense_input.dart';
import 'package:masareef_app/expenses/domian/repositories/expense_repository.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource _localDataSource;

  ExpenseRepositoryImpl(this._localDataSource);

  @override
  Future<void> addExpense(ExpenseInput input) async {
    try {
      final db = await _localDataSource.database;
      await db.insert(
        "expenses",
        ApiExpenseInput.mapFormEntity(input).toJson(),
      );
    } catch (e) {
      print('Failed to insert:${e}');
      throw DatabaseException;
    }
  }

  @override
  Future<List<ExpenseEntity>> getExpenses() async {
    try {
      final db = await _localDataSource.database;
      final result = await db.query('expenses');
      return result.map((json) => ExpenseEntity.fromEntity(json)).toList();
    } catch (e) {
      print('Failed to get:$e');
      throw DatabaseException;
    }
  }

  @override
  Future<void> deleteExpense(int id) async {
    try {
      final db = await _localDataSource.database;
      await db.delete(
        'expenses',
        where: 'id =?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Failed to delete: $e');
      throw DatabaseException;
    }
  }
}

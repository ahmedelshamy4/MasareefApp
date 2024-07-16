import 'package:masareef_app/core/app_injector.dart';
import 'package:masareef_app/expenses/data/data_sources/expense_local_data_source.dart';
import 'package:masareef_app/expenses/data/repository/expense_repository_impl.dart';
import 'package:masareef_app/expenses/domian/repositories/expense_repository.dart';
import 'package:masareef_app/expenses/domian/use_case/add_expenses_use_case.dart';
import 'package:masareef_app/expenses/domian/use_case/delete_expenses_use_case.dart';
import 'package:masareef_app/expenses/domian/use_case/get_expenses_use_case.dart';

class ExpensesDi {
  ExpensesDi._();

  static Future<void> initialize() async {
    // Register data sources
    injector.registerLazySingleton<ExpenseLocalDataSource>(() => ExpenseLocalDataSource());

// Register repositories
    injector.registerLazySingleton<ExpenseRepository>(
        () => ExpenseRepositoryImpl(injector()));
    // Register use cases
    injector.registerLazySingleton(() => AddExpensesUseCase(injector()));
    injector.registerLazySingleton(() => GetExpensesUseCase(injector()));
    injector.registerLazySingleton(() => DeleteExpensesUseCase(injector()));
  }
}

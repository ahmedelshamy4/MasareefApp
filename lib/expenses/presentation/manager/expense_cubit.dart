import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masareef_app/core/app_injector.dart';
import 'package:masareef_app/core/async.dart';
import 'package:masareef_app/expenses/domian/entities/inputs/expense_input.dart';
import 'package:masareef_app/expenses/domian/use_case/add_expenses_use_case.dart';
import 'package:masareef_app/expenses/domian/use_case/delete_expenses_use_case.dart';
import 'package:masareef_app/expenses/domian/use_case/get_expenses_use_case.dart';
import 'package:masareef_app/expenses/presentation/manager/expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  late AddExpensesUseCase _addExpensesUseCase;
  late GetExpensesUseCase _getExpensesUseCase;
  late DeleteExpensesUseCase _deleteExpensesUseCase;

  ExpenseCubit() : super(const ExpenseState.initial()) {
    _loadCases();
  }

  static ExpenseCubit of(BuildContext context) => BlocProvider.of(context);

  void _loadCases() {
    _addExpensesUseCase = injector();
    _getExpensesUseCase = injector();
    _deleteExpensesUseCase = injector();
  }

  void onCubitCreated() {
    getExpenses();
  }

  Future<void> getExpenses() async {
    emit(state.reduce(getExpensesState: const Async.loading()));
    try {
      final result = await _getExpensesUseCase.execute();
      emit(state.reduce(getExpensesState: Async.success(result)));
    } catch (e) {
      emit(state.reduce(getExpensesState: Async.failure(e.toString())));
    }
  }

  void addExpense(ExpenseInput input) async {
    emit(state.reduce(addExpensesState: const Async.loading()));
    try {
      await _addExpensesUseCase.execute(input);
      emit(state.reduce(addExpensesState: const Async.successWithoutData()));
      getExpenses(); // Refresh expenses after adding a new expense
    } catch (e) {
      emit(state.reduce(addExpensesState: Async.failure(e.toString())));
    }
  }

  void deleteExpense(int id) async {
    emit(state.reduce(deleteExpensesState: const Async.loading()));
    try {
      final result = await _deleteExpensesUseCase.execute(id);
      emit(state.reduce(deleteExpensesState: Async.success(result)));
      getExpenses(); // Refresh expenses after after deleting an expense
    } catch (e) {
      emit(state.reduce(deleteExpensesState: Async.failure(e.toString())));
    }
  }

  void filterExpenses(String query) {
    final filteredExpenses = state.getExpensesState.data?.where((expense) =>
      expense.title.toLowerCase().contains(query.toLowerCase()) ||
      expense.amount.toString().toLowerCase().contains(query.toLowerCase())
    ).toList();
    emit(state.reduce(getExpensesState: Async.success(filteredExpenses ?? [])));
  }

  void sortExpensesByDate() {
    final sortedExpenses = state.getExpensesState.data;
    sortedExpenses?.sort(
      (a, b) => b.date.compareTo(a.date),
    );
    emit(state.reduce(getExpensesState: Async.success(sortedExpenses ?? [])));
  }

  void sortExpensesByAmount() {
    final sortedExpenses = state.getExpensesState.data;
    sortedExpenses?.sort(
      (a, b) => b.amount.compareTo(a.amount),
    );
    emit(state.reduce(getExpensesState: Async.success(sortedExpenses ?? [])));
  }
}

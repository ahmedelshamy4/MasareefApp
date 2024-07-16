import 'package:equatable/equatable.dart';
import 'package:masareef_app/core/async.dart';
import 'package:masareef_app/expenses/domian/entities/expense_entity.dart';

class ExpenseState extends Equatable {
  final Async<void> addExpensesState;
  final Async<List<ExpenseEntity>> getExpensesState;
  final Async<void> deleteExpensesState;
  final String? errorMessage;

  const ExpenseState(
    this.addExpensesState,
    this.getExpensesState,
    this.deleteExpensesState,
    this.errorMessage,
  );

  const ExpenseState.initial()
      : this(
          const Async.initial(),
          const Async.initial(),
          const Async.initial(),
          null,
        );

  ExpenseState reduce({
    Async<void>? addExpensesState,
    Async<List<ExpenseEntity>>? getExpensesState,
    Async<void>? deleteExpensesState,
    String? errorMessage,
  }) {
    return ExpenseState(
      addExpensesState ?? this.addExpensesState,
      getExpensesState ?? this.getExpensesState,
      deleteExpensesState ?? this.deleteExpensesState,
      errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        addExpensesState,
        getExpensesState,
        deleteExpensesState,
        errorMessage,
      ];
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masareef_app/core/widgets/appbar/app_bar.dart';
import 'package:masareef_app/core/widgets/basic_app_button/basic_app_button.dart';
import 'package:masareef_app/expenses/domian/entities/inputs/expense_input.dart';
import 'package:masareef_app/expenses/presentation/manager/expense_cubit.dart';
import 'package:masareef_app/expenses/presentation/manager/expense_state.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  void _onAddExpensePressed() {
    _formKey.currentState!.save();
    final newExpense = ExpenseInput(
      id: DateTime.now().millisecondsSinceEpoch,
      title: _titleTextEditingController.text,
      amount: double.parse(_amountTextEditingController.text),
      date: DateTime.now(),
    );
    ExpenseCubit.of(context).addExpense(newExpense);
  }

  @override
  void dispose() {
    _titleTextEditingController.dispose();
    _amountTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 16),
        child: BlocListener<ExpenseCubit, ExpenseState>(
          listener: (context, state) {
            if (state.addExpensesState.isSuccess) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            } else if (state.addExpensesState.isFailure) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: Text(state.addExpensesState.errorMessage.toString()),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              );
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: _titleTextEditingController,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  controller: _amountTextEditingController,
                ),
                const SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: _onAddExpensePressed,
                //   child: const Text('Add Expense'),
                // ),
                BasicAppButton(
                  onPressed: _onAddExpensePressed,
                  title: "Add Expense",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

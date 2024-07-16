import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masareef_app/core/svg_icons/masareef_icons.dart';
import 'package:masareef_app/core/svg_icons/svg_icons.dart';
import 'package:masareef_app/core/theme/app_colors.dart';
import 'package:masareef_app/core/widgets/appbar/app_bar.dart';
import 'package:masareef_app/expenses/presentation/add_expense_page.dart';
import 'package:masareef_app/expenses/presentation/manager/expense_cubit.dart';
import 'package:masareef_app/expenses/presentation/manager/expense_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onDeletePress(int id) {
    ExpenseCubit.of(context).deleteExpense(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const BasicAppbar(
        hideBack: true,
        title: Text('Masareef App'),
      ),
      body: Stack(
        children: [
          BlocBuilder<ExpenseCubit, ExpenseState>(
            builder: (context, state) {
              final data = state.getExpensesState.data;
              if (data != null) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final expense = data[index];
                    return ListTile(
                      title: Text(
                        expense.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.dark,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        '${expense.amount} - ${expense.date.toLocal()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: AppColors.grey,
                          fontSize: 16,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.darkGrey,
                        ),
                        onPressed: () => _onDeletePress(expense.id),
                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<ExpenseCubit, ExpenseState>(
            builder: (context, state) {
              if (state.getExpensesState.isLoading ||
                  state.deleteExpensesState.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.getExpensesState.isFailure ||
                  state.deleteExpensesState.isFailure) {
                return const Center(child: Text('Failed to load expenses'));
              } else if (state.getExpensesState.data?.isEmpty ?? false) {
                return const Center(
                  child: SvgIcon(
                    height: 100,
                    width: 100,
                    iconName: MasareefIcons.moneyReciveSvg,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddExpensePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

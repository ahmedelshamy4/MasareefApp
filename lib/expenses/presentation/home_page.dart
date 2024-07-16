import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masareef_app/core/svg_icons/masareef_icons.dart';
import 'package:masareef_app/core/svg_icons/svg_icons.dart';
import 'package:masareef_app/core/theme/app_colors.dart';
import 'package:masareef_app/core/widgets/appbar/app_bar.dart';
import 'package:masareef_app/expenses/presentation/add_expense_page.dart';
import 'package:masareef_app/expenses/presentation/expense_details_page.dart';
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

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    ExpenseCubit.of(context).filterExpenses(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: BasicAppbar(
        hideBack: true,
        title: const Text('Masareef App'),
        action: [
          IconButton(
            onPressed: () {
              ExpenseCubit.of(context).sortExpensesByAmount();
              setState(() {});
            },
            icon: const Icon(Icons.sort_by_alpha),
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              ExpenseCubit.of(context).sortExpensesByDate();
              setState(() {});
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration:
                      const InputDecoration(labelText: 'Search Expenses'),
                  onChanged: (value) {
                    if(_searchController.text.isNotEmpty){
                      _onSearchChanged();
                    }else{
                      ExpenseCubit.of(context).getExpenses();
                    }
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: BlocBuilder<ExpenseCubit, ExpenseState>(
                    builder: (context, state) {
                      final data = state.getExpensesState.data;
                      if (data != null) {
                        return ListView.builder(
                          itemCount: data.length,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final expense = data[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExpenseDetailsPage(
                                      entity: expense,
                                    ),
                                  ),
                                );
                              },
                              behavior: HitTestBehavior.translucent,
                              child: ListTile(
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
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                )
              ],
            ),
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

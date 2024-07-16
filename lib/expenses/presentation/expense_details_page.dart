import 'package:flutter/material.dart';
import 'package:masareef_app/core/theme/app_colors.dart';
import 'package:masareef_app/core/widgets/appbar/app_bar.dart';
import 'package:masareef_app/expenses/domian/entities/expense_entity.dart';

class ExpenseDetailsPage extends StatelessWidget {
  final ExpenseEntity entity;

  const ExpenseDetailsPage({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: BasicAppbar(
        title: Text(
          entity.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.dark,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount: \$${entity.amount}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.dark,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Date: ${entity.date.toLocal()}',
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: AppColors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:equatable/equatable.dart';

class ExpenseInput extends Equatable {
  final int  id;
  final String title;
  final double amount;
  final DateTime date;

  const ExpenseInput({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  @override
  List<Object> get props => [
    id,
        title,
        amount,
        date,
      ];
}

import 'package:equatable/equatable.dart';

class ExpenseEntity extends Equatable {
  final int id;
  final String title;
  final double amount;
  final DateTime date;

  const ExpenseEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  factory ExpenseEntity.fromEntity(Map<String, dynamic> json) {
    return ExpenseEntity(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }
  @override
  List<Object> get props => [
        id,
        title,
        amount,
        date,
      ];
}

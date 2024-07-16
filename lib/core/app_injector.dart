import 'package:get_it/get_it.dart';
import 'package:masareef_app/expenses/di/expenses_di.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  await ExpensesDi.initialize();
}

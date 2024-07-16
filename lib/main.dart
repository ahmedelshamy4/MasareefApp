import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masareef_app/core/app_injector.dart';
import 'package:masareef_app/core/theme/app_colors.dart';
import 'package:masareef_app/core/theme/app_theme.dart';
import 'package:masareef_app/expenses/presentation/home_page.dart';
import 'package:masareef_app/expenses/presentation/manager/expense_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseCubit()..onCubitCreated(),
      child: MaterialApp(
        color: AppColors.white,
        title: 'Masareef App',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}

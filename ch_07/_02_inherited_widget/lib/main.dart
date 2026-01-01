import 'package:_02_inherited_widget/plan_provider.dart';
import 'package:flutter/material.dart';
import 'models/plan.dart';
import 'views/plan_screen.dart';

void main() => runApp(MasterPlanApp());

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master Plan',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: PlanProvider(
          notifier: ValueNotifier<Plan>(const Plan()),
          child: const PlanScreen(),
      ),
    );
  }
}

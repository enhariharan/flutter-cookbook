import 'package:_03_visible_app_state/plan_provider.dart';
import 'package:flutter/material.dart';
import 'models/plan.dart';
import 'views/plan_screen.dart';

void main() => runApp(MasterPlanApp());

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlanProvider(
        notifier: ValueNotifier<List<Plan>>(const []),
        child: MaterialApp(
          title: 'State management app',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const PlanScreen(),
        ),
    );
  }
}

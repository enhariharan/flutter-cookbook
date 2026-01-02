import 'package:flutter/material.dart';

import '../models/data_layer.dart';
import '../plan_provider.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;

  const PlanScreen({super.key, required this.plan});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController = ScrollController();

  Plan get plan => widget.plan;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: _buildAppBar(),
    body: _buildAppBody(context),
    floatingActionButton: _buildAddTaskButton(context),
  );

  ValueListenableBuilder<List<Plan>> _buildAppBody(BuildContext context) {
    return ValueListenableBuilder<List<Plan>>(
      valueListenable: PlanProvider.of(context),
      builder: (context, plan, child) {
        return Column(
          children: [
            Expanded(child: _buildList(plan)),
            SafeArea(child: Text(plan.completenessMessage)),
          ],
        );
      },
    );
  }

  AppBar _buildAppBar() => AppBar(title: const Text('Master Plan'));

  Widget _buildAddTaskButton(BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
    return FloatingActionButton(
      onPressed: () {
        Plan currentPlan = plan;
        int planIndex = planNotifier.value.indexWhere(
          (p) => p.name == currentPlan.name,
        );
        List<Task> updatedTasks = List<Task>.from(currentPlan.tasks)
          ..add(const Task());
        planNotifier.value = List<Plan>.from(planNotifier.value)
          ..[planIndex] = Plan(name: currentPlan.name, tasks: updatedTasks);
        plan = Plan(name: currentPlan.name, tasks: updatedTasks);
      },
      child: const Icon(Icons.add),
    );
  }

  Widget _buildList(Plan plan) => ListView.builder(
    controller: scrollController,
    keyboardDismissBehavior: Theme.of(context).platform == TargetPlatform.iOS
        ? ScrollViewKeyboardDismissBehavior.onDrag
        : ScrollViewKeyboardDismissBehavior.manual,
    itemCount: plan.tasks.length,
    itemBuilder: (context, index) =>
        _buildTaskTile(plan.tasks[index], index, context),
  );

  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
    return ListTile(
      leading: _buildTaskCheckbox(task, planNotifier, index),
      title: _buildTaskDescription(task, planNotifier, index),
    );
  }

  TextFormField _buildTaskDescription(
    Task task,
    ValueNotifier<List<Plan>> planNotifier,
    int index,
  ) {
    return TextFormField(
      initialValue: task.description,
      onChanged: (text) {
        Plan currentPlan = plan;
        int planIndex = planNotifier.value.indexWhere(
          (p) => p.name == currentPlan.name,
        );
        planNotifier.value = List<Plan>.from(planNotifier.value)
          ..[planIndex] = Plan(
            name: currentPlan.name,
            tasks: List<Task>.from(currentPlan.tasks)
              ..[index] = Task(isComplete: task.isComplete, description: text),
          );
      },
    );
  }

  Checkbox _buildTaskCheckbox(
    Task task,
    ValueNotifier<List<Plan>> planNotifier,
    int index,
  ) {
    return Checkbox(
      value: task.isComplete,
      onChanged: (selected) {
        Plan currentPlan = plan;
        int planIndex = planNotifier.value.indexWhere(
          (p) => p.name == currentPlan.name,
        );
        planNotifier.value = List<Plan>.from(planNotifier.value)
          ..[planIndex] = Plan(
            name: currentPlan.name,
            tasks: List<Task>.from(currentPlan.tasks)
              ..[index] = Task(
                isComplete: selected ?? false,
                description: task.description,
              ),
          );
      },
    );
  }
}

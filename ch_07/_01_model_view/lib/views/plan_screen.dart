import 'package:_01_model_view/models/data_layer.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  Plan _plan = const Plan();
  late ScrollController scrollController = ScrollController();

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
    body: _buildList(),
    floatingActionButton: _buildAddTaskButton(),
  );

  AppBar _buildAppBar() => AppBar(title: const Text('Master Plan'));

  Widget _buildAddTaskButton() => FloatingActionButton(
    onPressed: _onAddTaskButtonPressed,
    child: const Icon(Icons.add),
  );

  void _onAddTaskButtonPressed() => setState(() {
    _plan = Plan(
        name: _plan.name,
        tasks: List<Task>.from(_plan.tasks)
          ..add(const Task())
    );
  });

  Widget _buildList() => ListView.builder(
    controller: scrollController,
    keyboardDismissBehavior: Theme.of(context).platform == TargetPlatform.iOS
        ? ScrollViewKeyboardDismissBehavior.onDrag
        : ScrollViewKeyboardDismissBehavior.manual,
    itemCount: _plan.tasks.length,
    itemBuilder: (context, index) => _buildTaskTile(_plan.tasks[index], index),
  );

  Widget _buildTaskTile(Task task, int index) => ListTile(
    leading: Checkbox(
        value: task.isComplete,
        onChanged: (selected) {
          setState(() {
            _plan = Plan(
                name: _plan.name,
                tasks: List<Task>.from(_plan.tasks)
                  ..[index] = Task(
                    isComplete: selected ?? false,
                    description: task.description,
                  ),
            );
          });
        }
    ),
    title: TextFormField(
      initialValue: task.description,
      onChanged: (text) {
        setState(() {
          _plan = Plan(
              name: _plan.name,
              tasks: List<Task>.from(_plan.tasks)
                ..[index] = Task(
                  isComplete: task.isComplete,
                  description: text,
                ),
          );
        });
      },
    ),
  );
}

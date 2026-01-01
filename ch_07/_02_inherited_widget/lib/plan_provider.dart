import 'package:_02_inherited_widget/models/data_layer.dart';
import 'package:flutter/cupertino.dart';

class PlanProvider extends InheritedNotifier<ValueNotifier<Plan>> {
  const PlanProvider({super.key, required Widget child, required ValueNotifier<Plan> notifier})
      : super(child: child, notifier: notifier);
  static ValueNotifier<Plan> of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PlanProvider>()!.notifier!;
  }
}
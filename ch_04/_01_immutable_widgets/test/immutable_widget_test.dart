import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:_01_immutable_widgets/immutable_widget.dart';

void main() {
  group('ImmutableWidget Tests', () {
    testWidgets('should render ImmutableWidget with correct structure', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ImmutableWidget(),
          ),
        ),
      );

      // Check for the presence of ImmutableWidget
      expect(find.byType(ImmutableWidget), findsOneWidget);

      // Check for the presence of BlueContainer
      expect(find.byType(BlueContainer), findsOneWidget);

      // Verify colors by looking at Containers
      final containers = find.byType(Container);
      
      // Based on the code, there are 4 Containers:
      // 1. Green container in ImmutableWidget
      // 2. Container with padding 50.0 in ImmutableWidget
      // 3. Red container in ImmutableWidget
      // 4. Blue container in BlueContainer
      expect(containers, findsNWidgets(4));

      // Verify the existence of specific colors
      final greenContainer = tester.widget<Container>(
        find.descendant(
          of: find.byType(ImmutableWidget),
          matching: find.byWidgetPredicate((widget) => widget is Container && widget.color == Colors.green),
        ),
      );
      expect(greenContainer.color, Colors.green);

      final redContainer = tester.widget<Container>(
        find.descendant(
          of: find.byType(ImmutableWidget),
          matching: find.byWidgetPredicate((widget) => widget is Container && widget.color == Colors.red),
        ),
      );
      expect(redContainer.color, Colors.red);

      final blueContainer = tester.widget<Container>(
        find.descendant(
          of: find.byType(BlueContainer),
          matching: find.byType(Container),
        ),
      );
      expect(blueContainer.color, Colors.blue);
    });
  });
}

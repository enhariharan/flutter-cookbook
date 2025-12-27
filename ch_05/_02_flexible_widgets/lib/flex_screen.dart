import 'package:_02_flexible_widgets/labeled_container.dart';
import 'package:flutter/material.dart';

class FlexScreen extends StatelessWidget {
  const FlexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flexible and Expanded'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ..._header(context, "Expanded"),
            const DemoExpanded(),
            ..._header(context, "Flexible"),
            const DemoFlexible(),
            const Expanded(child: Spacer()),
            const DemoFooter(),
          ],
        ),
      )
    );
  }

Iterable<Widget> _header(BuildContext context, String text) {
    return [
      const SizedBox(height: 20,),
      Text(text, style: Theme.of(context).textTheme.headlineSmall),
    ];
  }
}

class DemoExpanded extends StatelessWidget {
  const DemoExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: const [
          LabeledContainer(
            width: 100,
            color: Colors.green,
            text: '100',
          ),
          Expanded(
            child: LabeledContainer(
              color: Colors.purple,
              text: 'The remainder',
              textColor: Colors.white,
            ),
          ),
          LabeledContainer(
            width: 40,
            color: Colors.green,
            text: '40',
          )
        ],
      ),
    );
  }
}

class DemoFlexible extends StatelessWidget {
  const DemoFlexible({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: const [
          Flexible(
            flex: 1,
            child: LabeledContainer(text: '25%', color: Colors.orange,),
          ),
          Flexible(
            flex: 1,
            child: LabeledContainer(text: '25%', color: Colors.deepOrange,),
          ),
          Flexible(
            flex: 2,
            child: LabeledContainer(text: '50%', color: Colors.blue,),
          ),
        ],
      ),
    );
  }
}

class DemoFooter extends StatelessWidget {
  const DemoFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(40),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 30.0,
        ),
        child: Text(
          'Pinned to the bottom',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}

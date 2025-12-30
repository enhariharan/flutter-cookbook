import 'dart:async';

import 'package:flutter/material.dart';
import 'platform_alert.dart';

class MyStopWatch extends StatefulWidget {
  final String name;
  final String email;

  const MyStopWatch({super.key, required this.name, required this.email});

  @override
  State<MyStopWatch> createState() => _MyStopWatchState();
}

class _MyStopWatchState extends State<MyStopWatch> {
  int milliseconds = 0;
  Timer? timer;
  bool isTicking = false;
  final laps = <int>[];
  final itemHeight = 60.0;
  final scrollController = ScrollController();

  void _startTimer() {
    setState( () {
      timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);
      milliseconds = 0;
      isTicking = true;
      laps.clear();
    });
  }

  void _stopTimer(BuildContext context) {
    timer?.cancel();
    setState(() => isTicking = false);
    final controller = showBottomSheet(
        context: context,
        builder: _buildRunCompleteSheet,
    );
    Future.delayed(const Duration(seconds: 5)).then((_) => controller.close());
  }

  Widget _buildRunCompleteSheet(BuildContext context) {
    final totalRuntime = laps.fold(milliseconds, (total, lap) => total + lap);
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Container(
          color: Theme.of(context).cardColor,
          width: double.infinity,
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 30.0
              ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'Run finished!',
                  style: textTheme.headlineSmall,
                ),
                Text(
                  'Total runtime is ${_secondsText(totalRuntime)}'
                )
              ],
            ),
          ),
        ),
    );
  }

  void _onTick(Timer time) {
    if (mounted) {
      setState(() => milliseconds += 100);
    }
  }

  void _lap() {
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });
    scrollController.animateTo(
      itemHeight * laps.length,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          Expanded(child: _buildCounter(context)),
          Expanded(child: _buildLapDisplay(context)),
        ],
      ),
    );
  }

  Widget _buildLapDisplay(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        controller: scrollController,
        itemExtent: itemHeight,
        itemCount: laps.length,
        itemBuilder: (context, index) {
          final milliseconds = laps[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 50),
            title: Text('Lap ${index + 1}'),
            trailing: Text(_secondsText(milliseconds)),
          );
        },
      ),
    );
  }

  Widget _buildCounter(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Lap ${laps.length + 1}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
          ),
          Text(
            _secondsText(milliseconds),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 20,),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildStartButton(),
            const SizedBox(width: 20,),
            _buildStopButton(),
            const SizedBox(width: 20,),
            _buildLapButton(),
            const SizedBox(width: 20,),
          ],
        );
  }

  Widget _buildLapButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      ),
      onPressed: isTicking ? _lap : null,
      child: const Text('Lap'),
    );
  }

  Widget _buildStopButton() {
    return Builder(
      builder: (context) {
        return TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: isTicking ? () => _stopTimer(context) : null,
                child: const Text('Stop'),
              );
      }
    );
  }

  Widget _buildStartButton() {
    return ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: isTicking ? null : _startTimer,
            child: const Text('Start'),
          );
  }

  String _secondsText(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }
}

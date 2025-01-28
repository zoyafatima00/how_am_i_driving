import 'package:flutter/material.dart';

class TestingWidget extends StatefulWidget {
  const TestingWidget({super.key});

  @override
  State<TestingWidget> createState() => _TestingWidgetState();
}

class _TestingWidgetState extends State<TestingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Testing Widget'),
      ),
    );
  }
}

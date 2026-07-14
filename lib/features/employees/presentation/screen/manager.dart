import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Manager extends StatelessWidget {
  const Manager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Manager',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      )
    );
  }
}
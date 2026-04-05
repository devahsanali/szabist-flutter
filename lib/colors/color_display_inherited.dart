import 'package:flutter/material.dart';
import 'color_state.dart';

class ColorDisplayInherited extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = ColorState.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("Color Display (Inherited)")),
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          color: state.color,
        ),
      ),
    );
  }
}
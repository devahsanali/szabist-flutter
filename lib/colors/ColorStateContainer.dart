import 'package:flutter/material.dart';
import 'color_state.dart';
import '../main.dart';

class ColorStateContainer extends StatefulWidget {
  @override
  _ColorStateContainerState createState() => _ColorStateContainerState();
}

class _ColorStateContainerState extends State<ColorStateContainer> {
  Color color = Colors.red;

  void changeColor(Color newColor) {
    setState(() {
      color = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColorState(
      color: color,
      changeColor: changeColor,
      child: MyApp(),
    );
  }
}
import 'package:flutter/material.dart';

class ColorState extends InheritedWidget {
  final Color color;
  final Function(Color) changeColor;

  ColorState({
    required this.color,
    required this.changeColor,
    required Widget child,
  }) : super(child: child);

  static ColorState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ColorState>()!;
  }

  @override
  bool updateShouldNotify(ColorState oldWidget) {
    return color != oldWidget.color;
  }
}
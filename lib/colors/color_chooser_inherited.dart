import 'package:flutter/material.dart';
import 'color_state.dart';
import 'color_display_inherited.dart';

class ColorChooserInherited extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = ColorState.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("Color Chooser (Inherited)")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Choose a color:"),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => state?.changeColor(Colors.red),
                  child: Text("Red"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () => state?.changeColor(Colors.green),
                  child: Text("Green"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () => state?.changeColor(Colors.blue),
                  child: Text("Blue"),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ColorDisplayInherited(),
                  ),
                );
              },
              child: Text("Go to Display Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
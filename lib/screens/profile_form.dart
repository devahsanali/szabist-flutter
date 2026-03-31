import 'package:flutter/material.dart';
import '../main_scaffold.dart';
class ProfileForm extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 3,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),

            TextField(
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(labelText: "Date"),
              onTap: () async {
                // DateTime today = DateTime.now();
                // DateTime yesterday = today.subtract(Duration(days: 1));
                // DateTime tomorrow = today.add(Duration(days: 1));
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (picked != null) {
                  dateController.text = picked.toString();
                }
              },
            ),

            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
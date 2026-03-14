import 'package:flutter/material.dart';

class CompleteForm extends StatefulWidget {
  @override
  _CompleteFormState createState() => _CompleteFormState();
}

class _CompleteFormState extends State<CompleteForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _commentsController = TextEditingController();
  bool _isSubscribed = false;
  String _gender = 'Male';
  bool _notifications = true;
  String? _country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Complete Form Example')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter your name' : null,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: _isSubscribed,
                      onChanged: (value) => setState(() => _isSubscribed = value!),
                    ),
                    Text('Subscribe to newsletter'),
                  ],
                ),
                SizedBox(height: 20),
                Text('Gender:'),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: _gender,
                      onChanged: (value) => setState(() => _gender = value!),
                    ),
                    Text('Male'),
                    Radio<String>(
                      value: 'Female',
                      groupValue: _gender,
                      onChanged: (value) => setState(() => _gender = value!),
                    ),
                    Text('Female'),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Enable Notifications'),
                    Switch(
                      value: _notifications,
                      onChanged: (value) => setState(() => _notifications = value),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  initialValue: _country,
                  hint: Text('Select Country'),
                  items: ['USA', 'India', 'UK', 'Canada']
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (value) => setState(() => _country = value),
                  validator: (value) => value == null ? 'Please select a country' : null,
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _commentsController,
                  decoration: InputDecoration(
                    labelText: 'Comments',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 5,
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter some comments' : null,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Name: ${_nameController.text}, Subscribed: $_isSubscribed, Gender: $_gender, Notifications: $_notifications, Country: $_country'),
                        ));
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
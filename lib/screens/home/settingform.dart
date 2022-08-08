import 'package:coffeeapp/models/user.dart';
import 'package:coffeeapp/services/database.dart';
import 'package:coffeeapp/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  // form values
  String? _currentName;
  int? _currentStrength;
  String? _currentSugars;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Profile>(context);

    return StreamBuilder<Profiledata>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Profiledata? profildata = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your Preferences.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: profildata?.name,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    value: _currentSugars ?? profildata?.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentSugars = val.toString()),
                  ),
                  SizedBox(height: 10.0),
                  Slider(
                    value: (_currentStrength ?? profildata?.strength)
                            ?.toDouble() ??
                        0,
                    activeColor: Colors.brown[
                        _currentStrength ?? profildata?.strength?.toInt() ?? 0],
                    inactiveColor: Colors.brown[
                        _currentStrength ?? profildata?.strength?.toInt() ?? 0],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? profildata!.sugars.toString(),
                              _currentName ?? profildata!.name.toString(),
                              _currentStrength ??
                                  profildata!.strength!.toInt());
                          Navigator.pop(context);
                        }
                        // print(_currentName);
                        // print(_currentSugars);
                        // print(_currentStrength);
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

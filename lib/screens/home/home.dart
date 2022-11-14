import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeapp/models/user.dart';
import 'package:coffeeapp/screens/home/coffeelist.dart';
import 'package:coffeeapp/screens/home/settingform.dart';
import 'package:coffeeapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:coffeeapp/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:coffeeapp/models/coffee.dart';

class Home extends StatefulWidget {
  final String? userid;
  final String? name;

  const Home(Profile user, {super.key, this.userid, this.name});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Profile?>(context);
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Coffee>>.value(
      value: DatabaseService().coffee,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('${user?.email}'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            ElevatedButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: CoffeeList()),
      ),
    );
  }
}

import 'package:coffeeapp/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Specific Coffee :-)'),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: new InputDecoration.collapsed(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: new InputDecoration.collapsed(hintText: 'Password'),
                obscureText: true,
                validator: (val) =>
                    val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    // print(email);
                    // print(password);
                    if (_formKey.currentState!.validate()) {
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Could not sign in with those credentials';
                        });
                      }
                    }
                  }),
              ElevatedButton(
                child: Text('sign in anonymous'),
                onPressed: () async {
                  dynamic result = await _auth.signInAnon();
                  if (result == null) {
                    print("error signing in");
                  } else {
                    print("signed in");
                    print(result.uid);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
    // Scaffold(
    //   backgroundColor: Colors.brown[100],
    //   appBar: AppBar(
    //     backgroundColor: Colors.brown[400],
    //     elevation: 0.0,
    //     title: Text('Sign in to Specific Coffee :-)'),
    //   ),
    //   body: Container(
    //     padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
    //     child: ElevatedButton(
    //       child: Text('sign in anond'),
    //       onPressed: () async {
    //         dynamic result = await _auth.signInAnon();
    //         if (result == null) {
    //           print("error signing in");
    //         } else {
    //           print("signed in");
    //           print(result.uid);
    //         }
    //       },
    //     ),
    //   ),
    // );
  }
}

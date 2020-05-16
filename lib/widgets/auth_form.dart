import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    child: Text('Login'),
                    onPressed: () {},
                  ),
                  RaisedButton(
                    child: Text('Create New Account'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

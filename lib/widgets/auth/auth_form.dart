import 'package:chat_app/widgets/pickers/user_imagge_pickers.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  final Future<void> Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  final bool isLoading;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _email = '';
  var _username = '';
  var _password = '';

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      _formKey.currentState.save();
      widget.submitFn(
        _email.trim(),
        _password.trim(),
        _username.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) UserImagePicker(),
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                    onSaved: (value) => _email = value,
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Please enter email.';
                      else if (!value.contains('@'))
                        return 'Please enter a valid email address.';
                      else
                        return null;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (value) => _username = value,
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Please enter username';
                        else if (value.length < 4)
                          return 'Please enter 4 characters.';
                        else
                          return null;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) => _password = value,
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Please enter password';
                      else if (value.length < 7)
                        return 'Please enter a password greater than 7 characters';
                      else
                        return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                      onPressed: _submitForm,
                    ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      _isLogin
                          ? 'Create New Account'
                          : 'I already have an account',
                    ),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
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

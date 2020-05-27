import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:chat_app/widgets/auth/auth_form.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  Future<void> _authenticateUser(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    var auth = FirebaseAuth.instance;
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData(
          {
            'username': username,
            'email': email,
          },
        );
      }
    } on PlatformException catch (err) {
      var errMessage = 'Something went wronge, Pleas try again';

      if (err.message != null) {
        errMessage = err.message;
      }
      setState(() {
        _isLoading = false;
      });
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(errMessage),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _authenticateUser,
        _isLoading,
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  NewMessage({Key key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _messageText = '';
  final _controllar = TextEditingController();

  void _sendMessage() async {
    var user = await FirebaseAuth.instance.currentUser();
    var userData =
        await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('chat').add(
      {
        'text': _messageText,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
        'username': userData['username'],
        'userImage': userData['user_image']
      },
    );
    _controllar.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controllar,
              decoration: InputDecoration(labelText: 'Send new message...'),
              onChanged: (value) {
                setState(() {
                  _messageText = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: _messageText.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}

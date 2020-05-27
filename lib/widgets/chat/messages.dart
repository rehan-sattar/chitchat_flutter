import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        var documents = streamSnapshot.data.documents;
        return ListView.builder(
          reverse: true,
          itemCount: documents.length,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: Text(documents[index]['text']),
            );
          },
        );
      },
    );
  }
}

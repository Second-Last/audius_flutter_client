import 'package:flutter/material.dart';

class Library extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Icon(
              Icons.library_books,
              size: 200,
            ),
            Text('Library')
          ],
        ),
      ),
    );
  }
}

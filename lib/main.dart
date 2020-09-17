import 'package:flutter/material.dart';

import 'package:Photo/pages/home_page.dart';

void main() => runApp(Gallery());

class Gallery extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:Photo/models/AppConfig.dart';
import 'package:Photo/models/Photo.dart';
import 'package:Photo/widgets/post_card.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePageState2 createState() => _HomePageState2();
}

class _HomePageState2 extends State<HomePage2> {
  AppConfig config;
  int page = 1;
  ListPhotos photos = ListPhotos();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    AppConfig.forEnvironment().then((value) {
      config = value;
      getPhotos();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        getPhotos();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Color(0xff30475e);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: backgroundColor,
      ),
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (context, index) {
            return PostCard(index, photos.photos[index]);
          },
          itemCount: photos.photos.length,
        ),
      ),
    );
  }

  getPhotos() async {
    final url =
        '${config.apiUrl}photos/?client_id=${config.clientId}&page=$page';
    final response = await http.get(url);

    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        page++;
        photos.fromResponse(response);
      });
    }
  }
}

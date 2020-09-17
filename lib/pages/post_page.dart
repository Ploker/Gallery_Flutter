import 'package:Photo/models/Photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostPage extends StatelessWidget {
  final int id;
  final Photo photo;
  PostPage(this.id, this.photo);

  @override
  Widget build(BuildContext context) {
    bool _isFullScrean = false;

    _toggleFullScrean() {
      _isFullScrean = !_isFullScrean;

      SystemChrome.setEnabledSystemUIOverlays(
          _isFullScrean ? SystemUiOverlay.values : []);
    }

    _changeNavigationBarColor([Color color]) {
      color ??= Color(0xff30475e);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: color,
        ),
      );
    }

    _changeNavigationBarColor(photo.color);

    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: InkWell(
          onTap: () {
            _toggleFullScrean();
          },
          child: Ink(
            color: Color(0xff222831),
            child: Hero(
              tag: id,
              child: FadeInImage(
                image: NetworkImage(photo.imgFull),
                placeholder: NetworkImage(photo.imgSmall),
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        !_isFullScrean ? _toggleFullScrean() : null;
        _changeNavigationBarColor();

        return true;
      },
    );
  }
}

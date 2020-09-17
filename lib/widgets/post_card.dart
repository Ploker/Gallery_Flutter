import 'package:flutter/material.dart';

import 'package:Photo/models/Photo.dart';
import 'package:Photo/pages/post_page.dart';

class PostCard extends StatelessWidget {
  final int index;
  final Photo photo;
  PostCard(this.index, this.photo);

  @override
  Widget build(BuildContext context) {
    String defaultImageUrl = 'https://getdrawings.com/free-icon-bw/slideshow-icon-10.png';
    Color darkBlue = Color(0xff222831);
    BoxShadow boxShadow = BoxShadow(
      color: Colors.black,
      spreadRadius: 0,
      blurRadius: 15,
      offset: Offset(-3, 6),
    );


    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PostPage(index, photo),
        ));
      },
      child: Container(
        width: double.infinity,
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        padding: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          color: darkBlue,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Positioned(
              top: -35,
              left: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(),
                child: Text(
                  photo.description != null && photo.description.isNotEmpty
                      ? photo.description
                      : 'empty :(',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  maxLines: 1,
                ),
              ),
            ),
            Positioned.fill(
              child: Hero(
                tag: index,
                child: Container(
                   margin:
                    const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xff222831),
                    boxShadow: [boxShadow],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        photo.imgSmall.isNotEmpty
                            ? photo.imgSmall
                            : defaultImageUrl,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -15,
              right: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                decoration: BoxDecoration(
                  color: photo.color ?? darkBlue,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [boxShadow],
                ),
                child: Text(
                  photo.authorName.isNotEmpty ? photo.authorName : '',
                  style: TextStyle(color: photo.color.computeLuminance() < 0.5 ? Colors.white : Colors.black, fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

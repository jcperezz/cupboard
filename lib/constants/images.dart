import 'package:flutter/cupertino.dart';

class MyImages {
  static const Map<String, List<Color>> cupboard_images = {
    "cupboard-01.png": [Color(0xffB2B24E), Color(0xffD4D4B1)],
    "cupboard-02.png": [Color(0xff473B7B), Color(0xff30D1BE)],
    "cupboard-03.png": [Color(0xff304352), Color(0xffd7d2cc)],
    "cupboard-04.png": [Color(0xff616161), Color(0xff9bc5c3)],
    "cupboard-05.png": [Color(0xff243949), Color(0xff517fa4)],
  };

  static const ImageProvider<Object> empty_image =
      AssetImage("assets/img/empty.png");
}

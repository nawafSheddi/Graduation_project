import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      width: double.infinity,
      height: 200,
      initialPage: 0,
      indicatorColor: Colors.white,
      indicatorBackgroundColor: Colors.grey,
      // onPageChanged: (value) {
      //   print('Page changed: $value');
      // },
      autoPlayInterval: 4000,
      isLoop: true,
      children: [
        Image.asset(
          'assets/images/banner/1.jpeg',
          fit: BoxFit.cover,
        ),
        Image.asset(
          'assets/images/banner/2.jpg',
          fit: BoxFit.cover,
        ),
        Image.asset(
          'assets/images/banner/3.jpg',
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}

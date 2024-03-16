import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LabeledAnimation {
  static String BASE_PATH = "assets/animations/home";

  String imageName;

  double width;
  double height;
  double bottomPosition;

  LabeledAnimation(this.imageName, this.width, this.height, this.bottomPosition);
  
  LottieBuilder getLottieAsset() => Lottie.asset(
    "$BASE_PATH/$imageName.json", width: width, height: height, repeat: true,
  );

  Widget getLabel(String label) => Positioned(
    bottom: bottomPosition, // Adjust as necessary to move text closer to the star
    child: Text(
      label,
      style: const TextStyle(color: Colors.white, fontSize: 24),
      textAlign: TextAlign.center,
    ),
  );

  Widget toWidget(String label) => Stack(
    alignment: Alignment.topCenter,
    clipBehavior: Clip.none, // Allows the text to be positioned outside the stack
    children: <Widget>[
      getLottieAsset(),
      getLabel(label)
    ]
  );
}

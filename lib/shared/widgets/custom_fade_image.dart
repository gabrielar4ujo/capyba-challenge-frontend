import 'package:flutter/material.dart';

class CustomFadeImage extends StatelessWidget {
  final String url;
  const CustomFadeImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      image: url,
      fit: BoxFit.cover,
      placeholder: "assets/gifs/loading.gif",
    );
  }
}

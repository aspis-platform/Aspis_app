import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final bool isFit;
  final double? width;
  final double? height;
  const Logo({super.key, this.width, this.height, this.isFit = true});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/logo${isFit ? '_fit' : ''}.png', width: width, height: height);
  }
}

import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/animations/lottie_animation.dart';
import 'package:lottie/lottie.dart';

class LottieAnilationView extends StatelessWidget {
  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;

  const LottieAnilationView({
    super.key,
    required this.animation,
    this.repeat = true,
    this.reverse = false
  });

  @override
  Widget build(BuildContext context) => Lottie.asset(
        animation.fullPath,
        repeat: repeat,
        reverse: reverse,
      );
}

extension GetFullPath on LottieAnimation {
  String get fullPath => 'assets/animations/$name.json';
}


import 'package:instagram_clone/views/components/animations/lottie_animation.dart';
import 'package:instagram_clone/views/components/animations/lottie_animation_view.dart';

class EmptyContentAnimationView extends LottieAnilationView {
  const EmptyContentAnimationView({
    super.key
  }): super(
    animation: LottieAnimation.empty,
  );
}
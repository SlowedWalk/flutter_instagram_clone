import 'package:instagram_clone/views/components/animations/lottie_animation.dart';
import 'package:instagram_clone/views/components/animations/lottie_animation_view.dart';

class ErrorAnimationView extends LottieAnilationView {
  const ErrorAnimationView({
    super.key
  }): super(
    animation: LottieAnimation.error,
  );
}
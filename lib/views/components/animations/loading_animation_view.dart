import 'package:instagram_clone/views/components/animations/lottie_animation.dart';
import 'package:instagram_clone/views/components/animations/lottie_animation_view.dart';

class LoadingAnimationView extends LottieAnilationView {
  const LoadingAnimationView({
    super.key
  }): super(
    animation: LottieAnimation.lodaing,
  );
}
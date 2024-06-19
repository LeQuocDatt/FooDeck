import 'package:rive/rive.dart';
import 'package:template/source/export.dart';

class CustomFallAnimationRive extends StatefulWidget {
  const CustomFallAnimationRive({super.key});

  @override
  State<CustomFallAnimationRive> createState() =>
      _CustomFallAnimationRiveState();
}

class _CustomFallAnimationRiveState extends State<CustomFallAnimationRive> {
  late RiveAnimationController loadingAnimationController;

  @override
  void initState() {
    loadingAnimationController =
        OneShotAnimation('Animation 1', autoplay: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RiveAnimation.asset(
          fit: BoxFit.cover,
          'assets/rives/3d_raster_test.riv',
          controllers: [loadingAnimationController]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingAnimationRive extends StatefulWidget {
  const LoadingAnimationRive({super.key, this.color});

  final Color? color;

  @override
  State<LoadingAnimationRive> createState() => _LoadingAnimationRiveState();
}

class _LoadingAnimationRiveState extends State<LoadingAnimationRive> {
  late RiveAnimationController loadingAnimationController;

  @override
  void initState() {
    loadingAnimationController = SimpleAnimation('Idle', autoplay: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color ?? Colors.white,
      child: RiveAnimation.asset(
        'assets/rives/loading_animation.riv',
        controllers: [loadingAnimationController],
      ),
    );
  }
}

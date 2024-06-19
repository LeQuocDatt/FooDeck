import 'package:template/source/export.dart';

part 'splash_page_extension.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    context
        .read<SplashPageBloc>()
        .add(SplashPageInitialEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashPageBloc, SplashPageState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case SplashLoadingAnimationState:
            final success = state as SplashLoadingAnimationState;
            return SplashPageAnimation(
                animationFirstAndLast: success.animationFirstAndLast,
                animation2: success.animation2);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

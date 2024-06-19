part of 'splash_page.dart';

class SplashPageAnimation extends StatelessWidget {
  const SplashPageAnimation({
    super.key,
    required this.animationFirstAndLast,
    required this.animation2,
  });

  final bool animationFirstAndLast;
  final bool animation2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 1500),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: animationFirstAndLast
                    ? null
                    : const DecorationImage(
                        image: AssetImage(Assets.splashScreen),
                        fit: BoxFit.cover)),
          ),
          Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 168.33, bottom: 18.33),
              child: AnimatedScale(
                  scale: animationFirstAndLast ? 0 : 1,
                  duration: const Duration(milliseconds: 1500),
                  child: AnimatedOpacity(
                      opacity: animationFirstAndLast ? 0 : 1,
                      duration: const Duration(milliseconds: 1500),
                      child: AnimatedRotation(
                          turns: animationFirstAndLast ? 0 : 1,
                          duration: const Duration(milliseconds: 1500),
                          child: Image.asset(Assets.foodDeck)))),
            ),
            AnimatedAlign(
                duration: const Duration(milliseconds: 1500),
                alignment: animationFirstAndLast
                    ? Alignment.centerLeft
                    : Alignment.center,
                child: AnimatedOpacity(
                    opacity: animationFirstAndLast ? 0 : 1,
                    duration: const Duration(milliseconds: 1500),
                    child: const CustomText(
                        content: 'Foodeck',
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: AnimatedOpacity(
                  opacity: animation2 ? 0 : 1,
                  duration: const Duration(milliseconds: 1500),
                  child: const WaveDots(size: 36, color: Colors.white)),
            )
          ]),
          Padding(
            padding: const EdgeInsets.only(top: 387),
            child: AnimatedAlign(
                duration: const Duration(milliseconds: 1500),
                alignment: animationFirstAndLast
                    ? Alignment.bottomCenter
                    : Alignment.topCenter,
                child: AnimatedOpacity(
                    opacity: animationFirstAndLast ? 0 : 1,
                    duration: const Duration(milliseconds: 1500),
                    child: const CustomText(
                        content:
                            'Aliquam commodo tortor lacinia lorem\naccumsan aliquam',
                        textAlign: TextAlign.center,
                        color: Colors.white))),
          ),
        ],
      ),
    );
  }
}

import 'package:rive/rive.dart';
import 'package:template/source/export.dart';

class RiveAnimations {
  static Widget addToCartAnimation() {
    return SizedBox(
      height: 70,
      width: 300,
      child: RiveAnimation.asset(
        alignment: Alignment.bottomCenter,
        fit: BoxFit.cover,
        RiveUtils.addToCartModel.src,
        artboard: RiveUtils.addToCartModel.artBoard,
        onInit: (artBoard) {
          RiveUtils.addToCartModel.statusTrigger = RiveUtils.getRiveTrigger(
              artBoard, RiveUtils.addToCartModel.action,
              stateMachineName: RiveUtils.addToCartModel.stateMachineName);
        },
      ),
    );
  }

  static Widget reviewAnimation() {
    return SizedBox(
      height: 100,
      child: RiveAnimation.asset(
        fit: BoxFit.cover,
        RiveUtils.reviewModel.src,
        artboard: RiveUtils.reviewModel.artBoard,
        onInit: (artBoard) {
          RiveUtils.reviewModel.statusTrigger = RiveUtils.getRiveTrigger(
              artBoard, RiveUtils.reviewModel.action,
              stateMachineName: RiveUtils.reviewModel.stateMachineName);
        },
      ),
    );
  }

  static Widget pigeonAnimation() {
    return GestureDetector(
        onTap: () {
          RiveUtils.changeSMITriggerState(RiveUtils.pigeonModel.statusTrigger!);
        },
        child: RiveAnimation.asset(
          fit: BoxFit.cover,
          RiveUtils.pigeonModel.src,
          artboard: RiveUtils.pigeonModel.artBoard,
          onInit: (artBoard) {
            RiveUtils.pigeonModel.statusTrigger = RiveUtils.getRiveTrigger(
                artBoard, RiveUtils.pigeonModel.action,
                stateMachineName: RiveUtils.pigeonModel.stateMachineName);
          },
        ));
  }

  static Widget logOutAnimation() {
    return SizedBox(
      height: 36,
      width: 36,
      child: RiveAnimation.asset(
        fit: BoxFit.cover,
        RiveUtils.logOut.src,
        artboard: RiveUtils.logOut.artBoard,
        onInit: (artBoard) {
          RiveUtils.logOut.statusTrigger = RiveUtils.getRiveTrigger(
              artBoard, RiveUtils.logOut.action,
              stateMachineName: RiveUtils.logOut.stateMachineName);
        },
      ),
    );
  }

  static Widget lightOrDarkAnimation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
              flex: 3, child: CustomText(content: 'Switch Light & Dark Mode')),
          Expanded(
            child: SizedBox(
              height: 30,
              child: GestureDetector(
                  onTap: () {
                    RiveUtils.changeSMIBoolState(
                        RiveUtils.lightOrDarkModel.statusBool!);
                    ThemeProvider.toggleTheme();
                  },
                  child: RiveAnimation.asset(
                    fit: BoxFit.cover,
                    RiveUtils.lightOrDarkModel.src,
                    artboard: RiveUtils.lightOrDarkModel.artBoard,
                    onInit: (artBoard) {
                      RiveUtils.lightOrDarkModel.statusBool =
                          RiveUtils.getRiveBool(
                              artBoard, RiveUtils.lightOrDarkModel.action,
                              stateMachineName:
                                  RiveUtils.lightOrDarkModel.stateMachineName);
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }

  static Widget bottomAnimation(int currentIndex, int index) {
    return SizedBox(
      height: 36,
      width: 36,
      child: Opacity(
        opacity: currentIndex == index ? 1 : 0.5,
        child: RiveAnimation.asset(
          RiveUtils.bottomModel[index].src,
          artboard: RiveUtils.bottomModel[index].artBoard,
          onInit: (artBoard) {
            RiveUtils.bottomModel[index].statusTrigger =
                RiveUtils.getRiveTrigger(
                    artBoard, RiveUtils.bottomModel[index].action,
                    stateMachineName:
                        RiveUtils.bottomModel[index].stateMachineName);
          },
        ),
      ),
    );
  }

  static Widget profileAnimation(RiveModel index) {
    return SizedBox(
      height: 36,
      width: 36,
      child: RiveAnimation.asset(
        fit: BoxFit.cover,
        index.src,
        artboard: index.artBoard,
        onInit: (artBoard) {
          index.statusTrigger = RiveUtils.getRiveTrigger(artBoard, index.action,
              stateMachineName: index.stateMachineName);
        },
      ),
    );
  }
}

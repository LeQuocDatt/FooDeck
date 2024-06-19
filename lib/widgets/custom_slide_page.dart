import 'package:template/source/export.dart';

class CustomSlidePage extends StatefulWidget {
  const CustomSlidePage(
      {super.key, this.itemCount, required this.itemBuilder, this.currentCard});
  final ValueNotifier<int>? currentCard;
  final int? itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  @override
  State<CustomSlidePage> createState() => _CustomSlidePageState();
}

class _CustomSlidePageState extends State<CustomSlidePage> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.95);

  int cardIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: pageController,
        onPageChanged: (value) {
          if (widget.currentCard != null) {
            widget.currentCard!.value = value;
          } else {
            cardIndex = value;
          }
        },
        scrollBehavior: const ScrollBehavior(),
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder);
  }
}

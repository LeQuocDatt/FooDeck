import 'package:template/source/export.dart';

class ListSlideBanner extends StatefulWidget {
  const ListSlideBanner({super.key});

  @override
  State<ListSlideBanner> createState() => _ListSlideBannerState();
}

class _ListSlideBannerState extends State<ListSlideBanner> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.9);
  final currentCard = ValueNotifier(0);

  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        if (currentCard.value == slideBanner.length - 1) {
          currentCard.value = 0;
        } else {
          currentCard.value = currentCard.value + 1;
        }
        pageController.animateToPage(
          currentCard.value,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        customSnackBar(context, Toast.error, 'In Updating...');
      },
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 170,
            child: PageView.builder(
              onPageChanged: (value) {
                currentCard.value = value;
              },
              controller: pageController,
              clipBehavior: Clip.none,
              itemCount: slideBanner.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 170,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                    image: AssetImage(
                                        slideBanner[index].foodBanner),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        slideBanner[index].content
                      ]),
                );
              },
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: currentCard,
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.only(left: 175),
              child: Row(
                children: List<Widget>.generate(
                  3,
                  (indexSlide) => AnimatedContainer(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: indexSlide == value
                            ? AppColor.globalPink
                            : Colors.white,
                        border: indexSlide == value
                            ? null
                            : Border.all(color: Colors.grey)),
                    duration: const Duration(milliseconds: 350),
                  ),
                ),
              ),
            );
          },
        )
      ]),
    );
  }
}

import 'package:template/source/export.dart';

class MyReviews extends StatefulWidget {
  const MyReviews({super.key});

  @override
  State<MyReviews> createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  PageController pageController = PageController(initialPage: 0);
  final currentCard = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: dataReview,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingAnimationRive();
          }
          return Scaffold(
            appBar: AppBar(
                shape: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 8, color: AppColor.dividerGrey)),
                title: CustomText(
                    content: 'My Reviews (${snapshot.data!.length})',
                    fontWeight: FontWeight.bold)),
            body: snapshot.data!.isEmpty
                ? Stack(
                    children: [
                      const Center(child: CustomText(content: 'No review')),
                      RiveAnimations.pigeonAnimation()
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Expanded(
                            child: PageView.builder(
                                scrollBehavior: const ScrollBehavior(),
                                onPageChanged: (value) {
                                  currentCard.value = value;
                                },
                                controller: pageController,
                                clipBehavior: Clip.none,
                                itemCount: snapshot.data!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    Column(
                                      children: [
                                        BannerItems(
                                          paddingImage:
                                              const EdgeInsets.only(right: 10),
                                          paddingText:
                                              const EdgeInsets.only(left: 3),
                                          foodImage: snapshot.data![index]
                                              ['restaurant_image'],
                                          deliveryTime:
                                              '${snapshot.data![index]['time']} mins',
                                          shopName: snapshot.data![index]
                                              ['restaurant_name'],
                                          shopAddress: snapshot.data![index]
                                              ['place'],
                                          rateStar: snapshot.data![index]
                                              ['vote'],
                                          restaurantModel:
                                              CommonUtils.sortRestaurant(
                                                  restaurants,
                                                  'explore')[index],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 32, right: 23),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(' My Ratings'),
                                              RatingBar.builder(
                                                ignoreGestures: true,
                                                itemSize: 22,
                                                initialRating: snapshot
                                                    .data![index]['my_vote'],
                                                unratedColor: Colors.grey,
                                                itemBuilder: (context, index) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                onRatingUpdate: (value) {
                                                  null;
                                                },
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16),
                                                child: Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          minWidth:
                                                              double.infinity,
                                                          minHeight: 162),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 16,
                                                      horizontal: 24),
                                                  height: 162,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade300)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const CustomText(
                                                          content: 'My Review',
                                                          fontSize: 12,
                                                          color: AppColor
                                                              .globalPink),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(snapshot.data![index]
                                                          ['my_review'])
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ))),
                      ],
                    ),
                  ),
            floatingActionButton: snapshot.data!.length > 1
                ? ValueListenableBuilder(
                    valueListenable: currentCard,
                    builder: (BuildContext context, int value, Widget? child) {
                      if (value == snapshot.data!.length - 1) {
                        return const SizedBox();
                      }
                      return FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {
                          pageController.animateToPage(currentCard.value + 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        shape: const CircleBorder(side: BorderSide.none),
                        mini: true,
                        child: const Icon(Icons.arrow_forward_ios),
                      );
                    })
                : const SizedBox(),
          );
        });
  }
}

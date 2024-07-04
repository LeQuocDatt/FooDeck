import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

List<Widget> optionMenuButton(BuildContext context) {
  final restaurantPageBloc = context.read<RestaurantPageBloc>();
  final explorePageBloc = context.read<ExplorePageBloc>();
  return [
    BlocBuilder<ExplorePageBloc, ExplorePageState>(
      buildWhen: (previous, current) => current is ExplorePageLikeState,
      builder: (context, state) {
        return IconButton(
          color: AppColor.globalPink,
          onPressed: () {
            explorePageBloc
                .add(ExplorePageLikeEvent(saveFood: restaurantModel));
          },
          icon: restaurantModel.like
              ? const Icon(
                  Icons.favorite,
                  color: AppColor.globalPink,
                )
              : const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
        );
      },
    ),
    const SizedBox(width: 5),
    GestureDetector(
      onTap: () {
        restaurantPageBloc.add(RestaurantPageShareEvent());
      },
      child: Image.asset(
        Assets.shareNetwork,
        color: Colors.white,
        height: 22,
        width: 22,
      ),
    ),
    PopupMenuButton(
      iconSize: 30,
      iconColor: Colors.white,
      color: AppColor.dividerGrey,
      itemBuilder: (context) => [
        PopupMenuItem(
            onTap: () {
              customSnackBar(context, Toast.error, 'In Updating...');
            },
            padding: EdgeInsets.zero,
            child: TextButton.icon(
              onPressed: null,
              label: const CustomText(content: 'Report'),
              icon: const Icon(Icons.flag),
            )),
        PopupMenuItem(
            onTap: () {
              restaurantPageBloc.review = '';
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) => GestureDetector(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: SimpleDialog(
                          title: Center(
                            child: CupertinoTextField(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24)),
                              maxLines: 5,
                              onChanged: (value) {
                                restaurantPageBloc.add(
                                    RestaurantPageSetReviewEvent(
                                        review: value));
                              },
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: RatingBar.builder(
                                itemSize: 22,
                                initialRating: restaurantPageBloc.rate,
                                minRating: 1,
                                maxRating: 5,
                                unratedColor: Colors.grey,
                                updateOnDrag: true,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                onRatingUpdate: (value) {
                                  restaurantPageBloc.add(
                                      RestaurantPageSetRateEvent(rate: value));
                                },
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  restaurantPageBloc.add(
                                      RestaurantPageSentReviewEvent(
                                          restaurant: restaurantModel,
                                          context: context));
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 50, right: 50, top: 24),
                                  child: CustomButton(
                                      content: 'Send Review',
                                      color: AppColor.globalPink),
                                ))
                          ],
                        ),
                      ));
            },
            padding: EdgeInsets.zero,
            child: TextButton.icon(
              onPressed: null,
              label: const CustomText(content: 'Review'),
              icon: const Icon(Icons.rate_review),
            )),
        PopupMenuItem(
            onTap: () {
              restaurantPageBloc.add(RestaurantPageMapEvent());
            },
            padding: EdgeInsets.zero,
            child: TextButton.icon(
              onPressed: null,
              label: const CustomText(content: 'Map'),
              icon: const Icon(Icons.location_on),
            )),
      ],
    )
  ];
}

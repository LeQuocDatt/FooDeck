import 'package:template/source/export.dart';

class MiddleSlideList extends StatelessWidget {
  const MiddleSlideList({super.key});

  @override
  Widget build(BuildContext context) {
    final explorePageBloc = context.read<ExplorePageBloc>();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 25, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(content: 'Deals', fontWeight: FontWeight.bold),
            IconButton(
                onPressed: () {
                  customSnackBar(context, Toast.error, 'In Updating...');
                },
                icon: const Icon(Icons.arrow_forward))
          ],
        ),
      ),
      Expanded(
        child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
                width: 280,
                child: BlocBuilder<ExplorePageBloc, ExplorePageState>(
                  buildWhen: (previous, current) =>
                      current is ExplorePageLoadingSuccessState,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case ExplorePageLoadingSuccessState:
                        final success = state as ExplorePageLoadingSuccessState;
                        final restaurant = CommonUtils.sortRestaurant(
                            success.restaurants, 'deal');
                        return success.restaurants.isNotEmpty
                            ? CustomSlidePage(
                                itemCount: restaurant.length,
                                itemBuilder: (context, index) => BannerItems(
                                    onTap: () => explorePageBloc.add(
                                        ExplorePageNavigateEvent(
                                            restaurantModel:
                                                restaurant[index])),
                                    paddingImage:
                                        const EdgeInsets.only(right: 20),
                                    paddingText: const EdgeInsets.only(left: 3),
                                    foodImage: restaurant[index].image,
                                    deliveryTime:
                                        '${restaurant[index].deliveryTime} mins',
                                    shopName: restaurant[index].shopName,
                                    shopAddress: restaurant[index].address,
                                    rateStar: '${restaurant[index].rate}',
                                    action: () {
                                      explorePageBloc.add(ExplorePageLikeEvent(
                                          saveFood: restaurant[index]));
                                    },
                                    restaurantModel: restaurant[index]))
                            : TextButton.icon(
                                onPressed: null,
                                label: const CustomText(
                                    content: 'Connection Fail'),
                                icon: const Icon(Icons.error_outline));
                    }
                    return const SizedBox.shrink();
                  },
                ))),
      )
    ]);
  }
}

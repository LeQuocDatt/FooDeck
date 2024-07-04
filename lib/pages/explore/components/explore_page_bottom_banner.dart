import 'package:template/source/export.dart';

class BottomListShopping extends StatelessWidget {
  const BottomListShopping({super.key});

  @override
  Widget build(BuildContext context) {
    final explorePageBloc = context.read<ExplorePageBloc>();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomText(content: 'Explore More', fontWeight: FontWeight.bold),
      Expanded(
        child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: BlocBuilder<ExplorePageBloc, ExplorePageState>(
              buildWhen: (previous, current) =>
                  current is ExplorePageLoadingSuccessState,
              builder: (context, state) {
                switch (state.runtimeType) {
                  case ExplorePageLoadingSuccessState:
                    final success = state as ExplorePageLoadingSuccessState;
                    final restaurant = CommonUtils.sortRestaurant(
                        success.restaurants, 'explore');
                    return success.restaurants.isNotEmpty
                        ? ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: restaurant.length,
                            scrollDirection: Axis.vertical,
                            clipBehavior: Clip.none,
                            itemBuilder: (context, index) => BannerItems(
                                onTap: () => explorePageBloc.add(
                                    ExplorePageNavigateEvent(
                                        restaurantModel: restaurant[index])),
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
                                restaurantModel: restaurant[index]),
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(height: 20);
                            },
                          )
                        : TextButton.icon(
                            onPressed: null,
                            label: const CustomText(content: 'Connection Fail'),
                            icon: const Icon(Icons.error_outline));
                }
                return const SizedBox.shrink();
              },
            )),
      )
    ]);
  }
}

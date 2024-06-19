import 'package:template/source/export.dart';

class BottomListShopping extends StatelessWidget {
  const BottomListShopping({super.key});

  @override
  Widget build(BuildContext context) {
    final explorePageBloc = context.read<ExplorePageBloc>();
    final List<RestaurantModel> restaurant = CommonUtils.sortRestaurant(
        TitleFood.Explore, RestaurantData.restaurant);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomText(content: 'Explore More', fontWeight: FontWeight.bold),
      Padding(
          padding: const EdgeInsets.only(top: 12),
          child: SizedBox(
              height: 674,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: restaurant.length,
                  scrollDirection: Axis.vertical,
                  clipBehavior: Clip.none,
                  itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: BannerItems(
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
                          restaurantModel: restaurant[index])))))
    ]);
  }
}

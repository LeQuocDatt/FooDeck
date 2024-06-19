import 'package:template/source/export.dart';

class MiddleSlideList extends StatelessWidget {
  const MiddleSlideList({super.key});

  @override
  Widget build(BuildContext context) {
    final explorePageBloc = context.read<ExplorePageBloc>();
    final List<RestaurantModel> restaurant =
        CommonUtils.sortRestaurant(TitleFood.Deals, RestaurantData.restaurant);
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
      Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
              width: 270,
              height: 220,
              child: CustomSlidePage(
                  itemCount: restaurant.length,
                  itemBuilder: (context, index) => BannerItems(
                      onTap: () => explorePageBloc.add(ExplorePageNavigateEvent(
                          restaurantModel: restaurant[index])),
                      paddingImage: const EdgeInsets.only(right: 10),
                      paddingText: const EdgeInsets.only(left: 3),
                      foodImage: restaurant[index].image,
                      deliveryTime: '${restaurant[index].deliveryTime} mins',
                      shopName: restaurant[index].shopName,
                      shopAddress: restaurant[index].address,
                      rateStar: '${restaurant[index].rate}',
                      action: () {
                        explorePageBloc.add(
                            ExplorePageLikeEvent(saveFood: restaurant[index]));
                      },
                      restaurantModel: restaurant[index]))))
    ]);
  }
}

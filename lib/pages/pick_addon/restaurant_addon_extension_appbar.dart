part of 'restaurant_addon.dart';

class RestaurantAddonAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  RestaurantAddonAppBar({required this.expandedHeight});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return buildAppBar(context, shrinkOffset);
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => expandedHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  double move(double offset) => 24 + offset / 5.5;

  Widget buildAppBar(BuildContext context, double offset) => AppBar(
      leading: BackButton(
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: optionMenuButton(context),
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(RestaurantData.food.picture),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.only(left: move(offset), bottom: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      content: RestaurantData.food.nameFood,
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  CustomText(
                      content: RestaurantData.food.place,
                      color: Colors.white,
                      fontSize: 15)
                ]),
          )));
}

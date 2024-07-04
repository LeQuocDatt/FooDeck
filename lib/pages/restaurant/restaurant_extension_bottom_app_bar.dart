part of 'restaurant_page.dart';

class RestaurantBottomAppBar extends StatelessWidget {
  const RestaurantBottomAppBar({super.key});

  // phân loại tabs theo danh sách enum
  List<Tab> _buildCategoryTabs() {
    return type.map((category) {
      return Tab(
        text: category.split('.').last,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 45,
      backgroundColor: Colors.white,
      expandedHeight: 130,
      pinned: true,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
          title: TabBar(
              tabAlignment: TabAlignment.start,
              indicatorColor: AppColor.globalPink,
              dividerColor: Colors.grey[200],
              labelColor: AppColor.globalPink,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              labelStyle: AppTextStyle.inter
                  .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
              tabs: _buildCategoryTabs()),
          expandedTitleScale: 1,
          titlePadding: EdgeInsets.zero,
          background: Padding(
            padding: const EdgeInsets.only(bottom: 57, left: 50, right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<RestaurantPageBloc, RestaurantPageState>(
                  buildWhen: (previous, current) =>
                      current is RestaurantPageLoadingSuccessState,
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Icon(Icons.star_border),
                            CustomText(content: restaurantModel.rate.toString())
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.access_time_outlined),
                            CustomText(
                                content: '${restaurantModel.deliveryTime} mins')
                          ],
                        ),
                        const Column(
                          children: [
                            Icon(Icons.location_on_outlined),
                            CustomText(content: '1.4km')
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }
}

import 'package:template/features/my_orders/bloc/my_orders_bloc.dart';
import 'package:template/source/export.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    context.read<MyOrdersBloc>().add(MyOrdersInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myOrdersBloc = context.read<MyOrdersBloc>();
    final explorePageBloc = context.read<ExplorePageBloc>();
    final restaurant = CommonUtils.sortRestaurant(restaurants, 'recent');
    return Scaffold(
      appBar: AppBar(
          shape: const UnderlineInputBorder(
              borderSide: BorderSide(width: 8, color: AppColor.dividerGrey)),
          title: const CustomText(
              content: 'My Orders', fontWeight: FontWeight.bold)),
      body: BlocBuilder<MyOrdersBloc, MyOrdersState>(
        buildWhen: (previous, current) => current is MyOrdersLoadedState,
        builder: (context, state) {
          return SizedBox(
            height: 1000,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 290,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.fromLTRB(24, 24, 0, 12),
                          child: CustomText(
                              content: 'Recent Order',
                              fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: SizedBox(
                              width: 300,
                              child: CustomSlidePage(
                                  itemCount: restaurant.length,
                                  itemBuilder: (BuildContext context,
                                          int index) =>
                                      BannerItems(
                                          badge: const SizedBox(),
                                          voteStar: const SizedBox(),
                                          onTap: () {
                                            explorePageBloc.add(
                                                ExplorePageLikeEvent(
                                                    saveFood:
                                                        restaurant[index]));
                                          },
                                          paddingImage:
                                              const EdgeInsets.only(right: 10),
                                          paddingText: const EdgeInsets.only(
                                              left: 3, top: 8),
                                          foodImage: restaurant[index].image,
                                          deliveryTime:
                                              '${restaurant[index].deliveryTime} mins',
                                          shopName: restaurant[index].shopName,
                                          shopAddress:
                                              restaurant[index].address,
                                          rateStar: '${restaurant[index].rate}',
                                          action: () {
                                            explorePageBloc.add(
                                                ExplorePageLikeEvent(
                                                    saveFood:
                                                        restaurant[index]));
                                          },
                                          restaurantModel: restaurant[index])),
                            )),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Divider(thickness: 8, color: AppColor.dividerGrey),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: orderCompletes.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: GestureDetector(
                            onTap: () {
                              myOrdersBloc.add(
                                  MyOrdersNavigateToDetailBillPageEvent(
                                      orderCompleteModel:
                                          orderCompletes[index]));
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        content: orderCompletes[index]
                                            .restaurantName),
                                    CustomText(
                                        content: orderCompletes[index].date,
                                        color: Colors.grey,
                                        fontSize: 15)
                                  ]),
                              trailing: TextButton.icon(
                                onPressed: null,
                                label: CustomText(
                                    content:
                                        '\$${orderCompletes[index].totalPrice}',
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                ),
                                iconAlignment: IconAlignment.end,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

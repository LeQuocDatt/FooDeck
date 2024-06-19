import 'package:template/source/export.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  void initState() {
    context.read<ExplorePageBloc>().add(ExplorePageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final explorePageBloc = context.read<ExplorePageBloc>();
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.homeBar), fit: BoxFit.cover))),
          toolbarHeight: 142,
          automaticallyImplyLeading: false,
          titleTextStyle:
              AppTextStyle.inter.copyWith(fontSize: 17, color: Colors.white),
          titleSpacing: 24,
          title: Column(
            children: [
              BlocBuilder<ExplorePageBloc, ExplorePageState>(
                buildWhen: (previous, current) =>
                    current is ExplorePageLoadingSuccessState,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case ExplorePageLoadingSuccessState:
                      final success = state as ExplorePageLoadingSuccessState;
                      return success.userModel['address'] != null
                          ? Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: CustomText(
                                      content: success.userModel['address']),
                                ),
                              ],
                            )
                          : const SizedBox.shrink();
                  }
                  return const SizedBox.shrink();
                },
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: GestureDetector(
                    onTap: () =>
                        explorePageBloc.add(ExplorePageSearchNavigateEvent()),
                    child: Container(
                        height: 54,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)),
                        child: Row(children: [
                          Image.asset(Assets.search, color: Colors.grey),
                          const SizedBox(width: 8),
                          CustomText(
                              content: 'Search...',
                              fontSize: 20,
                              color: Colors.grey[400])
                        ])),
                  ))
            ],
          ),
        ),
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 40),
                child: TopListShopping(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: ListSlideBanner(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: MiddleSlideList(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                child: BottomListShopping(),
              )
            ],
          ),
        ),
        floatingActionButton:
            BlocBuilder<RestaurantCartBloc, RestaurantCartState>(
          buildWhen: (previous, current) =>
              current is RestaurantCartLoadedState ||
              current is RestaurantCartRemoveItemState,
          builder: (context, state) {
            return CartItemsListData.cartItems.isEmpty
                ? const SizedBox.shrink()
                : Badge(
                    smallSize: 25,
                    largeSize: 25,
                    backgroundColor: Colors.black,
                    label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: CustomText(
                            content: '${CartItemsListData.cartItems.length}')),
                    child: FloatingActionButton(
                      onPressed: () {
                        explorePageBloc.add(ExplorePageCartNavigateEvent());
                      },
                      backgroundColor: AppColor.globalPink,
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  );
          },
        ));
  }
}

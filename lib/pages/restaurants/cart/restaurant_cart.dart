import 'package:template/source/export.dart';

class RestaurantCart extends StatefulWidget {
  const RestaurantCart({super.key});

  @override
  State<RestaurantCart> createState() => _RestaurantCartState();
}

class _RestaurantCartState extends State<RestaurantCart> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.99);

  @override
  void initState() {
    context.read<RestaurantCartBloc>().add(RestaurantCartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantCartBloc = context.read<RestaurantCartBloc>();
    return BlocConsumer<RestaurantCartBloc, RestaurantCartState>(
      listenWhen: (previous, current) => current is RestaurantCartActionState,
      buildWhen: (previous, current) => current is! RestaurantCartActionState,
      listener: (context, state) {
        if (state is RestaurantCartNavigateToCheckOutState) {
          Navigator.pushNamed(context, AppRouter.restaurantCheckOut);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case RestaurantCartLoadingState:
            return const LoadingAnimationRive();
          case RestaurantCartLoadedState:
            return Scaffold(
              appBar: AppBar(
                  shape: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 8, color: AppColor.dividerGrey)),
                  title: const CustomText(
                      content: 'Cart', fontWeight: FontWeight.bold)),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 220,
                        child: ListView.builder(
                          itemCount: CartItemsListData.cartItems.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Badge(
                                          largeSize: 20,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          backgroundColor: Colors.black,
                                          label: CustomText(
                                              content:
                                                  '${CartItemsListData.cartItems[index].quantity}',
                                              fontSize: 12),
                                          child: Container(
                                              width: 64,
                                              height: 64,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          CartItemsListData
                                                              .cartItems[index]
                                                              .foodItems
                                                              .picture),
                                                      fit: BoxFit.cover))),
                                        ),
                                        RichText(
                                            text: TextSpan(
                                                text:
                                                    '${CartItemsListData.cartItems[index].foodItems.nameFood}\n',
                                                style: AppTextStyle.inter
                                                    .copyWith(
                                                        fontSize: 17,
                                                        color: Colors.black),
                                                children: [
                                              TextSpan(
                                                  text:
                                                      '${CartItemsListData.cartItems[index].size} ',
                                                  style: AppTextStyle.inter
                                                      .copyWith(
                                                          fontSize: 15,
                                                          color: Colors.grey)),
                                              WidgetSpan(
                                                  baseline:
                                                      TextBaseline.ideographic,
                                                  alignment:
                                                      PlaceholderAlignment
                                                          .baseline,
                                                  child: Container(
                                                    height: 5,
                                                    width: 5,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.grey),
                                                  )),
                                              TextSpan(
                                                  text:
                                                      ' ${CartItemsListData.cartItems[index].selectAddon[0]}\n${CartItemsListData.cartItems[index].selectAddon[1]}\n${CartItemsListData.cartItems[index].note}\n',
                                                  style: AppTextStyle.inter
                                                      .copyWith(
                                                          fontSize: 15,
                                                          color: Colors.grey)),
                                              const WidgetSpan(
                                                  child: SizedBox(
                                                height: 30,
                                              )),
                                              TextSpan(
                                                  text:
                                                      '\$${CartItemsListData.cartItems[index].price}',
                                                  style: AppTextStyle.inter
                                                      .copyWith(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold))
                                            ])),
                                        IconButton(
                                            onPressed: () {
                                              restaurantCartBloc.add(
                                                  RestaurantCartRemoveItemEvent(
                                                      cartItem:
                                                          CartItemsListData
                                                                  .cartItems[
                                                              index]));
                                            },
                                            icon: const Icon(
                                                Icons.highlight_remove,
                                                color: Colors.grey))
                                      ]),
                                  Divider(color: Colors.grey[300])
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 300,
                        width: double.maxFinite,
                        decoration:
                            const BoxDecoration(color: AppColor.dividerGrey),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.fromLTRB(24, 24, 0, 12),
                                child: CustomText(
                                    content: 'Popular with these',
                                    fontWeight: FontWeight.bold)),
                            Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: SizedBox(
                                    width: 270,
                                    height: 220,
                                    child: PageView.builder(
                                        scrollBehavior: const ScrollBehavior(),
                                        onPageChanged: (value) {
                                          restaurantCartBloc.currentCard =
                                              value;
                                        },
                                        controller: pageController,
                                        clipBehavior: Clip.none,
                                        itemCount:
                                            CommonUtils.sortFood(FoodCategory.Beverages, RestaurantData.foodItems)
                                                .length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (BuildContext context, int index) => BannerItems(
                                            voteStar: const SizedBox(),
                                            paddingImage: const EdgeInsets.only(
                                                right: 10),
                                            paddingText:
                                                const EdgeInsets.only(left: 3),
                                            foodImage: CommonUtils.sortFood(
                                                    FoodCategory.Beverages,
                                                    RestaurantData
                                                        .foodItems)[index]
                                                .picture,
                                            deliveryTime:
                                                '\$${CommonUtils.sortFood(FoodCategory.Beverages, RestaurantData.foodItems)[index].price}',
                                            shopName: CommonUtils.sortFood(
                                                    FoodCategory.Beverages,
                                                    RestaurantData.foodItems)[index]
                                                .nameFood,
                                            shopAddress: CommonUtils.sortFood(FoodCategory.Beverages, RestaurantData.foodItems)[index].place,
                                            rateStar: ''))))
                          ],
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(24, 24, 0, 16),
                          child: CustomText(
                              content: 'Coupon',
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        child: DropdownButtonFormField(
                          icon: const Icon(Icons.arrow_forward),
                          borderRadius: BorderRadius.circular(20),
                          hint: const CustomText(content: 'GREELOGIX'),
                          dropdownColor: Colors.white,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(16)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(16)),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          items: const [
                            DropdownMenuItem(
                                value: 'GREELOGIX',
                                child: CustomText(content: 'GREELOGIX')),
                            DropdownMenuItem(
                                value: '', child: CustomText(content: ''))
                          ],
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      const Divider(
                        thickness: 8,
                        color: AppColor.dividerGrey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                    content: 'Subtotal',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                CustomText(
                                    content:
                                        '\$${restaurantCartBloc.totalPrice}',
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.globalPink)
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(content: 'Delivery Fee'),
                                  CustomText(
                                      content:
                                          '\$${restaurantCartBloc.deliveryFee}')
                                ],
                              ),
                            ),
                            Divider(color: Colors.grey[300]),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(content: 'VAT'),
                                  CustomText(
                                      content: '\$${restaurantCartBloc.vat}')
                                ],
                              ),
                            ),
                            Divider(color: Colors.grey[300]),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(content: 'Coupon'),
                                  CustomText(
                                      content:
                                          '-\$${restaurantCartBloc.coupon}',
                                      color: Colors.green)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 34),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                content: '\$${restaurantCartBloc.bill}',
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                            CustomButton(
                              content: 'Go to Checkout',
                              color: AppColor.globalPink,
                              heightBox: 54,
                              widthBox: 172,
                              paddingLeft: 8,
                              onPressed: () {
                                restaurantCartBloc.add(
                                    RestaurantCartNavigateToCheckOutEvent());
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
        }
        return const SizedBox();
      },
    );
  }
}

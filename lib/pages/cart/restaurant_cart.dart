import 'package:template/source/export.dart';

class RestaurantCart extends StatefulWidget {
  const RestaurantCart({super.key});

  @override
  State<RestaurantCart> createState() => _RestaurantCartState();
}

class _RestaurantCartState extends State<RestaurantCart> {
  @override
  void initState() {
    context.read<RestaurantCartBloc>().add(RestaurantCartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantCartBloc = context.read<RestaurantCartBloc>();
    return Scaffold(
      appBar: AppBar(
          shape: const UnderlineInputBorder(
              borderSide: BorderSide(width: 8, color: AppColor.dividerGrey)),
          title:
              const CustomText(content: 'Cart', fontWeight: FontWeight.bold)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            height: 1100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BlocBuilder<RestaurantCartBloc, RestaurantCartState>(
                    buildWhen: (previous, current) =>
                        current is RestaurantCartLoadedState ||
                        current is RestaurantCartRemoveItemState,
                    builder: (context, state) {
                      return ListView.separated(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 24),
                            title: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Badge(
                                      largeSize: 20,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      backgroundColor: Colors.black,
                                      label: CustomText(
                                          content:
                                              '${cartItems[index].quantity}',
                                          fontSize: 12),
                                      child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      cartItems[index]
                                                          .foodImage),
                                                  fit: BoxFit.cover))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            content: cartItems[index].foodName),
                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CustomText(
                                                  content:
                                                      cartItems[index].size,
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 10),
                                                child: Container(
                                                    height: 5,
                                                    width: 5,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                Colors.grey)),
                                              ),
                                              Expanded(
                                                  child: CustomText(
                                                      textOverflow:
                                                          TextOverflow.visible,
                                                      content:
                                                          '${cartItems[index].selectAddon}${cartItems[index].note}',
                                                      fontSize: 15,
                                                      color: Colors.grey)),
                                            ]),
                                        CustomText(
                                            content:
                                                '\$${cartItems[index].price}',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        restaurantCartBloc.add(
                                            RestaurantCartRemoveItemEvent(
                                                cartItem: cartItems[index]));
                                      },
                                      icon: const Icon(Icons.dangerous,
                                          color: Colors.grey))
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(color: Colors.grey[300]),
                          );
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.centerLeft,
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
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 70, bottom: 24),
                              child: CustomSlidePage(
                                  itemCount:
                                      CommonUtils.sortFood('Beverages', foods)
                                          .length,
                                  itemBuilder: (context, index) {
                                    final food = CommonUtils.sortFood(
                                        'Beverages', foods)[index];
                                    return BannerItems(
                                      onTap: () {
                                        restaurantCartBloc.add(
                                            RestaurantCartNavigateBackEvent(
                                                foodModel: food));
                                      },
                                      heartIcon: const SizedBox.shrink(),
                                      voteStar: const SizedBox.shrink(),
                                      paddingImage:
                                          const EdgeInsets.only(right: 30),
                                      paddingText: const EdgeInsets.only(
                                          left: 3, top: 8),
                                      foodImage: food.foodImage,
                                      deliveryTime: '\$${food.price}',
                                      shopName: food.foodName,
                                      shopAddress: restaurantModel.address,
                                      rateStar: '',
                                      restaurantModel:
                                          CommonUtils.sortRestaurant(
                                              restaurants, 'explore')[index],
                                    );
                                  })),
                        )
                      ],
                    ),
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
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(16)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
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
                              content: '\$$totalPrice',
                              fontWeight: FontWeight.bold,
                              color: AppColor.globalPink)
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(content: 'Delivery Fee'),
                            CustomText(content: '\$$deliveryFee')
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey[300]),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(content: 'VAT'),
                            CustomText(content: '\$$vat')
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey[300]),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(content: 'Coupon'),
                            CustomText(
                                content: '-\$$coupon', color: Colors.green)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomText(
                            content: '\$$bill',
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: CustomButton(
                          content: 'Go to Checkout',
                          color: AppColor.globalPink,
                          onPressed: () {
                            restaurantCartBloc
                                .add(RestaurantCartNavigateToCheckOutEvent());
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

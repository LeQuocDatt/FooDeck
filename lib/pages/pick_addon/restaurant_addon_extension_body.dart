part of 'restaurant_addon.dart';

Widget restaurantAddonBody(BuildContext context) {
  final restaurantAddonBloc = context.read<RestaurantAddonBloc>();
  return SizedBox(
    height: 1300,
    child: Column(
      children: [
        SizedBox(
            height: 290,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          content: 'Variation',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      CustomText(
                        content: 'Required',
                        color: AppColor.globalPink,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: RestaurantData.food.availableAddons.length,
                    itemBuilder: (BuildContext context, int index) {
                      Addon addon = RestaurantData.food.availableAddons[index];
                      return BlocBuilder<RestaurantAddonBloc,
                          RestaurantAddonState>(
                        buildWhen: (previous, current) =>
                            current is RestaurantAddonPickSizeState ||
                            current is RestaurantAddonLoadingSuccessState,
                        builder: (context, state) {
                          return RadioListTile.adaptive(
                            secondary:
                                CustomText(content: '\$${addon.priceSize}'),
                            title: CustomText(content: addon.size),
                            activeColor: AppColor.globalPink,
                            value: addon.radio,
                            groupValue: restaurantAddonBloc.turnOn,
                            onChanged: (value) {
                              restaurantAddonBloc.add(
                                  RestaurantAddonPickSizeEvent(
                                      turnOn: value!, index: index));
                            },
                          );
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(color: Colors.grey[300]);
                    },
                  ),
                ),
              ],
            )),
        const Divider(
          thickness: 8,
          color: AppColor.dividerGrey,
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                  content: 'Quantity',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (RestaurantData.food.quantityFood > 1) {
                              restaurantAddonBloc
                                  .add(RestaurantAddonDecreaseQuantityEvent());
                            } else {
                              null;
                            }
                          },
                          icon: const Icon(Icons.remove)),
                      BlocBuilder<RestaurantAddonBloc, RestaurantAddonState>(
                        buildWhen: (previous, current) =>
                            current is RestaurantAddonCountState ||
                            current is RestaurantAddonLoadingSuccessState,
                        builder: (context, state) {
                          return CustomText(
                              content: '${RestaurantData.food.quantityFood}'
                                  .padLeft(2, '0'));
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            restaurantAddonBloc
                                .add(RestaurantAddonIncreaseQuantityEvent());
                          },
                          icon: const Icon(Icons.add))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const Divider(
          thickness: 8,
          color: AppColor.dividerGrey,
        ),
        SizedBox(
            height: 210,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24, top: 24),
                  child: CustomText(
                      content: 'Extra Sauce',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: restaurantAddonBloc.like.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        Addon addon =
                            RestaurantData.food.availableAddons[index];
                        return BlocBuilder<RestaurantAddonBloc,
                            RestaurantAddonState>(
                          buildWhen: (previous, current) =>
                              current is RestaurantAddonPickToppingState ||
                              current is RestaurantAddonLoadingSuccessState,
                          builder: (context, state) {
                            return CheckboxListTile.adaptive(
                              checkColor: Colors.white,
                              activeColor: AppColor.globalPink,
                              controlAffinity: ListTileControlAffinity.leading,
                              secondary: CustomText(
                                  content: '+\$${addon.price}',
                                  color: Colors.grey),
                              title: CustomText(
                                  content: addon.addonName, color: Colors.grey),
                              value: restaurantAddonBloc.like[index],
                              onChanged: (bool? value) {
                                restaurantAddonBloc.add(
                                    RestaurantAddonPickToppingEvent(
                                        index: index, like: value!));
                              },
                            );
                          },
                        );
                      }),
                ),
              ],
            )),
        const Divider(
          thickness: 8,
          color: AppColor.dividerGrey,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                  content: 'Instructions',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              const SizedBox(height: 20),
              const CustomText(
                  content: 'Let us know if you have specific things in\nmind',
                  color: Colors.grey),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: CustomTextField(
                  floatingLabelColor: Colors.grey,
                  labelColor: Colors.grey,
                  labelText: 'e.g. less spices, no mayo etc',
                  activeValidate: true,
                  borderColor: Colors.grey.shade300,
                  onChanged: (value) {
                    restaurantAddonBloc
                        .add(RestaurantAddonNoteEvent(note: value));
                  },
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 8,
          color: AppColor.dividerGrey,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: CustomText(
                      content: 'If the product is not available',
                      fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 60),
                child: DropdownButtonFormField(
                  iconEnabledColor: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(20),
                  hint: CustomText(
                      content: 'Remove it from my order',
                      color: Colors.grey.shade400),
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
                        value: 'Remove it from my order',
                        child: CustomText(
                            content: 'Remove it from my order',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey)),
                    DropdownMenuItem(value: '', child: CustomText(content: ''))
                  ],
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: BlocBuilder<RestaurantAddonBloc, RestaurantAddonState>(
                  builder: (context, state) {
                    return CustomText(
                        content: '\$${restaurantAddonBloc.totalPrice}',
                        fontSize: 28,
                        fontWeight: FontWeight.bold);
                  },
                ),
              ),
              Expanded(
                child: CustomButton(
                    onPressed: () {
                      restaurantAddonBloc.add(
                          RestaurantAddonNavigateToCartEvent(context: context));
                    },
                    content: 'Add To Cart',
                    color: AppColor.globalPink),
              )
            ],
          ),
        )
      ],
    ),
  );
}

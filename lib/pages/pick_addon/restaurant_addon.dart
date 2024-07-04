import 'package:template/source/export.dart';

part 'restaurant_addon_extension_appbar.dart';

class RestaurantAddon extends StatefulWidget {
  const RestaurantAddon({super.key});

  @override
  State<RestaurantAddon> createState() => _RestaurantAddonState();
}

class _RestaurantAddonState extends State<RestaurantAddon> {
  @override
  void initState() {
    context.read<RestaurantAddonBloc>().add(RestaurantAddonInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantAddonBloc = context.read<RestaurantAddonBloc>();
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: RestaurantAddonAppBar(expandedHeight: 200),
                pinned: true,
                floating: true,
              ),
              SliverToBoxAdapter(
                  child: SizedBox(
                height: 1330,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
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
                            child: BlocBuilder<RestaurantAddonBloc,
                                RestaurantAddonState>(
                              buildWhen: (previous, current) =>
                                  current is RestaurantAddonPickSizeState ||
                                  current is RestaurantAddonLoadingSuccessState,
                              builder: (context, state) {
                                switch (state.runtimeType) {
                                  case RestaurantAddonLoadingSuccessState:
                                    final success = state
                                        as RestaurantAddonLoadingSuccessState;
                                    return ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: success.addons.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return RadioListTile.adaptive(
                                          secondary: CustomText(
                                              content:
                                                  '\$${success.addons[index].sizePrice}'),
                                          title: CustomText(
                                              content:
                                                  success.addons[index].size),
                                          activeColor: AppColor.globalPink,
                                          value: success.addons[index].type,
                                          groupValue:
                                              restaurantAddonBloc.turnOn,
                                          onChanged: (value) {
                                            restaurantAddonBloc.add(
                                                RestaurantAddonPickSizeEvent(
                                                    turnOn: value!,
                                                    index: index));
                                          },
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Divider(color: Colors.grey[300]);
                                      },
                                    );
                                  case RestaurantAddonPickSizeState:
                                    final success =
                                        state as RestaurantAddonPickSizeState;
                                    return ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: success.addons.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return RadioListTile.adaptive(
                                          secondary: CustomText(
                                              content:
                                                  '\$${success.addons[index].sizePrice}'),
                                          title: CustomText(
                                              content:
                                                  success.addons[index].size),
                                          activeColor: AppColor.globalPink,
                                          value: success.addons[index].type,
                                          groupValue:
                                              restaurantAddonBloc.turnOn,
                                          onChanged: (value) {
                                            restaurantAddonBloc.add(
                                                RestaurantAddonPickSizeEvent(
                                                    turnOn: value!,
                                                    index: index));
                                          },
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Divider(color: Colors.grey[300]);
                                      },
                                    );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Divider(
                        thickness: 8,
                        color: AppColor.dividerGrey,
                      ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        if (restaurantAddonBloc.quantity > 1) {
                                          restaurantAddonBloc.add(
                                              RestaurantAddonDecreaseQuantityEvent());
                                        } else {
                                          null;
                                        }
                                      },
                                      icon: const Icon(Icons.remove)),
                                  BlocBuilder<RestaurantAddonBloc,
                                      RestaurantAddonState>(
                                    buildWhen: (previous, current) =>
                                        current is RestaurantAddonCountState ||
                                        current
                                            is RestaurantAddonLoadingSuccessState,
                                    builder: (context, state) {
                                      return CustomText(
                                          content:
                                              '${restaurantAddonBloc.quantity}'
                                                  .padLeft(2, '0'));
                                    },
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        restaurantAddonBloc.add(
                                            RestaurantAddonIncreaseQuantityEvent());
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
                    Expanded(
                      flex: 2,
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
                            child: BlocBuilder<RestaurantAddonBloc,
                                RestaurantAddonState>(
                              buildWhen: (previous, current) =>
                                  current is RestaurantAddonPickToppingState ||
                                  current is RestaurantAddonLoadingSuccessState,
                              builder: (context, state) {
                                switch (state.runtimeType) {
                                  case RestaurantAddonLoadingSuccessState:
                                    final success = state
                                        as RestaurantAddonLoadingSuccessState;
                                    return ListView.builder(
                                        itemCount: success.addons.length - 1,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return CheckboxListTile.adaptive(
                                            checkColor: Colors.white,
                                            activeColor: AppColor.globalPink,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            secondary: CustomText(
                                                content:
                                                    '+\$${success.addons[index].addonPrice}',
                                                color: Colors.grey),
                                            title: CustomText(
                                                content: success
                                                    .addons[index].addonName,
                                                color: Colors.grey),
                                            value: success.addons[index].like,
                                            onChanged: (bool? value) {
                                              restaurantAddonBloc.add(
                                                  RestaurantAddonPickToppingEvent(
                                                      index: index,
                                                      like: value!));
                                            },
                                          );
                                        });
                                  case RestaurantAddonPickToppingState:
                                    final success = state
                                        as RestaurantAddonPickToppingState;
                                    return ListView.builder(
                                        itemCount: success.addons.length - 1,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return CheckboxListTile.adaptive(
                                            checkColor: Colors.white,
                                            activeColor: AppColor.globalPink,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            secondary: CustomText(
                                                content:
                                                    '+\$${success.addons[index].addonPrice}',
                                                color: Colors.grey),
                                            title: CustomText(
                                                content: success
                                                    .addons[index].addonName,
                                                color: Colors.grey),
                                            value: success.addons[index].like,
                                            onChanged: (bool? value) {
                                              restaurantAddonBloc.add(
                                                  RestaurantAddonPickToppingEvent(
                                                      index: index,
                                                      like: value!));
                                            },
                                          );
                                        });
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Divider(
                        thickness: 8,
                        color: AppColor.dividerGrey,
                      ),
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
                              content:
                                  'Let us know if you have specific things in\nmind',
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
                              padding:
                                  const EdgeInsets.only(top: 24, bottom: 60),
                              child: DropdownButtonFormField(
                                iconEnabledColor: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(20),
                                hint: CustomText(
                                    content: 'Remove it from my order',
                                    color: Colors.grey.shade400),
                                dropdownColor: Colors.white,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 16),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                items: const [
                                  DropdownMenuItem(
                                      value: 'Remove it from my order',
                                      child: CustomText(
                                          content: 'Remove it from my order',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey)),
                                  DropdownMenuItem(
                                      value: '', child: CustomText(content: ''))
                                ],
                                onChanged: (value) {},
                              )),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: BlocBuilder<RestaurantAddonBloc,
                                      RestaurantAddonState>(
                                    buildWhen: (previous, current) =>
                                        current is! RestaurantAddonActionState,
                                    builder: (context, state) {
                                      switch (state.runtimeType) {
                                        case RestaurantAddonLoadingSuccessState:
                                          final success = state
                                              as RestaurantAddonLoadingSuccessState;
                                          return CustomText(
                                              content:
                                                  '\$${success.totalPrice}',
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold);
                                      }
                                      return CustomText(
                                          content:
                                              '\$${restaurantAddonBloc.totalPrice}',
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: CustomButton(
                                      onPressed: () {
                                        restaurantAddonBloc.add(
                                            RestaurantAddonNavigateToCartEvent(
                                                context: context));
                                      },
                                      content: 'Add To Cart',
                                      color: AppColor.globalPink),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ));
  }
}

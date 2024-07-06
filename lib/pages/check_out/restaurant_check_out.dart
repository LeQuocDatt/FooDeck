import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

class RestaurantCheckOut extends StatefulWidget {
  const RestaurantCheckOut({super.key});

  @override
  State<RestaurantCheckOut> createState() => _RestaurantCheckOutState();
}

class _RestaurantCheckOutState extends State<RestaurantCheckOut> {
  @override
  void initState() {
    context
        .read<RestaurantCheckOutBloc>()
        .add(RestaurantCheckOutInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantCheckOutBloc = context.read<RestaurantCheckOutBloc>();
    final paymentMethodsBloc = context.read<PaymentMethodsBloc>();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            shape: const UnderlineInputBorder(
                borderSide: BorderSide(width: 8, color: AppColor.dividerGrey)),
            title: const CustomText(
                content: 'Checkout', fontWeight: FontWeight.bold)),
        body: SingleChildScrollView(
          child: SizedBox(
            height: (cartItems.length * 80) + 1300,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 24),
                    child: BlocBuilder<RestaurantCheckOutBloc,
                        RestaurantCheckOutState>(
                      buildWhen: (previous, current) =>
                          current is RestaurantCheckOutActionState,
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case RestaurantCheckOutLoadedState:
                            final success =
                                state as RestaurantCheckOutLoadedState;
                            return addressMap(success.place,
                                success.initialCameraPosition, context);
                          case RestaurantCheckOutSaveAddressState:
                            final success =
                                state as RestaurantCheckOutSaveAddressState;
                            return addressMap(success.place,
                                success.initialCameraPosition, context);
                          case RestaurantCheckOutPickAddressState:
                            final success =
                                state as RestaurantCheckOutPickAddressState;
                            return addressMap(success.place,
                                success.initialCameraPosition, context);
                          case RestaurantCheckOutRelocateAddressState:
                            final success =
                                state as RestaurantCheckOutRelocateAddressState;
                            return addressMap(success.place,
                                success.initialCameraPosition, context);
                        }
                        return addressMap(
                            restaurantCheckOutBloc.place,
                            restaurantCheckOutBloc.initialCameraPosition,
                            context);
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Divider(
                    thickness: 8,
                    color: AppColor.dividerGrey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                          content: 'Delivery Instructions',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      const CustomText(
                          content:
                              'Let us know if you have specific things in mind',
                          textOverflow: TextOverflow.visible,
                          color: Colors.grey),
                      Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: CustomTextField(
                              activeValidate: true,
                              borderColor: Colors.grey,
                              floatingLabelColor: Colors.grey,
                              controller: restaurantCheckOutBloc.noteController,
                              labelText: 'e.g. I am home around 10 pm'))
                    ],
                  ),
                ),
                const Divider(
                  thickness: 8,
                  color: AppColor.dividerGrey,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 24, right: 20, left: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                                content: 'Payment Method',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            IconButton(
                                onPressed: () {
                                  restaurantCheckOutBloc.add(
                                      RestaurantCheckOutNavigateToCreateCardEvent());
                                },
                                icon: const Icon(Icons.add))
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: BlocBuilder<PaymentMethodsBloc,
                              PaymentMethodsState>(
                            buildWhen: (previous, current) =>
                                current is PaymentMethodsActionState,
                            builder: (context, state) {
                              return payments.isEmpty
                                  ? Container(
                                      height: 200,
                                      alignment: Alignment.center,
                                      child: TextButton.icon(
                                          onPressed: null,
                                          label: const CustomText(
                                              content: 'Pay By Cash'),
                                          icon: const Icon(Icons.attach_money)),
                                    )
                                  : SizedBox(
                                      height: 200,
                                      child: CustomSlidePage(
                                          currentCard:
                                              paymentMethodsBloc.currentCard,
                                          itemCount: payments.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 24),
                                                child: CreditCard(
                                                    cardName: payments[index]
                                                        .cardName,
                                                    cardType: payments[index]
                                                            .cardNumber
                                                            .startsWith('4')
                                                        ? CardType.visa
                                                        : CardType.master,
                                                    cardNumber: payments[index]
                                                        .cardNumber));
                                          }),
                                    );
                            },
                          ))
                    ],
                  ),
                ),
                const Divider(
                  thickness: 8,
                  color: AppColor.dividerGrey,
                ),
                SizedBox(
                  height: (cartItems.length * 80) + 450,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      children: [
                        const OrderSummary(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomText(
                                    content: '\$$bill',
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: CustomButton(
                                  content: 'Pay Now',
                                  color: AppColor.globalPink,
                                  onPressed: () {
                                    restaurantCheckOutBloc.add(
                                        RestaurantCheckOutNavigateToOrderCompleteEvent(
                                            context: context));
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addressMap(String? place, CameraPosition initialCameraPosition,
      BuildContext context) {
    final restaurantCheckOutBloc = context.read<RestaurantCheckOutBloc>();
    return Column(
      children: [
        ListTile(
            contentPadding: EdgeInsets.zero,
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const CustomText(
                  content: 'Delivery Address',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              address.isEmpty
                  ? CustomText(content: currentUser!.address ?? '')
                  : place != null
                      ? CustomText(content: place)
                      : const SizedBox.shrink()
            ]),
            trailing: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            child: Container(
                              height: 800,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30))),
                              child: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: CupertinoSearchTextField(
                                          onSuffixTap: () {
                                            restaurantCheckOutBloc.add(
                                                RestaurantCheckOutRelocateAddressEvent());
                                          },
                                          suffixMode:
                                              OverlayVisibilityMode.always,
                                          suffixIcon:
                                              const Icon(Icons.my_location),
                                          autofocus: true,
                                          placeholder: 'Search Location',
                                          onChanged: (value) {
                                            restaurantCheckOutBloc.add(
                                                RestaurantCheckOutSearchEvent(
                                                    search: value));
                                          })),
                                  Expanded(
                                    child: BlocBuilder<RestaurantCheckOutBloc,
                                        RestaurantCheckOutState>(
                                      buildWhen: (previous, current) => current
                                          is RestaurantCheckOutSearchState,
                                      builder: (context, state) {
                                        switch (state.runtimeType) {
                                          case RestaurantCheckOutSearchState:
                                            final success = state
                                                as RestaurantCheckOutSearchState;
                                            return Column(children: [
                                              success.search.isEmpty
                                                  ? const SizedBox()
                                                  : success.responses.isEmpty
                                                      ? const LinearProgressIndicator(
                                                          color: Colors.grey)
                                                      : Divider(
                                                          thickness: 8,
                                                          color:
                                                              Colors.grey[200],
                                                        ),
                                              Expanded(
                                                child: success.search.isEmpty
                                                    ? _listAddress(
                                                        address, context)
                                                    : _listNewAddress(
                                                        success.responses,
                                                        context),
                                              )
                                            ]);
                                        }
                                        return _listAddress(address, context);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ));
                },
                child: Image.asset(Assets.pencil))),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                  height: 160,
                  child: MapboxMap(
                    doubleClickZoomEnabled: false,
                    dragEnabled: false,
                    zoomGesturesEnabled: false,
                    scrollGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    onMapIdle: () {
                      CommonUtils.addCurrentMarker(initialCameraPosition);
                    },
                    accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                    initialCameraPosition: initialCameraPosition,
                    onMapCreated: CommonUtils.onMapCreated,
                    minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
                  ))),
        ),
      ],
    );
  }
}

Widget _listAddress(List<AddressModel> places, BuildContext context) {
  final restaurantCheckOutBloc = context.read<RestaurantCheckOutBloc>();
  return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: places.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            onTap: () {
              CommonUtils.moveCamera(places[index].location);
              Future.delayed(const Duration(milliseconds: 1000), () {
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: const CustomText(
                          content: 'Do you want to chose this location?',
                          textOverflow: TextOverflow.visible),
                      actions: [
                        TextButton(
                            onPressed: () {
                              restaurantCheckOutBloc.add(
                                  RestaurantCheckOutPickAddressEvent(
                                      place: places[index].address,
                                      initialCameraPosition: CameraPosition(
                                          target: places[index].location,
                                          zoom: 15)));
                            },
                            child: const CustomText(
                                content: 'Yes', color: AppColor.globalPink)),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const CustomText(content: 'No'))
                      ],
                    ),
                  );
                }
              });
            },
            leading: const CustomText(content: 'Saved', color: Colors.grey),
            title: CustomText(
                content: places[index].name, fontWeight: FontWeight.bold),
            subtitle: CustomText(
                content: places[index].address,
                textOverflow: TextOverflow.visible));
      },
      separatorBuilder: (BuildContext context, int index) => const Divider());
}

Widget _listNewAddress(List<AddressModel> places, BuildContext context) {
  final restaurantCheckOutBloc = context.read<RestaurantCheckOutBloc>();
  return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: places.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            onTap: () {
              CommonUtils.moveCamera(places[index].location);
              Future.delayed(const Duration(milliseconds: 1000), () {
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: const CustomText(
                          content: 'Do you want to save this location?',
                          textOverflow: TextOverflow.visible),
                      actions: [
                        TextButton(
                            onPressed: () {
                              restaurantCheckOutBloc.add(
                                  RestaurantCheckOutSaveAddressEvent(
                                      place: places[index].address,
                                      initialCameraPosition: CameraPosition(
                                          target: places[index].location,
                                          zoom: 15)));
                            },
                            child: const CustomText(
                                content: 'Save', color: AppColor.globalPink)),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const CustomText(content: 'No'))
                      ],
                    ),
                  );
                }
              });
            },
            leading: const Icon(Icons.location_on_outlined),
            title: CustomText(
                content: places[index].name, fontWeight: FontWeight.bold),
            subtitle: CustomText(
                content: places[index].address,
                textOverflow: TextOverflow.visible));
      },
      separatorBuilder: (BuildContext context, int index) => const Divider());
}

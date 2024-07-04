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
    final myLocationsBloc = context.read<MyLocationsBloc>();
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
                    child: BlocBuilder<MyLocationsBloc, MyLocationsState>(
                      buildWhen: (previous, current) =>
                          current is MyLocationsSaveAddressState ||
                          current is MyLocationsPickAddressState,
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case MyLocationsSaveAddressState:
                            final success =
                                state as MyLocationsSaveAddressState;
                            return addressMap(success.place,
                                success.initialCameraPosition, context);
                          case MyLocationsPickAddressState:
                            final success =
                                state as MyLocationsPickAddressState;
                            return addressMap(success.place,
                                success.initialCameraPosition, context);
                        }
                        return addressMap(myLocationsBloc.place,
                            myLocationsBloc.initialCameraPosition, context);
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

  Column addressMap(String? place, CameraPosition initialCameraPosition,
      BuildContext context) {
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
              place != null
                  ? CustomText(content: place)
                  : const SizedBox.shrink()
            ]),
            trailing: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => searchAddressBox(context));
                },
                child: Image.asset(Assets.pencil))),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: GestureDetector(
              onTap: () {
                showGeneralDialog(
                    transitionDuration: const Duration(milliseconds: 600),
                    context: context,
                    transitionBuilder: (_, animation, __, child) {
                      Tween<double> scale = Tween(begin: 0, end: 1);
                      return ScaleTransition(
                          scale: scale.animate(CurvedAnimation(
                              parent: animation, curve: Curves.easeInOut)),
                          child: child);
                    },
                    pageBuilder: (_, __, ___) => Stack(
                          children: [
                            mapboxMap(initialCameraPosition, address),
                            SafeArea(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 24, top: 24),
                                child: BackButton(
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll(Colors.white)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            )
                          ],
                        ));
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                      height: 160,
                      child: Stack(
                        children: [
                          MapboxMap(
                            onMapIdle: () {
                              CommonUtils.addCurrentMarker(
                                  initialCameraPosition);
                            },
                            accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                            initialCameraPosition: initialCameraPosition,
                            onMapCreated: CommonUtils.onMapCreated,
                            onStyleLoadedCallback: () {
                              if (CommonUtils.locationCameras(address)
                                  .isNotEmpty) {
                                CommonUtils.onStyleLoadedCallback();
                              }
                            },
                            minMaxZoomPreference:
                                const MinMaxZoomPreference(14, 17),
                          ),
                          Container(color: Colors.transparent, height: 160)
                        ],
                      )))),
        ),
      ],
    );
  }
}

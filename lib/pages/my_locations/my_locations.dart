import 'package:template/source/export.dart';
import 'package:template/widgets/map/bottom_card.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({super.key});

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  @override
  void initState() {
    context.read<MyLocationsBloc>().add(MyLocationsInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyLocationsBloc, MyLocationsState>(
      buildWhen: (previous, current) => current is MyLocationsActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case MyLocationsLoadedState:
            final success = state as MyLocationsLoadedState;
            return myLocationsBody(success.address, context);
          case MyLocationsPickAddressState:
            final success = state as MyLocationsPickAddressState;
            return myLocationsBody(success.address, context);
          case MyLocationsSaveAddressState:
            final success = state as MyLocationsSaveAddressState;
            return myLocationsBody(success.address, context);
          case MyLocationsDrawMapState:
            final success = state as MyLocationsDrawMapState;
            return myLocationsBody(success.address, context);
          case MyLocationsUpdateAddressState:
            final success = state as MyLocationsUpdateAddressState;
            return myLocationsBody(success.address, context);
          case MyLocationsRemoveAddressState:
            final success = state as MyLocationsRemoveAddressState;
            return myLocationsBody(success.address, context);
        }
        return myLocationsBody(address, context);
      },
    );
  }

  Widget myLocationsBody(List<AddressModel> cards, BuildContext context) {
    final myLocationsBloc = context.read<MyLocationsBloc>();
    return Scaffold(
      body: Stack(
        children: [
          mapboxMap(myLocationsBloc.initialCameraPosition, cards),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.17,
                  child: PageView.builder(
                      itemCount: cards.length,
                      scrollDirection: Axis.horizontal,
                      controller: myLocationsBloc.pageController,
                      onPageChanged: (value) {
                        myLocationsBloc
                            .add(MyLocationsDrawMapEvent(index: value));
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) => locationBottomCard(
                                      context, cards[index], index));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Card(
                                clipBehavior: Clip.none,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 24),
                                  child: SingleChildScrollView(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.location_on_outlined),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                  content: cards[index].name,
                                                  fontWeight: FontWeight.bold),
                                              CustomText(
                                                  content:
                                                      cards[index].address),
                                              const SizedBox(height: 5),
                                              CustomText(
                                                  content:
                                                      '${cards[index].distance!.toStringAsFixed(2)}km, ${cards[index].duration!.toStringAsFixed(2)} mins',
                                                  color: Colors.tealAccent)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ));
                      })),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ListTile(
              leading: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: CustomText(
                  content: 'My Locations (${cards.length})',
                  fontWeight: FontWeight.bold),
              trailing: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) => searchAddressBox(context));
                  },
                  child: const CustomText(
                      content: 'Add',
                      fontSize: 13,
                      color: AppColor.globalPink)),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 24, bottom: 180),
        child: FloatingActionButton(
          backgroundColor: AppColor.globalPink,
          onPressed: () {
            CommonUtils.mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                    myLocationsBloc.initialCameraPosition));
          },
          child: const Icon(
            Icons.my_location,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

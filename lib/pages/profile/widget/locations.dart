import 'package:template/source/export.dart';
import 'package:template/widgets/map/bottom_card.dart';
import 'package:template/widgets/map/search_model.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({super.key, this.restaurantLatLng});

  final LatLng? restaurantLatLng;

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  late CameraPosition _initialCameraPosition;
  bool accessed = false;
  final searchController = TextEditingController();
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.85);
  int pageIndex = 0;

  @override
  void initState() {
    _initialCameraPosition =
        CameraPosition(target: widget.restaurantLatLng ?? latLng, zoom: 15);
    super.initState();
  }

  _onMapCreated(MapboxMapController controller) async {
    mapController = controller;
  }

  _addCurrentMarker() async {
    await mapController.addSymbol(
      SymbolOptions(
        geometry: _initialCameraPosition.target,
        iconSize: 0.2,
        iconImage: Assets.currentMarker,
      ),
    );
  }

  // @override
  // void didUpdateWidget(covariant MyLocation oldWidget) {
  //   if (oldWidget.restaurantLatLng != widget.restaurantLatLng){}
  //     super.didUpdateWidget(oldWidget);
  // }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: dataRestaurants,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingAnimationRive();
          }
          List<CameraPosition> restaurantsList = List<CameraPosition>.generate(
              snapshot.data!.length,
              (index) => CameraPosition(
                  target: LatLng(snapshot.data![index]['latitude'],
                      snapshot.data![index]['longitude']),
                  zoom: 15));
          addSourceAndLineLayer(int index, bool removeLayer) async {
            // Can animate camera to focus on the item
            mapController.animateCamera(
                CameraUpdate.newCameraPosition(restaurantsList[index]));

            // Add a polyLine between source and destination
            Map geometry = snapshot.data![index]['geometry'];
            final fills = {
              "type": "FeatureCollection",
              "features": [
                {
                  "type": "Feature",
                  "id": 0,
                  "properties": <String, dynamic>{},
                  "geometry": geometry,
                },
              ],
            };

            // Remove lineLayer and source if it exists
            if (removeLayer == true) {
              await mapController.removeLayer("lines");
              await mapController.removeSource("fills");
            }

            // Add new source and lineLayer
            await mapController.addSource(
                "fills", GeojsonSourceProperties(data: fills));
            await mapController.addLineLayer(
              "fills",
              "lines",
              LineLayerProperties(
                lineColor: Colors.blue.toHexStringRGB(),
                lineCap: "round",
                lineJoin: "round",
                lineWidth: 5,
              ),
            );
            await mapController.addSymbol(
              SymbolOptions(
                geometry: restaurantsList[index].target,
                iconSize: 2,
                iconImage: Assets.marker,
              ),
            );
          }

          onStyleLoadedCallback() async {
            for (CameraPosition kRestaurant in restaurantsList) {
              await mapController.addSymbol(
                SymbolOptions(
                  geometry: kRestaurant.target,
                  iconSize: 2,
                  iconImage: Assets.marker,
                ),
              );
            }
            addSourceAndLineLayer(0, false);
          }

          checkAvailableLatLng() {
            if (restaurantsList.isEmpty) {
              null;
            } else if (widget.restaurantLatLng != null) {
              _addCurrentMarker();
            } else {
              onStyleLoadedCallback();
            }
          }

          return Scaffold(
            body: Stack(
              children: [
                MapboxMap(
                  onMapIdle: _addCurrentMarker,
                  accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                  initialCameraPosition: _initialCameraPosition,
                  onMapCreated: _onMapCreated,
                  onStyleLoadedCallback: () {
                    checkAvailableLatLng();
                  },
                  minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: accessed
                      ? SearchModel(textEditingController: searchController)
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.17,
                              child: PageView.builder(
                                  itemCount: snapshot.data!.length,
                                  scrollDirection: Axis.horizontal,
                                  controller: pageController,
                                  onPageChanged: (value) {
                                    setState(() {
                                      pageIndex = value;
                                      addSourceAndLineLayer(value, true);
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) => BottomCard(
                                                    name: snapshot.data![index]
                                                        ['name'],
                                                    address:
                                                        snapshot.data![index]
                                                            ['address'],
                                                    distance: snapshot
                                                        .data![index]
                                                            ['distance']
                                                        .toStringAsFixed(2),
                                                    duration: snapshot
                                                        .data![index]
                                                            ['duration']
                                                        .toStringAsFixed(2),
                                                    area: snapshot.data![index]
                                                        ['area'],
                                                    city: snapshot.data![index]
                                                        ['city'],
                                                    textEditingController:
                                                        searchController,
                                                  ));
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 16),
                                          child: Card(
                                            clipBehavior: Clip.none,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 24),
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons
                                                        .location_on_outlined),
                                                    const SizedBox(width: 12),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomText(
                                                              content:
                                                                  snapshot.data![
                                                                          index]
                                                                      ['name'],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          CustomText(
                                                              content: snapshot
                                                                          .data![
                                                                      index]
                                                                  ['address']),
                                                          const SizedBox(
                                                              height: 5),
                                                          CustomText(
                                                              content:
                                                                  '${snapshot.data![index]['distance'].toStringAsFixed(2)}km, ${snapshot.data![index]['duration'].toStringAsFixed(2)} mins',
                                                              color: Colors
                                                                  .tealAccent)
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
                        if (accessed) {
                          searchController.clear();
                          setState(() {
                            accessed = !accessed;
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                    title: CustomText(
                        content: accessed
                            ? 'Add Location'
                            : 'My Locations (${snapshot.data!.length})',
                        fontWeight: FontWeight.bold),
                    trailing: accessed
                        ? const SizedBox()
                        : TextButton(
                            onPressed: () {
                              setState(() {
                                accessed = !accessed;
                              });
                            },
                            child: const CustomText(
                                content: 'Add',
                                fontSize: 13,
                                color: AppColor.globalPink)),
                  ),
                ),
              ],
            ),
            floatingActionButton: accessed
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(right: 24, bottom: 180),
                    child: FloatingActionButton(
                      shape: const CircleBorder(),
                      backgroundColor: AppColor.globalPink,
                      onPressed: () {
                        mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                                _initialCameraPosition));
                      },
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                    ),
                  ),
          );
        });
  }
}

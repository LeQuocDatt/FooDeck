import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

class CommonUtils {
  static late MapboxMapController mapController;
  static List<RestaurantModel> sortRestaurant(
      List<RestaurantModel> full, String type) {
    return full.where((restaurant) => restaurant.type == type).toList();
  }

  // phân loại thức ăn theo menu
  static List<FoodModel> sortFood(String foodCategory, List<FoodModel> full) {
    return full.where((food) => food.type == foodCategory).toList();
  }

  static initializeLocationAndSave(BuildContext context) async {
    // Ensure all permissions are collected for Locations
    LocationPermission location;
    await Geolocator.isLocationServiceEnabled();

    location = await Geolocator.checkPermission();
    if (location == LocationPermission.denied) {
      location = await Geolocator.requestPermission();
    } else if (location == LocationPermission.unableToDetermine) {
      location = await Geolocator.requestPermission();
    } else if (location == LocationPermission.deniedForever) {
      location = await Geolocator.requestPermission();
    } else {
      // Get capture the current user location
      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMarks[0];
      SharedPrefs.setString(SharedPrefs.keyUserAddress,
          '${place.street}, ${place.subAdministrativeArea}');
      SharedPrefs.setDouble(SharedPrefs.keyUserLatitude, position.latitude);
      SharedPrefs.setDouble(SharedPrefs.keyUserLongitude, position.longitude);
    }
  }

  static authState() {
    supabase.auth.onAuthStateChange.listen((data) {
      final Session? session = data.session;
      if (session != null) {
        AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.homePage);
      } else if (session == null) {
        AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.loginPage);
      }
    });
  }

  static validateInfoBeforeUpdate(ProfilePageUpdateInfoEvent event) {
    bool check1 = false;
    bool check2 = false;
    bool check3 = false;
    bool check4 = false;
    if (currentUser != null) {
      if (event.name.isEmpty &&
          event.email.isEmpty &&
          event.phone.isEmpty &&
          event.pass.isEmpty &&
          event.imageUrl.isEmpty) {
        customSnackBar(event.context, Toast.error, 'Nothing change');
      } else {
        if (event.name.isEmpty) {
          check1 = true;
        } else {
          check1 = false;
          if (Validation.nameRegex.hasMatch(event.name)) {
            check1 = true;
          }
        }
        if (event.email.isEmpty) {
          check2 = true;
        } else {
          check2 = false;
          if (Validation.emailRegex.hasMatch(event.email)) {
            check2 = true;
          }
        }
        if (event.phone.isEmpty) {
          check3 = true;
        } else {
          check3 = false;
          if (event.phone.length == 10) {
            check3 = true;
          }
        }
        if (event.pass.isEmpty) {
          check4 = true;
        } else {
          check4 = false;
          if (Validation.passRegex.hasMatch(event.pass)) {
            check4 = true;
          }
        }
        if (event.imageUrl.isNotEmpty) {
          currentUser!.avatar = event.imageUrl;
          AsyncFunctions.updateData(
              'users', {'avatar_url': event.imageUrl}, user.id, PopUp.deny);
        }
        if (check1 && check2 && check3 && check4) {
          if (event.name.isNotEmpty) {
            currentUser!.name = event.name;
            AsyncFunctions.updateData(
                'users', {'full_name': event.name}, user.id, PopUp.deny);
          }
          if (event.email.isNotEmpty) {
            currentUser!.email = event.email;
            AsyncFunctions.updateData(
                'users', {'email': event.email}, user.id, PopUp.deny);
          }
          if (event.phone.isNotEmpty) {
            currentUser!.phone = event.phone;
            AsyncFunctions.updateData(
                'users', {'phone': event.phone}, user.id, PopUp.deny);
          }
          if (event.pass.isNotEmpty) {
            currentUser!.pass = event.pass;
            AsyncFunctions.updateData(
                'users', {'password': event.pass}, user.id, PopUp.deny);
          }
          customSnackBar(event.context, Toast.success, 'Profile updated ');
        } else {
          customSnackBar(event.context, Toast.error, 'Error! Please retry');
        }
      }
    } else {
      customSnackBar(event.context, Toast.error, 'Connection Fail');
    }
  }

  static toggleSave(ExplorePageLikeEvent event) {
    if (event.saveFood.like == false) {
      event.saveFood.like = true;
      AsyncFunctions.updateData(
          'restaurants', {'like': true}, event.saveFood.id, PopUp.deny);
    } else {
      event.saveFood.like = false;
      AsyncFunctions.updateData(
          'restaurants', {'like': false}, event.saveFood.id, PopUp.deny);
    }
  }

  static toggleLike(ExplorePageLikeState state, BuildContext context) {
    if (state.restaurantModel.like) {
      customSnackBar(context, Toast.success, 'You just liked this item');
    } else {
      customSnackBar(context, Toast.error, 'You just unliked this item');
    }
  }

  static sendReview(BuildContext context, String review, double rate) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (review.isEmpty) {
      customSnackBar(
          context, Toast.error, 'It\'s empty, Please leave a comment');
    } else {
      await AsyncFunctions.insertData(
          'reviews',
          {
            'restaurant_image': restaurantModel.image,
            'restaurant_name': restaurantModel.shopName,
            'time': restaurantModel.deliveryTime,
            'place': restaurantModel.address,
            'vote': restaurantModel.rate,
            'my_vote': rate,
            'my_review': review,
            'restaurant_id': restaurantModel.id
          },
          PopUp.allow,
          context,
          'Review Sent');
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  static addToCart(
      BuildContext context, String turnOn, String note, int totalPrice) {
    final restaurantAddonBloc = context.read<RestaurantAddonBloc>();
    FocusManager.instance.primaryFocus?.unfocus();
    String size = addons.where((element) => element.type == turnOn).single.size;
    List<String> currentSelect = [];
    for (var element in addons) {
      element.like == true
          ? currentSelect.add(element.addonName)
          : currentSelect.add('');
    }
    CartItemModel? cart = cartItems.firstWhereOrNull((element) {
      bool isSameFood = element.foodImage == foodModel.foodImage;
      bool isSameNote = element.note == note;
      bool isSameSize = element.size == size;
      bool isSameAddon = element.selectAddon == currentSelect.join(' ');
      return isSameFood && isSameNote && isSameSize && isSameAddon;
    });
    if (cart != null) {
      showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: const CustomText(
                    content: 'Are you want to increase quantity?',
                    textOverflow: TextOverflow.visible),
                actions: [
                  CupertinoDialogAction(
                      onPressed: () {
                        cart.quantity += restaurantAddonBloc.quantity;
                        cart.price += totalPrice;
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRouter.restaurantCart);
                      },
                      child: const CustomText(content: 'Yes')),
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const CustomText(content: 'No')),
                ],
              ));
    } else {
      cartItems.add(CartItemModel(
          note: note,
          foodName: foodModel.foodName,
          size: size,
          price: totalPrice,
          selectAddon: currentSelect.join(' '),
          quantity: restaurantAddonBloc.quantity,
          foodImage: foodModel.foodImage));
      Navigator.pushNamed(context, AppRouter.restaurantCart);
    }
  }

  static onMapCreated(MapboxMapController controller) async {
    mapController = controller;
  }

  static addCurrentMarker(CameraPosition initialCameraPosition) async {
    await mapController.addSymbol(
      SymbolOptions(
        geometry: initialCameraPosition.target,
        iconSize: 0.2,
        iconImage: Assets.currentMarker,
      ),
    );
  }

  static List<CameraPosition> locationCameras(List<AddressModel> listCamera) {
    return List<CameraPosition>.generate(
        listCamera.length,
        (index) => CameraPosition(
            target:
                LatLng(listCamera[index].latitude, listCamera[index].longitude),
            zoom: 15));
  }

  static addSourceAndLineLayer(
      int index, List<AddressModel> listCamera, bool removeLayer) async {
    if (listCamera.isNotEmpty) {
      // Can animate camera to focus on the item
      mapController.animateCamera(
          CameraUpdate.newCameraPosition(locationCameras(listCamera)[index]));
      // Add a polyLine between source and destination
      Map geometry = address[index].geometry!;
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
      await mapController.addSymbol(SymbolOptions(
          geometry: locationCameras(listCamera)[index].target,
          iconSize: 2,
          iconImage: Assets.marker));
    } else {
      await mapController.removeLayer("lines");
      await mapController.removeSource("fills");
      await mapController.clearSymbols();
    }
  }

  static onStyleLoadedCallback() async {
    for (CameraPosition kRestaurant in locationCameras(address)) {
      await mapController.addSymbol(
        SymbolOptions(
          geometry: kRestaurant.target,
          iconSize: 2,
          iconImage: Assets.marker,
        ),
      );
    }
    addSourceAndLineLayer(0, address, false);
  }

  static Future moveCamera(int index, List<AddressModel> tempAddress) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: tempAddress[index].location, zoom: 15)));
    await mapController.addSymbol(
      SymbolOptions(
        geometry: tempAddress[index].location,
        iconSize: 2,
        iconImage: Assets.marker,
      ),
    );
  }

  static logOut(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Are you sure want to logout?'),
        actions: [
          TextButton(
              onPressed: () {
                AsyncFunctions.logOut();
              },
              child: const CustomText(content: 'Yes', color: Colors.red)),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const CustomText(content: 'No', color: Colors.blue))
        ],
      ),
    );
  }

  static checkPageToNavigate(String index, BuildContext context) {
    switch (index) {
      case 'Edit Account':
        Navigator.pushNamed(context, AppRouter.editAccount);
        break;
      case 'My Locations':
        Navigator.pushNamed(context, AppRouter.myLocation);
        break;
      case 'My Orders':
        Navigator.pushNamed(context, AppRouter.myOrders);
        break;
      case 'Payment Methods':
        Navigator.pushNamed(context, AppRouter.paymentMethods);
        break;
      case 'My Reviews':
        Navigator.pushNamed(context, AppRouter.myReviews);
        break;
      case 'About Us':
        customSnackBar(context, Toast.error, 'In Updating...');
        break;
      case 'Data Usage':
        customSnackBar(context, Toast.error, 'In Updating...');
        break;
      case 'Light Mode':
        break;
      case 'Log Out':
        logOut(context);
        break;
    }
  }
}

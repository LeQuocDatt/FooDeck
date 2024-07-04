import 'package:intl/intl.dart';
import 'package:template/source/export.dart';

final supabase = Supabase.instance.client;
final user = supabase.auth.currentUser!;

enum PopUp { allow, deny }

class AsyncFunctions {
  static insertData(String table, Map<String, dynamic> info, PopUp show,
      [BuildContext? context, String? message]) async {
    try {
      await supabase.from(table).insert(info).then((value) =>
          show == PopUp.allow
              ? customSnackBar(context!, Toast.success, message!)
              : null);
    } catch (e) {
      if (context!.mounted) {
        show == PopUp.allow
            ? customSnackBar(context, Toast.error, e.toString())
            : Future.error(e.toString());
      }
    }
  }

  static updateData(
      String table, Map<String, dynamic> update, String id, PopUp show,
      [BuildContext? context, String? message]) async {
    try {
      await supabase.from(table).update(update).eq('id', id).select().then(
          (value) => show == PopUp.allow
              ? customSnackBar(context!, Toast.success, message!)
              : null);
    } catch (e) {
      if (context!.mounted) {
        show == PopUp.allow
            ? customSnackBar(context, Toast.error, e.toString())
            : Future.error(e.toString());
      }
    }
  }

  static deleteData(String table, String id, PopUp show,
      [BuildContext? context, String? message]) async {
    try {
      await supabase.from(table).delete().eq('id', id).select().then((value) =>
          show == PopUp.allow
              ? customSnackBar(context!, Toast.error, message!)
              : null);
    } catch (e) {
      if (context!.mounted) {
        show == PopUp.allow
            ? customSnackBar(context, Toast.error, e.toString())
            : Future.error(e.toString());
      }
    }
  }

  static updateUser(
      {Object? data,
      String? email,
      String? phone,
      String? password,
      BuildContext? context}) async {
    try {
      await supabase.auth.updateUser(UserAttributes(
          data: data, email: email, phone: phone, password: password));
    } on AuthException catch (e) {
      if (context == null) {
        Future.error(e.message);
      } else {
        if (context.mounted) {
          customSnackBar(context, Toast.error, e.message);
        }
      }
    } catch (e) {
      if (context == null) {
        Future.error(e.toString());
      } else {
        if (context.mounted) {
          customSnackBar(context, Toast.error, 'Error! Please retry');
        }
      }
    }
  }

  static Future<void> addUserDataToLocalStorage() async {
    Map<String, dynamic> userData = {};
    try {
      userData =
          await supabase.from('users').select().eq('id', user.id).single();
    } catch (e) {
      Future.error(e.toString());
    }
    if (userData.isNotEmpty) {
      currentUser = UserModel(
          email: userData['email'],
          phone: userData['phone'],
          name: userData['full_name'],
          pass: userData['password'],
          avatar: userData['avatar_url'],
          address: userData['address'],
          latitude: userData['latitude'],
          longitude: userData['longitude']);
    }
  }

  static Future<void> addRestaurantDataToLocalStorage() async {
    List<Map<String, dynamic>> restaurantData = [];
    try {
      restaurantData = await supabase.from('restaurants').select();
    } catch (e) {
      Future.error(e.toString());
    }
    if (restaurantData.isNotEmpty) {
      restaurants = restaurantData
          .map((e) => RestaurantModel(
              like: e['like'],
              image: e['image'],
              deliveryTime: e['time_delivery'],
              shopName: e['shop_name'],
              address: e['address'],
              rate: e['rate'],
              type: e['type'],
              id: e['id']))
          .toList();
    }
  }

  static Future<void> addOrderCompleteDataToLocalStorage() async {
    List<Map<String, dynamic>> orderCompleteData = [];
    try {
      orderCompleteData =
          await supabase.from('order_complete').select().eq('user_id', user.id);
    } catch (e) {
      Future.error(e.toString());
    }
    if (orderCompleteData.isNotEmpty) {
      orderCompletes = orderCompleteData
          .map((e) => OrderCompleteModel(
              restaurantName: e['restaurant_name'],
              date: e['date'],
              address: e['address'],
              note: e['note'],
              id: e['id'],
              subPrice: e['sub_price'],
              deliveryFee: e['delivery_fee'],
              vat: e['vat'],
              coupon: e['coupon'],
              totalPrice: e['total_price'],
              userId: e['user_id']))
          .toList();
    }
  }

  static Future<void> addLocationDataToLocalStorage() async {
    List<Map<String, dynamic>> locationData = [];
    try {
      locationData =
          await supabase.from('locations').select().eq('user_id', user.id);
    } catch (e) {
      Future.error(e.toString());
    }
    if (locationData.isNotEmpty) {
      address = locationData
          .map((e) => AddressModel(
              id: e['id'],
              name: e['name'],
              address: e['address'],
              area: e['area'],
              dist: e['dist'],
              city: e['city'],
              latitude: e['latitude'],
              longitude: e['longitude'],
              location: LatLng(e['latitude'], e['longitude']),
              distance: e['distance'],
              duration: e['duration'],
              geometry: e['geometry'],
              userId: e['user_id']))
          .toList();
    }
  }

  static Future<void> addCardDataToLocalStorage() async {
    List<Map<String, dynamic>> cardData = [];
    try {
      cardData = await supabase.from('card').select().eq('user_id', user.id);
    } catch (e) {
      Future.error(e.toString());
    }
    if (cardData.isNotEmpty) {
      payments = cardData
          .map((e) => PaymentModel(
              id: e['id'],
              cardName: e['card_name'],
              cardNumber: e['card_number'],
              expiryDate: e['expiry_date'],
              cvc: e['cvc'],
              userId: e['user_id']))
          .toList();
    }
  }

  static Future<void> addCartItemCompleteDataToLocalStorage() async {
    List<Map<String, dynamic>> cartItemData = [];
    try {
      cartItemData = await supabase
          .from('cart_items')
          .select()
          .eq('order_complete_id', orderCompleteModel.id);
    } catch (e) {
      Future.error(e.toString());
    }
    if (cartItemData.isNotEmpty) {
      completeCartItems = cartItemData
          .map((e) => CompleteCartItemModel(
              price: e['price'],
              quantity: e['quantity'],
              foodName: e['food_name'],
              note: e['note'],
              orderCompleteId: e['order_complete_id'],
              id: e['id']))
          .toList();
    }
  }

  static Future<void> addFoodDataToLocalStorage() async {
    List<Map<String, dynamic>> foodData = [];
    try {
      foodData = await supabase.from('foods').select();
    } catch (e) {
      Future.error(e.toString());
    }
    if (foodData.isNotEmpty) {
      foods = foodData
          .map((e) => FoodModel(
              like: e['like'],
              foodImage: e['food_image'],
              foodName: e['food_name'],
              detail: e['detail'],
              type: e['type'],
              price: e['price'],
              id: e['id']))
          .toList();
    }
  }

  static Future<void> addAddonDataToLocalStorage() async {
    List<Map<String, dynamic>> addonData = [];
    try {
      addonData = await supabase.from('addons').select();
    } catch (e) {
      Future.error(e.toString());
    }
    if (addonData.isNotEmpty) {
      addons = addonData
          .map((e) => AddonModel(
              type: e['type'],
              like: e['like'],
              addonName: e['addon_name'],
              size: e['size'],
              sizePrice: e['size_price'],
              addonPrice: e['addon_price'],
              id: e['id']))
          .toList();
    }
  }

  static Future addOrderToDatabase(String note, String place) async {
    await AsyncFunctions.insertData(
        'order_complete',
        {
          'restaurant_name': restaurantModel.shopName,
          'sub_price': totalPrice,
          'delivery_fee': deliveryFee,
          'vat': vat,
          'coupon': coupon,
          'total_price': bill,
          'date': DateFormat('dd MMM, yyyy').format(DateTime.now()),
          'address': place,
          'note': note,
          'user_id': user.id
        },
        PopUp.deny);
    await AsyncFunctions.addOrderCompleteDataToLocalStorage();
    for (var cartItem in cartItems) {
      await AsyncFunctions.insertData(
          'cart_items',
          {
            'food_name': cartItem.foodName,
            'price': cartItem.price,
            'quantity': cartItem.quantity,
            'note': cartItem.note,
            'order_complete_id': orderCompletes.last.id
          },
          PopUp.deny);
    }
    await AsyncFunctions.addCartItemCompleteDataToLocalStorage();
    cartItems.clear();
  }

  static Future saveAddress(
      AddressModel tempAddress, BuildContext context) async {
    if (address.any((element) => element.location == tempAddress.location)) {
      customSnackBar(context, Toast.error, 'You already had this address');
    } else {
      Map modifiedResponse = await getDirectionsAPIResponse(
          SharedPrefs.userLocation(), tempAddress.location);
      // Calculate the distance and time
      num distance = modifiedResponse['distance'] / 1000;
      num duration = modifiedResponse['duration'] / 60;
      if (context.mounted) {
        await AsyncFunctions.insertData(
            'locations',
            {
              'name': tempAddress.name,
              'address': tempAddress.address,
              'dist': tempAddress.dist,
              'area': tempAddress.area,
              'city': tempAddress.city,
              'latitude': tempAddress.latitude,
              'longitude': tempAddress.longitude,
              'distance': distance,
              'duration': duration,
              'geometry': modifiedResponse['geometry'],
              'user_id': user.id
            },
            PopUp.allow,
            context,
            'This address was saved');
        await AsyncFunctions.addLocationDataToLocalStorage();
      }
    }
  }

  static Future updateAddress(AddressModel tempAddress, AddressModel addressId,
      BuildContext context) async {
    if (address.any((element) => element.location == tempAddress.location)) {
      customSnackBar(context, Toast.error, 'You already had this address');
    } else {
      Map modifiedResponse = await getDirectionsAPIResponse(
          SharedPrefs.userLocation(), tempAddress.location);
      // Calculate the distance and time
      num distance = modifiedResponse['distance'] / 1000;
      num duration = modifiedResponse['duration'] / 60;
      if (context.mounted) {
        await AsyncFunctions.updateData(
            'locations',
            {
              'name': tempAddress.name,
              'address': tempAddress.address,
              'area': tempAddress.area,
              'city': tempAddress.city,
              'latitude': tempAddress.latitude,
              'longitude': tempAddress.longitude,
              'distance': distance,
              'duration': duration,
              'geometry': modifiedResponse['geometry']
            },
            addressId.id,
            PopUp.allow,
            context,
            'Address updated');
        await AsyncFunctions.addLocationDataToLocalStorage();
      }
    }
  }

  static logOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      Future.error(e.toString());
    }
  }
}

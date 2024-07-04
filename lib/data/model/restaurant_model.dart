class RestaurantModel {
  String image, shopName, address, type, id;
  num deliveryTime, rate;
  bool like;

  RestaurantModel(
      {required this.like,
      required this.image,
      required this.deliveryTime,
      required this.shopName,
      required this.address,
      required this.rate,
      required this.type,
      required this.id});
}

List<RestaurantModel> restaurants = [];
late RestaurantModel restaurantModel;

class FoodModel {
  final String foodImage, foodName, detail, type;
  final String? id, restaurantId;
  final int price;
  bool like;

  FoodModel(
      {required this.like,
      required this.foodImage,
      required this.foodName,
      required this.detail,
      required this.type,
      this.id,
      this.restaurantId,
      required this.price});
}

List<FoodModel> foods = [];
late FoodModel foodModel;

List<String> type = ['Popular', 'Deals', 'Wraps', 'Beverages', 'Sandwiches'];

class AddonModel {
  final String addonName, size, type;
  final String? id, foodId;
  final int sizePrice, addonPrice;
  bool like;

  AddonModel(
      {this.id,
      this.foodId,
      required this.type,
      required this.like,
      required this.addonName,
      required this.size,
      required this.sizePrice,
      required this.addonPrice});
}

List<AddonModel> addons = [];

class OrderHistory {
  final String restaurantName, date;
  final List res;
  final int subPrice, deliveryFee, vat, coupon, totalPrice;

  OrderHistory(this.subPrice, this.deliveryFee, this.vat, this.coupon,
      this.totalPrice, this.date, this.res, this.restaurantName);
}

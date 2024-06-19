class RestaurantModel {
  final String image, shopName, address;
  final num deliveryTime, rate;
  final TitleFood titleFood;
  final List<FoodItems> foodItems;

  RestaurantModel(
      {required this.image,
      required this.deliveryTime,
      required this.shopName,
      required this.address,
      required this.rate,
      required this.titleFood,
      required this.foodItems});
}

enum TitleFood { Deals, Explore, Recent }

class FoodItems {
  final String picture, nameFood, detail, place;
  final int price;
  final FoodCategory foodCategory;
  int quantityFood;
  List<Addon> availableAddons;

  FoodItems(
      {this.quantityFood = 1,
      required this.place,
      required this.picture,
      required this.nameFood,
      required this.detail,
      required this.price,
      required this.foodCategory,
      required this.availableAddons});
}

enum FoodCategory { Popular, Deals, Wraps, Beverages, Sandwiches }

class Addon {
  final String addonName, size;
  final int priceSize, price;
  bool like;
  RadioType radio;

  Addon(
      {this.like = false,
      required this.radio,
      required this.addonName,
      required this.size,
      required this.priceSize,
      required this.price});
}

enum RadioType { a, b, c }

class CartItems {
  CartItems(
      {required this.foodItems,
      required this.size,
      required this.price,
      required this.selectAddon,
      required this.note,
      this.quantity = 1});

  final FoodItems foodItems;
  final String size, note;
  final List<String> selectAddon;
  int price, quantity;
}

class OrderHistory {
  final String restaurantName, date;
  final List res;
  final int subPrice, deliveryFee, vat, coupon, totalPrice;

  OrderHistory(this.subPrice, this.deliveryFee, this.vat, this.coupon,
      this.totalPrice, this.date, this.res, this.restaurantName);
}

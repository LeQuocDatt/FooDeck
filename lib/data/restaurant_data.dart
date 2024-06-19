import 'package:template/source/export.dart';

class RestaurantData {
  static late RestaurantModel restaurantModel;
  static late FoodItems food;
  static late Addon addon;
  static List<RestaurantModel> restaurant = [
    RestaurantModel(
        image: Assets.dailyDeli,
        deliveryTime: 40,
        shopName: 'Daily Deli',
        address: 'Johar Town',
        rate: 4.8,
        titleFood: TitleFood.Deals,
        foodItems: foodItems),
    RestaurantModel(
        image: Assets.riceBowl,
        deliveryTime: 12,
        shopName: 'Rice Bowl',
        address: 'Wapda Town',
        rate: 4.8,
        titleFood: TitleFood.Deals,
        foodItems: foodItems),
    RestaurantModel(
        image: Assets.healthyFood,
        deliveryTime: 25,
        shopName: 'Healthy Food',
        address: 'Grand Town',
        rate: 4.4,
        titleFood: TitleFood.Deals,
        foodItems: foodItems),
    RestaurantModel(
        image: Assets.indonesianFood,
        deliveryTime: 30,
        shopName: 'Indonesian Food',
        address: 'Rolan Town',
        rate: 5,
        titleFood: TitleFood.Deals,
        foodItems: foodItems),
    RestaurantModel(
        image: Assets.coffee,
        deliveryTime: 15,
        shopName: 'Coffee',
        address: 'Mid Town',
        rate: 4.7,
        titleFood: TitleFood.Deals,
        foodItems: foodItems),
    RestaurantModel(
        image: Assets.cake,
        deliveryTime: 40,
        shopName: 'Jean’s Cakes',
        address: 'Johar Town',
        rate: 4.8,
        titleFood: TitleFood.Explore,
        foodItems: foodItems),
    RestaurantModel(
        image: Assets.chocolate,
        deliveryTime: 20,
        shopName: 'Thicc Shakes',
        address: 'Wapda Town',
        rate: 4.5,
        titleFood: TitleFood.Explore,
        foodItems: foodItems),
    RestaurantModel(
        image: Assets.panCake,
        deliveryTime: 30,
        shopName: 'Daily Deli',
        address: 'Garden Town',
        rate: 4.8,
        titleFood: TitleFood.Explore,
        foodItems: foodItems),
    RestaurantModel(
        image: Assets.burger,
        deliveryTime: 38,
        shopName: 'Burger King',
        address: 'Mappa Town',
        rate: 3.3,
        titleFood: TitleFood.Recent,
        foodItems: foodItems),
    RestaurantModel(
        image: Assets.crepe,
        deliveryTime: 42,
        shopName: 'Wrap Factory',
        address: 'Kenny Town',
        rate: 4.3,
        titleFood: TitleFood.Recent,
        foodItems: foodItems),
  ];
  static List<FoodItems> foodItems = [
    FoodItems(
        picture: Assets.pizza,
        nameFood: 'Chicken Fajita Pizza',
        detail: '8” pizza with regular soft drink',
        price: 10,
        place: 'Daily Deli - Johar Town',
        foodCategory: FoodCategory.Popular,
        availableAddons: addonItems),
    FoodItems(
        picture: Assets.friedChicken,
        nameFood: 'Chicken Fajita Pizza',
        detail: '8” pizza with regular soft drink',
        price: 10,
        place: 'Daily Deli - Johar Town',
        foodCategory: FoodCategory.Popular,
        availableAddons: addonItems),
    FoodItems(
        picture: Assets.coffeeMilk,
        nameFood: 'Deal 1',
        detail: '1 regular burger with\ncroquette and hot cocoa',
        price: 12,
        place: 'Daily Deli - Johar Town',
        foodCategory: FoodCategory.Deals,
        availableAddons: addonItems),
    FoodItems(
        picture: Assets.hamburger,
        nameFood: 'Deal 2',
        detail: '1 regular burger with\nsmall fries',
        price: 6,
        place: 'Daily Deli - Johar Town',
        foodCategory: FoodCategory.Deals,
        availableAddons: addonItems),
    FoodItems(
        picture: Assets.desert,
        nameFood: 'Deal 3',
        detail: '2 pieces of beef stew with\nhomemade sauce',
        price: 23,
        place: 'Daily Deli - Johar Town',
        foodCategory: FoodCategory.Deals,
        availableAddons: addonItems),
    FoodItems(
        picture: Assets.redGrape,
        price: 18,
        nameFood: 'Red Grape Margarita',
        place: 'Daily Deli',
        detail: '',
        foodCategory: FoodCategory.Beverages,
        availableAddons: addonItems),
    FoodItems(
        picture: Assets.lemonade,
        price: 12,
        nameFood: 'Lemon Pina Colada',
        place: 'Arfan Juices',
        detail: '',
        foodCategory: FoodCategory.Beverages,
        availableAddons: addonItems),
  ];
  static List<Addon> addonItems = [
    Addon(
        addonName: 'Texas Barbeque',
        size: '8"',
        priceSize: 10,
        price: 6,
        radio: RadioType.a),
    Addon(
        addonName: 'Char Donay',
        size: '10"',
        priceSize: 12,
        price: 8,
        radio: RadioType.b),
    Addon(
        addonName: '', size: '12"', priceSize: 16, price: 0, radio: RadioType.c)
  ];
}

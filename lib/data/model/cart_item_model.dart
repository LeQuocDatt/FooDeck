class CartItemModel {
  final String foodImage, foodName, size, note, selectAddon;
  int price, quantity;

  CartItemModel(
      {required this.foodImage,
      required this.price,
      required this.quantity,
      required this.foodName,
      required this.size,
      required this.note,
      required this.selectAddon});
}

List<CartItemModel> cartItems = [];

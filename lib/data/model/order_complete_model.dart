class OrderCompleteModel {
  final String restaurantName, date, address, note, id, userId;
  final num subPrice, deliveryFee, vat, coupon, totalPrice;

  OrderCompleteModel(
      {required this.userId,
      required this.restaurantName,
      required this.date,
      required this.address,
      required this.note,
      required this.id,
      required this.subPrice,
      required this.deliveryFee,
      required this.vat,
      required this.coupon,
      required this.totalPrice});
}

List<OrderCompleteModel> orderCompletes = [];
late OrderCompleteModel orderCompleteModel;

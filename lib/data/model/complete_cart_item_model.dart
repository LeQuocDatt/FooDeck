class CompleteCartItemModel {
  final String foodName, note, id, orderCompleteId;
  final int price, quantity;

  CompleteCartItemModel(
      {required this.foodName,
      required this.note,
      required this.id,
      required this.orderCompleteId,
      required this.price,
      required this.quantity});
}

List<CompleteCartItemModel> completeCartItems = [];

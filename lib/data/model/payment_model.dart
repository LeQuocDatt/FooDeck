class PaymentModel {
  final String cardName, cardNumber, expiryDate, cvc, id, userId;

  PaymentModel(
      {required this.id,
      required this.userId,
      required this.cardName,
      required this.cardNumber,
      required this.expiryDate,
      required this.cvc});
}

List<PaymentModel> payments = [];

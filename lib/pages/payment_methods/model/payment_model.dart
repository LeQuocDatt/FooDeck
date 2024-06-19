class PaymentModel {
  final String cardName, cardNumber, expiryDate, cvc;

  PaymentModel(
      {required this.cardName,
      required this.cardNumber,
      required this.expiryDate,
      required this.cvc});
}

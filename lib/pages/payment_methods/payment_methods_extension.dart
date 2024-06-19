part of 'payment_methods.dart';

class PaymentMethodBody extends StatelessWidget {
  const PaymentMethodBody({super.key, required this.paymentModel});
  final List<PaymentModel> paymentModel;

  @override
  Widget build(BuildContext context) {
    final paymentMethodsBloc = context.read<PaymentMethodsBloc>();
    return SingleChildScrollView(
        child: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: CustomSlidePage(
                currentCard: paymentMethodsBloc.currentCard,
                itemCount: paymentModel.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CreditCard(
                          cardName: paymentModel[index].cardName,
                          cardType:
                              paymentModel[index].cardNumber.startsWith('4')
                                  ? CardType.visa
                                  : CardType.master,
                          cardNumber: paymentModel[index].cardNumber));
                }),
          ),
          Expanded(
            flex: 2,
            child: ValueListenableBuilder(
              valueListenable: paymentMethodsBloc.currentCard,
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      cardInfo('Card Name', paymentModel[value].cardName),
                      cardInfo('Card Number', paymentModel[value].cardNumber),
                      cardInfo('Expiry Date', paymentModel[value].expiryDate),
                      cardInfo('CVC/CVV', paymentModel[value].cvc),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: CustomButton(
                            onPressed: () {
                              paymentMethodsBloc.add(
                                  PaymentMethodsRemoveCardEvent(
                                      context: context,
                                      paymentModel: paymentModel[value]));
                            },
                            content: 'Remove Card',
                            color: AppColor.globalPink),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    ));
  }

  Widget cardInfo(String title, String info) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          height: 74,
          width: double.maxFinite,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  content: title,
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
              CustomText(content: info)
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}

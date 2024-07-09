import 'package:template/source/export.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  @override
  void initState() {
    context.read<PaymentMethodsBloc>().add(PaymentMethodsInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paymentMethodsBloc = context.read<PaymentMethodsBloc>();
    return Scaffold(
      appBar: AppBar(
        shape: const UnderlineInputBorder(
            borderSide: BorderSide(width: 8, color: AppColor.dividerGrey)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(
                content: 'Payment Method', fontWeight: FontWeight.bold),
            IconButton(
                onPressed: () {
                  paymentMethodsBloc
                      .add(PaymentMethodsNavigateToCreateCardEvent());
                },
                icon: const Icon(Icons.add))
          ],
        ),
      ),
      body: BlocBuilder<PaymentMethodsBloc, PaymentMethodsState>(
        buildWhen: (previous, current) => current is PaymentMethodsActionState,
        builder: (context, state) {
          return payments.isEmpty
              ? const CustomCreditCardAnimationRive()
              : SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 24, 10, 30),
                            child: CustomSlidePage(
                                currentCard: paymentMethodsBloc.currentCard,
                                itemCount: payments.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 24),
                                    child: CreditCard(
                                        cardName: payments[index].cardName,
                                        cardType: payments[index]
                                                .cardNumber
                                                .startsWith('4')
                                            ? CardType.visa
                                            : CardType.master,
                                        cardNumber: payments[index].cardNumber),
                                  );
                                }),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ValueListenableBuilder(
                            valueListenable: paymentMethodsBloc.currentCard,
                            builder: (context, value, child) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Column(
                                  children: [
                                    cardInfo(
                                        'Card Name', payments[value].cardName),
                                    cardInfo('Card Number',
                                        payments[value].cardNumber),
                                    cardInfo('Expiry Date',
                                        payments[value].expiryDate),
                                    cardInfo('CVC/CVV', payments[value].cvc),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: CustomButton(
                                          onPressed: () {
                                            paymentMethodsBloc.add(
                                                PaymentMethodsRemoveCardEvent(
                                                    context: context,
                                                    paymentModel:
                                                        payments[value]));
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
                  ),
                );
        },
      ),
    );
  }

  Widget cardInfo(String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
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
    );
  }
}

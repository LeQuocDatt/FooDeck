import 'package:template/source/export.dart';

class DetailHistoryOrder extends StatelessWidget {
  final OrderCompleteModel orderCompleteModel;

  const DetailHistoryOrder({super.key, required this.orderCompleteModel});

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
              CustomText(
                  content: orderCompleteModel.restaurantName,
                  fontWeight: FontWeight.bold),
              CustomText(
                  content: orderCompleteModel.date,
                  fontSize: 13,
                  color: Colors.grey)
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.only(left: 24, top: 24, bottom: 8),
                  child: CustomText(
                      content: 'Order Summary',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: completeCartItems.length * 80,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: completeCartItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, left: 24, right: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                  content:
                                      '${completeCartItems[index].quantity}x ${completeCartItems[index].foodName}'),
                              CustomText(
                                  content:
                                      '\$${completeCartItems[index].price}')
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Divider(color: Colors.grey[300]),
                        )
                      ],
                    );
                  },
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(content: 'Subtotal'),
                        CustomText(content: '\$${orderCompleteModel.subPrice}')
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey[300]),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(content: 'Delivery Fee'),
                        CustomText(
                            content: '\$${orderCompleteModel.deliveryFee}')
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey[300]),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(content: 'VAT'),
                        CustomText(content: '\$${orderCompleteModel.vat}')
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey[300]),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 24, right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            CustomText(content: 'Coupon '),
                            CustomText(
                                content: '(GREELOGIX)', color: Colors.grey)
                          ],
                        ),
                        CustomText(
                            content: '-\$${orderCompleteModel.coupon}',
                            color: Colors.green)
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(
                  thickness: 8,
                  color: AppColor.dividerGrey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                        content: 'Delivery Address',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                        content: orderCompleteModel.address,
                        textOverflow: TextOverflow.visible)
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(
                  thickness: 8,
                  color: AppColor.dividerGrey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                        content: 'Delivery Instructions',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                        content: orderCompleteModel.note, color: Colors.grey)
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(
                  thickness: 8,
                  color: AppColor.dividerGrey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                        content: 'Payment Method',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 40),
                        child: BlocBuilder<PaymentMethodsBloc,
                            PaymentMethodsState>(
                          buildWhen: (previous, current) =>
                              current is PaymentMethodsActionState,
                          builder: (context, state) {
                            return payments.isEmpty
                                ? Container(
                                    height: 200,
                                    alignment: Alignment.center,
                                    child: TextButton.icon(
                                        onPressed: null,
                                        label: const CustomText(
                                            content: 'Pay By Cash'),
                                        icon: const Icon(Icons.attach_money)),
                                  )
                                : SizedBox(
                                    height: 200,
                                    child: CustomSlidePage(
                                        currentCard:
                                            paymentMethodsBloc.currentCard,
                                        itemCount: payments.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 24),
                                              child: CreditCard(
                                                  cardName:
                                                      payments[index].cardName,
                                                  cardType: payments[index]
                                                          .cardNumber
                                                          .startsWith('4')
                                                      ? CardType.visa
                                                      : CardType.master,
                                                  cardNumber: payments[index]
                                                      .cardNumber));
                                        }),
                                  );
                          },
                        )),
                    Center(
                      child: CustomButton(
                          onPressed: () {},
                          content: 'Cancel Order',
                          color: AppColor.globalPink),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

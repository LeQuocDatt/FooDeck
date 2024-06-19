import 'package:template/source/export.dart';

class DetailHistoryOrder extends StatefulWidget {
  const DetailHistoryOrder({super.key, required this.res});

  final Map<String, dynamic> res;

  @override
  State<DetailHistoryOrder> createState() => _DetailHistoryOrderState();
}

class _DetailHistoryOrderState extends State<DetailHistoryOrder> {
  @override
  Widget build(BuildContext context) {
    final dataOrders = supabase
        .from('orders')
        .stream(primaryKey: ['order_complete_id']).eq(
            'order_complete_id', widget.res['id']);
    return StreamBuilder(
        stream: dataOrders,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingAnimationRive();
          }
          return Scaffold(
              appBar: AppBar(
                shape: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 8, color: AppColor.dividerGrey)),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        content: widget.res['restaurant_name'],
                        fontWeight: FontWeight.bold),
                    CustomText(
                        content: widget.res['date'],
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
                      height: snapshot.data!.length * 80,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, left: 24, right: 24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        content:
                                            '${snapshot.data![index]['quantity']}x ${snapshot.data![index]['food_name']}'),
                                    CustomText(
                                        content:
                                            '\$${snapshot.data![index]['price']}')
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
                              CustomText(
                                  content: '\$${widget.res['sub_price']}')
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
                                  content: '\$${widget.res['delivery_fee']}')
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
                              CustomText(content: '\$${widget.res['vat']}')
                            ],
                          ),
                        ),
                        Divider(color: Colors.grey[300]),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, left: 24, right: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  CustomText(content: 'Coupon '),
                                  CustomText(
                                      content: '(GREELOGIX)',
                                      color: Colors.grey)
                                ],
                              ),
                              CustomText(
                                  content: '-\$${widget.res['coupon']}',
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
                          CustomText(content: widget.res['address'])
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
                              content: widget.res['note'], color: Colors.grey)
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
                            child: Container(
                              height: 210,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Assets.creditCard),
                                      fit: BoxFit.cover)),
                            ),
                          ),
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
        });
  }
}

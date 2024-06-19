import 'package:template/source/export.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary(
      {super.key,
      required this.res,
      required this.subPrice,
      required this.deliveryFee,
      required this.vat,
      required this.coupon});

  final List res;
  final int subPrice;
  final int deliveryFee;
  final int vat;
  final int coupon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: CustomText(
                content: 'Order Summary',
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: res.length * 80,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: res.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 24, right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            content:
                                '${res[index].quantity}x ${res[index].foodItems.nameFood}'),
                        CustomText(content: '\$${res[index].price}')
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
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(content: 'Subtotal'),
                  CustomText(content: '\$$subPrice')
                ],
              ),
            ),
            Divider(color: Colors.grey[300]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(content: 'Delivery Fee'),
                  CustomText(content: '\$$deliveryFee')
                ],
              ),
            ),
            Divider(color: Colors.grey[300]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(content: 'VAT'),
                  CustomText(content: '\$$vat')
                ],
              ),
            ),
            Divider(color: Colors.grey[300]),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(content: 'Coupon'),
                  CustomText(content: '-\$$coupon', color: Colors.green)
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

import 'package:template/source/export.dart';

enum CardType { visa, master }

class CreditCard extends StatelessWidget {
  const CreditCard({
    super.key,
    required this.cardName,
    required this.cardNumber,
    required this.cardType,
  });

  final String cardName, cardNumber;
  final CardType cardType;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.none,
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
                image: AssetImage(Assets.creditCard), fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(
                top: 41,
                right: 40,
                child: CustomText(
                    content: cardNumber.replaceRange(0, 14, '****'),
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            Positioned(
                left: 32,
                bottom: 38,
                child: CustomText(
                    content: cardName,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            Positioned(
              top: 40,
              left: 32,
              child: Image.asset(Assets.chip, fit: BoxFit.cover),
            ),
            Positioned(
              right: 40,
              bottom: 24,
              child: Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(cardType == CardType.master
                              ? Assets.master
                              : Assets.visa),
                          fit: BoxFit.cover))),
            )
          ],
        ),
      ),
    );
  }
}

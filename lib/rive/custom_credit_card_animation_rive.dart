import 'package:rive/rive.dart';
import 'package:template/source/export.dart';

class CustomCreditCardAnimationRive extends StatefulWidget {
  const CustomCreditCardAnimationRive({super.key});

  @override
  State<CustomCreditCardAnimationRive> createState() =>
      _CustomCreditCardAnimationRiveState();
}

class _CustomCreditCardAnimationRiveState
    extends State<CustomCreditCardAnimationRive> {
  late RiveAnimationController animationController;
  @override
  void initState() {
    animationController = SimpleAnimation('Flip Up', autoplay: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paymentMethodsBloc = context.read<PaymentMethodsBloc>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Expanded(
              child: RiveAnimation.asset(
                  fit: BoxFit.cover,
                  'assets/rives/ocr_card.riv',
                  controllers: [animationController]),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: CustomButton(
                heightBox: 62,
                content: 'Add New Card',
                color: AppColor.globalPink,
                onPressed: () {
                  paymentMethodsBloc
                      .add(PaymentMethodsNavigateToCreateCardEvent());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

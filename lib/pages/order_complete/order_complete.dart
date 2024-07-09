import 'package:template/source/export.dart';

class OrderComplete extends StatefulWidget {
  const OrderComplete({super.key});

  @override
  State<OrderComplete> createState() => _OrderCompleteState();
}

class _OrderCompleteState extends State<OrderComplete> {
  late Timer timer;

  @override
  void initState() {
    backHome();
    super.initState();
  }

  Future backHome() async {
    timer = Timer(
        const Duration(milliseconds: 5000),
        () => Navigator.pushNamedAndRemoveUntil(
            context, AppRouter.homePage, (route) => false));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 100,
                  child: Lottie.asset(Assets.done, fit: BoxFit.cover)),
              const CustomText(
                  content: 'Thank you for placing the order',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              const CustomText(
                  content: 'We’ll get to you as soon as possible',
                  color: Colors.grey),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 70),
                child: SizedBox(
                    height: 250,
                    child: Lottie.asset(Assets.delivery, fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomButton(
                    onPressed: () {
                      timer.cancel();
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRouter.homePage, (route) => false);
                    },
                    content: 'Go Home',
                    color: AppColor.globalPink),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:template/source/export.dart';

part 'payment_methods_extension.dart';

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
      body: BlocConsumer<PaymentMethodsBloc, PaymentMethodsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case PaymentMethodsLoadingState:
              return customLoading();
            case PaymentMethodsLoadedState:
              final success = state as PaymentMethodsLoadedState;
              return success.paymentModel.isEmpty
                  ? const CustomCreditCardAnimationRive()
                  : PaymentMethodBody(paymentModel: success.paymentModel);
          }
          return const SizedBox();
        },
      ),
    );
  }
}

import 'package:intl/intl.dart';
import 'package:template/source/export.dart';

class CreateCard extends StatefulWidget {
  const CreateCard({super.key});

  @override
  State<CreateCard> createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  final cardNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvcController = TextEditingController();
  @override
  void initState() {
    context.read<CreateCardBloc>().add(CreateCardInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paymentMethodsBloc = context.read<PaymentMethodsBloc>();
    final createCardBloc = context.read<CreateCardBloc>();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            shape: const UnderlineInputBorder(
                borderSide: BorderSide(width: 8, color: AppColor.dividerGrey)),
            title: const CustomText(
                content: 'Credit Card Info', fontWeight: FontWeight.bold)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
                child: Column(
              children: [
                CustomTextField(
                    labelText: 'Card Name',
                    keyboardType: TextInputType.name,
                    controller: cardNameController,
                    prefix: const Icon(Icons.person_2_outlined),
                    textCapitalization: TextCapitalization.characters,
                    onChanged: (p0) {
                      setState(() {
                        Validation.cardNameRegex
                            .hasMatch(cardNameController.text);
                      });
                    },
                    activeValidate: Validation.cardNameRegex
                                .hasMatch(cardNameController.text) ||
                            cardNameController.text.isEmpty
                        ? false
                        : true,
                    errorText: Validation.cardNameRegex
                                .hasMatch(cardNameController.text) ||
                            cardNameController.text.isEmpty
                        ? ''
                        : 'Invalid Name'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomTextField(
                    labelText: 'Card Number',
                    controller: cardNumberController,
                    prefix: const Icon(Icons.credit_card),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      CardNumberFormatter(textIndex: 4, replaceText: ' ')
                    ],
                    errorText: cardNumberController.text.length < 19 &&
                            cardNumberController.text.isNotEmpty
                        ? 'Must be 16 digits'
                        : '',
                    onChanged: (value) {
                      createCardBloc
                          .add(CreateCardChangeTypeCardEvent(typeCard: value));
                      setState(() {
                        cardNumberController.text = value;
                      });
                    },
                    activeValidate: cardNumberController.text.length < 19 &&
                            cardNumberController.text.isNotEmpty
                        ? true
                        : false,
                    suffix: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: BlocBuilder<CreateCardBloc, CreateCardState>(
                        builder: (context, state) {
                          switch (state.runtimeType) {
                            case CreateCardChangeTypeCardState:
                              final success =
                                  state as CreateCardChangeTypeCardState;
                              return Container(
                                  height: 56,
                                  width: 56,
                                  decoration: BoxDecoration(
                                      image: success.typeCard.isEmpty
                                          ? null
                                          : DecorationImage(
                                              image: AssetImage(success.typeCard
                                                      .startsWith('4')
                                                  ? Assets.visa
                                                  : Assets.master),
                                              fit: BoxFit.cover)));
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                ),
                CustomTextField(
                  onTap: () async {
                    DateTime? dateTime = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100));
                    if (dateTime != null) {
                      setState(() {
                        expiryDateController.text =
                            DateFormat('MM/yy').format(dateTime);
                      });
                    }
                  },
                  activeValidate: false,
                  labelText: 'Expiry Date',
                  controller: expiryDateController,
                  readOnly: true,
                  prefix: const Icon(Icons.date_range),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomTextField(
                    labelText: 'CVC/CVV',
                    errorText: cvcController.text.length < 3 &&
                            cvcController.text.isNotEmpty
                        ? 'Must be 3 digits'
                        : '',
                    controller: cvcController,
                    onChanged: (value) {
                      setState(() {
                        cvcController.text = value;
                      });
                    },
                    activeValidate: cvcController.text.length < 3 &&
                            cvcController.text.isNotEmpty
                        ? true
                        : false,
                    prefix: const Icon(Icons.password),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3)
                    ],
                  ),
                ),
                CustomButton(
                    onPressed: () {
                      paymentMethodsBloc.add(PaymentMethodsAddCardEvent(
                          context: context,
                          cardName: cardNameController.text,
                          cardNumber: cardNumberController.text,
                          expiryDate: expiryDateController.text,
                          cvc: cvcController.text));
                    },
                    content: 'Save',
                    color: AppColor.globalPink)
              ],
            )),
          ),
        ),
      ),
    );
  }
}

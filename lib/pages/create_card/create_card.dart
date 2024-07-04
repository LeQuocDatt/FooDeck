import 'package:intl/intl.dart';
import 'package:template/source/export.dart';

class CreateCard extends StatefulWidget {
  const CreateCard({super.key});

  @override
  State<CreateCard> createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
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
                BlocBuilder<CreateCardBloc, CreateCardState>(
                  buildWhen: (previous, current) =>
                      current is CreateCardNameInputState,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case CreateCardNameInputState:
                        final success = state as CreateCardNameInputState;
                        return CustomTextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(14)
                            ],
                            labelText: 'Card Name',
                            keyboardType: TextInputType.name,
                            prefix: Icon(Icons.person_2_outlined,
                                color: Validation.cardNameRegex
                                            .hasMatch(success.name) ||
                                        success.name.isEmpty
                                    ? Colors.black
                                    : Colors.red),
                            textCapitalization: TextCapitalization.characters,
                            onChanged: (value) {
                              createCardBloc
                                  .add(CreateCardNameInputEvent(name: value));
                            },
                            activeValidate: Validation.cardNameRegex
                                        .hasMatch(success.name) ||
                                    success.name.isEmpty
                                ? false
                                : true,
                            errorText: Validation.cardNameRegex
                                        .hasMatch(success.name) ||
                                    success.name.isEmpty
                                ? ''
                                : '${success.name} is not a valid name');
                    }
                    return CustomTextField(
                        labelText: 'Card Name',
                        keyboardType: TextInputType.name,
                        prefix: const Icon(Icons.person_2_outlined),
                        textCapitalization: TextCapitalization.characters,
                        onChanged: (value) {
                          createCardBloc
                              .add(CreateCardNameInputEvent(name: value));
                        },
                        activeValidate: false);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: BlocBuilder<CreateCardBloc, CreateCardState>(
                    buildWhen: (previous, current) =>
                        current is CreateCardNumberInputState,
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case CreateCardNumberInputState:
                          final success = state as CreateCardNumberInputState;
                          return CustomTextField(
                            labelText: 'Card Number',
                            prefix: Icon(Icons.credit_card,
                                color: success.number.length < 19 &&
                                        success.number.isNotEmpty
                                    ? Colors.red
                                    : Colors.black),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(16),
                              CardNumberFormatter(
                                  textIndex: 4, replaceText: ' ')
                            ],
                            errorText: success.number.length < 19 &&
                                    success.number.isNotEmpty
                                ? 'Must be 16 digits'
                                : '',
                            onChanged: (value) {
                              createCardBloc.add(
                                  CreateCardNumberInputEvent(number: value));
                            },
                            activeValidate: success.number.length < 19 &&
                                    success.number.isNotEmpty
                                ? true
                                : false,
                            suffix: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                  height: 56,
                                  width: 56,
                                  decoration: BoxDecoration(
                                      image: success.number.isEmpty
                                          ? null
                                          : DecorationImage(
                                              image: AssetImage(
                                                  success.number.startsWith('4')
                                                      ? Assets.visa
                                                      : Assets.master),
                                              fit: BoxFit.cover))),
                            ),
                          );
                      }
                      return CustomTextField(
                          labelText: 'Card Number',
                          prefix: const Icon(Icons.credit_card),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            createCardBloc
                                .add(CreateCardNumberInputEvent(number: value));
                          },
                          activeValidate: false);
                    },
                  ),
                ),
                BlocBuilder<CreateCardBloc, CreateCardState>(
                  buildWhen: (previous, current) =>
                      current is CreateCardExpiryInputState,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case CreateCardExpiryInputState:
                        final success = state as CreateCardExpiryInputState;
                        TextEditingController expiryDateController =
                            TextEditingController(text: success.expiryDate);
                        return CustomTextField(
                          onTap: () async {
                            DateTime? dateTime = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100));
                            if (dateTime != null) {
                              createCardBloc.add(CreateCardExpiryInputEvent(
                                  expiryDate:
                                      DateFormat('MM/yy').format(dateTime)));
                            }
                          },
                          activeValidate: false,
                          labelText: 'Expiry Date',
                          controller: expiryDateController,
                          readOnly: true,
                          prefix: const Icon(Icons.date_range),
                        );
                    }

                    return CustomTextField(
                      onTap: () async {
                        DateTime? dateTime = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100));
                        createCardBloc.add(CreateCardExpiryInputEvent(
                            expiryDate: DateFormat('MM/yy').format(dateTime!)));
                      },
                      activeValidate: false,
                      labelText: 'Expiry Date',
                      readOnly: true,
                      prefix: const Icon(Icons.date_range),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: BlocBuilder<CreateCardBloc, CreateCardState>(
                    buildWhen: (previous, current) =>
                        current is CreateCardCvcInputState,
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case CreateCardCvcInputState:
                          final success = state as CreateCardCvcInputState;
                          return CustomTextField(
                              labelText: 'CVC/CVV',
                              errorText: success.cvc.length < 3 &&
                                      success.cvc.isNotEmpty
                                  ? 'Must be 3 digits'
                                  : '',
                              onChanged: (value) {
                                createCardBloc
                                    .add(CreateCardCvcInputEvent(cvc: value));
                              },
                              activeValidate: success.cvc.length < 3 &&
                                      success.cvc.isNotEmpty
                                  ? true
                                  : false,
                              prefix: Icon(Icons.password,
                                  color: success.cvc.length < 3 &&
                                          success.cvc.isNotEmpty
                                      ? Colors.red
                                      : Colors.black),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3)
                              ]);
                      }
                      return CustomTextField(
                          labelText: 'CVC/CVV',
                          onChanged: (value) {
                            createCardBloc
                                .add(CreateCardCvcInputEvent(cvc: value));
                          },
                          activeValidate: false,
                          prefix: const Icon(Icons.password),
                          keyboardType: TextInputType.number);
                    },
                  ),
                ),
                CustomButton(
                    onPressed: () {
                      paymentMethodsBloc.add(PaymentMethodsAddCardEvent(
                          context: context,
                          cardName: createCardBloc.name,
                          cardNumber: createCardBloc.number,
                          expiryDate: createCardBloc.expiryDate,
                          cvc: createCardBloc.cvc));
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

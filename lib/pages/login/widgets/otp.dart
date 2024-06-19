import 'package:template/source/export.dart';

class Otp extends StatefulWidget {
  const Otp({super.key, required this.email});

  final String email;

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500),
        () => customSnackBar(context, Toast.error, 'OTP in your email'));
    super.initState();
  }

  final currentIndex = ValueNotifier(0);

  List<String> otpValues = List.filled(6, '');

  Future checkOTP() async {
    FocusManager.instance.primaryFocus!.unfocus();
    String token = otpValues.join();
    try {
      await supabase.auth
          .verifyOTP(token: token, type: OtpType.email, email: widget.email);
    } catch (e) {
      if (mounted) {
        customSnackBar(context, Toast.error, e.toString());
      }
    }
  }

  Future resendOTP() async {
    try {
      await supabase.auth
          .signInWithOtp(shouldCreateUser: false, email: widget.email)
          .then((value) =>
              customSnackBar(context, Toast.error, 'OTP in your email'));
    } catch (e) {
      if (mounted) {
        customSnackBar(context, Toast.error, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            appBar: AppBar(
                shape: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 8, color: AppColor.dividerGrey)),
                title: const CustomText(
                    content: 'OTP', fontWeight: FontWeight.bold)),
            body: SingleChildScrollView(
                child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            content:
                                'Confirm the code we sent to ${widget.email}',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: ValueListenableBuilder(
                            valueListenable: currentIndex,
                            builder: (BuildContext context, int value,
                                Widget? child) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  6,
                                  (index) => Flexible(
                                    child: SizedBox(
                                      width: 60,
                                      child: CustomTextField(
                                        autofocus: true,
                                        textInputAction: TextInputAction.next,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        activeValidate: true,
                                        borderColor: value >= index
                                            ? AppColor.globalPink
                                            : Colors.grey,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(1)
                                        ],
                                        onChanged: (value) {
                                          otpValues[index] = value;

                                          if (value.length == 1) {
                                            setState(() {
                                              currentIndex.value = index + 1;
                                            });
                                            currentIndex.value == 6
                                                ? null
                                                : FocusScope.of(context)
                                                    .nextFocus();
                                          } else {
                                            setState(() {
                                              currentIndex.value = index - 1;
                                            });
                                            currentIndex.value == -1
                                                ? null
                                                : FocusScope.of(context)
                                                    .previousFocus();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: GestureDetector(
                                onTap: () {
                                  resendOTP();
                                },
                                child: const CustomText(
                                    content: 'Resend',
                                    fontSize: 13,
                                    textDecoration: TextDecoration.underline))),
                        ValueListenableBuilder(
                          valueListenable: currentIndex,
                          builder:
                              (BuildContext context, int value, Widget? child) {
                            return CustomButton(
                                onPressed: () {
                                  value == 6 ? checkOTP() : null;
                                },
                                content: 'Confirm',
                                color: AppColor.globalPink);
                          },
                        )
                      ])),
            ))));
  }
}

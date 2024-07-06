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
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        customSnackBar(context, Toast.error, 'OTP in your email', 2000);
      }
    });

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
          .resend(email: widget.email, type: OtpType.signup)
          .then(
        (value) {
          if (mounted) {
            customSnackBar(context, Toast.error, 'OTP in your email');
          }
        },
      );
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
            body: Center(
              child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            content:
                                'Confirm the code we sent to ${widget.email}',
                            textOverflow: TextOverflow.visible,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ValueListenableBuilder(
                            valueListenable: currentIndex,
                            builder: (BuildContext context, int value,
                                Widget? child) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  6,
                                  (index) => SizedBox(
                                      width: 50, child: buildOtpField(index)),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
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
            )));
  }

  Widget buildOtpField(int index) {
    return TextField(
      autofocus: true,
      textInputAction: TextInputAction.next,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: currentIndex.value >= index
                      ? AppColor.globalPink
                      : Colors.grey)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: currentIndex.value >= index
                      ? AppColor.globalPink
                      : Colors.grey)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: currentIndex.value >= index
                      ? AppColor.globalPink
                      : Colors.grey))),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(1)
      ],
      onChanged: (value) {
        otpValues[index] = value;

        if (value.length == 1) {
          setState(() {
            currentIndex.value = index + 1;
          });
          currentIndex.value == 6 ? null : FocusScope.of(context).nextFocus();
        } else {
          setState(() {
            currentIndex.value = index - 1;
          });
          currentIndex.value == -1
              ? null
              : FocusScope.of(context).previousFocus();
        }
      },
    );
  }
}

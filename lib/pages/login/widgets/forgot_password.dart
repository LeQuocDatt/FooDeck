import 'package:template/source/export.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  Future login() async {
    try {
      FocusManager.instance.primaryFocus!.unfocus();
      if (Validation.emailRegex.hasMatch(emailController.text)) {
        await supabase.auth
            .signInWithOtp(email: emailController.text, shouldCreateUser: false)
            .then((value) => AppRouter.navigatorKey.currentState!.pushNamed(
                AppRouter.otp,
                arguments: Otp(email: emailController.text.trim())));
      } else {
        customSnackBar(context, Toast.error, 'Not Correct!');
      }
    } catch (e) {
      if (mounted) {
        customSnackBar(context, Toast.error, e.toString());
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
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
                    content: 'Forgot Password', fontWeight: FontWeight.bold)),
            body: SingleChildScrollView(
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                  content: 'Input your credentials',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 16, bottom: 20),
                                child: CustomTextField(
                                    keyboardType: TextInputType.emailAddress,
                                    labelText: 'Email',
                                    controller: emailController,
                                    onChanged: (value) {
                                      setState(() {
                                        Validation.emailRegex
                                            .hasMatch(emailController.text);
                                      });
                                    },
                                    activeValidate: Validation.emailRegex
                                                .hasMatch(
                                                    emailController.text) ||
                                            emailController.text.isEmpty
                                        ? false
                                        : true,
                                    errorText: Validation.emailRegex.hasMatch(
                                                emailController.text) ||
                                            emailController.text.isEmpty
                                        ? ''
                                        : '${emailController.text} is not a valid email'),
                              ),
                              CustomButton(
                                  onPressed: () {
                                    login();
                                  },
                                  content: 'Login',
                                  color: AppColor.globalPink)
                            ]))))));
  }
}

import 'package:template/source/export.dart';

class LoginEmail extends StatefulWidget {
  const LoginEmail({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  bool showPass = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future login() async {
    if (Validation.emailRegex.hasMatch(emailController.text) &&
        Validation.passRegex.hasMatch(passwordController.text)) {
      try {
        await supabase.auth.signInWithPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      } catch (e) {
        if (mounted) {
          customSnackBar(context, Toast.error, e.toString());
        }
      }
    } else {
      customSnackBar(context, Toast.error, 'Error!, please retry');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                borderSide: BorderSide(width: 8, color: AppColor.dividerGrey)),
            title: const CustomText(
                content: 'Login via Email', fontWeight: FontWeight.bold)),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: CustomText(
                        content: 'Input your credentials',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  CustomTextField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      labelText: 'Email',
                      controller: emailController,
                      onChanged: (value) {
                        setState(() {
                          Validation.emailRegex.hasMatch(emailController.text);
                        });
                      },
                      activeValidate: Validation.emailRegex
                                  .hasMatch(emailController.text) ||
                              emailController.text.isEmpty
                          ? false
                          : true,
                      errorText: Validation.emailRegex
                                  .hasMatch(emailController.text) ||
                              emailController.text.isEmpty
                          ? ''
                          : '${emailController.text} is not a valid email'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                        labelText: 'Password',
                        suffix: passwordController.text.isEmpty
                            ? const SizedBox()
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showPass = !showPass;
                                  });
                                },
                                child: Icon(
                                  showPass
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Validation.passRegex
                                          .hasMatch(passwordController.text)
                                      ? Colors.grey[400]
                                      : Colors.red,
                                )),
                        obscureText: showPass ? false : true,
                        onChanged: (value) {
                          setState(() {
                            Validation.passRegex
                                .hasMatch(passwordController.text);
                          });
                        },
                        activeValidate: Validation.passRegex
                                    .hasMatch(passwordController.text) ||
                                passwordController.text.isEmpty
                            ? false
                            : true,
                        errorText: Validation.passRegex
                                    .hasMatch(passwordController.text) ||
                                passwordController.text.isEmpty
                            ? ''
                            : 'Need number, symbol, capital and small letter',
                        controller: passwordController),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 40, top: 10),
                      child: GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Navigator.pushNamed(
                                context, AppRouter.forgotPassword);
                          },
                          child: const CustomText(
                              content: 'Forgot Password?',
                              fontSize: 13,
                              textDecoration: TextDecoration.underline))),
                  CustomButton(
                      onPressed: () {
                        login();
                      },
                      content: 'Login',
                      color: AppColor.globalPink),
                  CustomButton(
                      borderSide: const BorderSide(color: Colors.grey),
                      onPressed: widget.onPressed,
                      content: 'Create an account instead',
                      contentColor: Colors.grey,
                      color: Colors.white)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

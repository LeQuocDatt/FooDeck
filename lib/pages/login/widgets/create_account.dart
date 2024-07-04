import 'package:template/source/export.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool showPass = false;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  Future signUpAndAddUsers() async {
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      if (Validation.emailRegex.hasMatch(emailController.text) &&
          Validation.nameRegex.hasMatch(nameController.text) &&
          phoneController.text.length == 10 &&
          Validation.passRegex.hasMatch(passwordController.text)) {
        await supabase.auth.signUp(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            data: {
              'email': emailController.text.trim(),
              'full_name': nameController.text.trim(),
              'phone': phoneController.text.trim(),
              'password': passwordController.text.trim(),
            });
        if (mounted) {
          Navigator.pushNamed(context, AppRouter.otp,
              arguments: Otp(email: emailController.text.trim()));
        }
      } else {
        customSnackBar(context, Toast.error, 'Info must correct and not empty');
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
    nameController.dispose();
    phoneController.dispose();
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
                content: 'Create an account', fontWeight: FontWeight.bold)),
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
                      padding: const EdgeInsets.only(top: 16),
                      child: CustomTextField(
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          labelText: 'Full Name',
                          controller: nameController,
                          onChanged: (value) {
                            setState(() {
                              Validation.nameRegex
                                  .hasMatch(nameController.text);
                            });
                          },
                          activeValidate: Validation.nameRegex
                                      .hasMatch(nameController.text) ||
                                  nameController.text.isEmpty
                              ? false
                              : true,
                          errorText: Validation.nameRegex
                                      .hasMatch(nameController.text) ||
                                  nameController.text.isEmpty
                              ? ''
                              : '${nameController.text} is not a valid name')),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        labelText: 'Email',
                        controller: emailController,
                        onChanged: (value) {
                          setState(() {
                            Validation.emailRegex
                                .hasMatch(emailController.text);
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        labelText: 'Phone No.',
                        inputFormatters: [LengthLimitingTextInputFormatter(13)],
                        controller: phoneController,
                        onChanged: (value) {
                          setState(() {
                            phoneController.text = value;
                          });
                        },
                        activeValidate: phoneController.text.length == 10 ||
                                phoneController.text.isEmpty
                            ? false
                            : true,
                        errorText: phoneController.text.length == 10 ||
                                phoneController.text.isEmpty
                            ? ''
                            : '${phoneController.text} is not a valid phone number'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 40),
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
                  CustomButton(
                      onPressed: () {
                        signUpAndAddUsers();
                      },
                      content: 'Create an account',
                      color: AppColor.globalPink),
                  CustomButton(
                      borderSide: const BorderSide(color: Colors.grey),
                      onPressed: widget.onPressed,
                      content: 'Login instead',
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

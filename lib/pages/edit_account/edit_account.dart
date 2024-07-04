import 'package:template/source/export.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  bool showPass = false;

  @override
  void initState() {
    context.read<ProfilePageBloc>().add(ProfilePageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profilePageBloc = context.read<ProfilePageBloc>();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            shape: const UnderlineInputBorder(
                borderSide: BorderSide(width: 8, color: AppColor.dividerGrey)),
            title: const CustomText(
                content: 'Edit Account', fontWeight: FontWeight.bold)),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<ProfilePageBloc, ProfilePageState>(
                  buildWhen: (previous, current) =>
                      current is ProfilePageLoadedState ||
                      current is ProfilePageUpdatePictureState,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case ProfilePageLoadedState:
                        final success = state as ProfilePageLoadedState;
                        return Avatar(
                            imageUrl: success.avatar,
                            onUpload: (imageUrl) {
                              profilePageBloc.add(ProfilePageUpdatePictureEvent(
                                  imageUrl: imageUrl));
                            });
                      case ProfilePageUpdatePictureState:
                        final success = state as ProfilePageUpdatePictureState;
                        return Avatar(
                            imageUrl: success.imageUrl,
                            onUpload: (imageUrl) {
                              profilePageBloc.add(ProfilePageUpdatePictureEvent(
                                  imageUrl: imageUrl));
                            });
                    }
                    return const SizedBox.shrink();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
                    buildWhen: (previous, current) =>
                        current is ProfilePageNameInputState,
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case ProfilePageNameInputState:
                          final success = state as ProfilePageNameInputState;
                          return CustomTextField(
                              keyboardType: TextInputType.name,
                              labelText: 'Full Name',
                              onChanged: (value) {
                                profilePageBloc.add(
                                    ProfilePageNameInputEvent(name: value));
                              },
                              activeValidate:
                                  Validation.nameRegex.hasMatch(success.name) ||
                                          success.name.isEmpty
                                      ? false
                                      : true,
                              errorText:
                                  Validation.nameRegex.hasMatch(success.name) ||
                                          success.name.isEmpty
                                      ? ''
                                      : '${success.name} is not a valid name');
                      }
                      return CustomTextField(
                          keyboardType: TextInputType.name,
                          labelText: 'Full Name',
                          activeValidate: false,
                          onChanged: (value) {
                            profilePageBloc
                                .add(ProfilePageNameInputEvent(name: value));
                          });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
                    buildWhen: (previous, current) =>
                        current is ProfilePageEmailInputState,
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case ProfilePageEmailInputState:
                          final success = state as ProfilePageEmailInputState;
                          return CustomTextField(
                              keyboardType: TextInputType.emailAddress,
                              labelText: 'Email',
                              onChanged: (value) {
                                profilePageBloc.add(
                                    ProfilePageEmailInputEvent(email: value));
                              },
                              activeValidate: Validation.emailRegex
                                          .hasMatch(success.email) ||
                                      success.email.isEmpty
                                  ? false
                                  : true,
                              errorText: Validation.emailRegex
                                          .hasMatch(success.email) ||
                                      success.email.isEmpty
                                  ? ''
                                  : '${success.email} is not a valid email');
                      }
                      return CustomTextField(
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'Email',
                          onChanged: (value) {
                            profilePageBloc
                                .add(ProfilePageEmailInputEvent(email: value));
                          },
                          activeValidate: false);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
                    buildWhen: (previous, current) =>
                        current is ProfilePagePhoneInputState,
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case ProfilePagePhoneInputState:
                          final success = state as ProfilePagePhoneInputState;
                          return CustomTextField(
                              keyboardType: TextInputType.phone,
                              labelText: 'Phone No.',
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10)
                              ],
                              onChanged: (value) {
                                profilePageBloc.add(
                                    ProfilePagePhoneInputEvent(phone: value));
                              },
                              activeValidate: success.phone.length == 10 ||
                                      success.phone.isEmpty
                                  ? false
                                  : true,
                              errorText: success.phone.length == 10 ||
                                      success.phone.isEmpty
                                  ? ''
                                  : '${success.phone} is not a valid phone number');
                      }
                      return CustomTextField(
                          keyboardType: TextInputType.phone,
                          labelText: 'Phone No.',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            profilePageBloc
                                .add(ProfilePagePhoneInputEvent(phone: value));
                          },
                          activeValidate: false);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 40),
                  child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
                    buildWhen: (previous, current) =>
                        current is ProfilePagePassInputState,
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case ProfilePagePassInputState:
                          final success = state as ProfilePagePassInputState;
                          return CustomTextField(
                              labelText: 'Password',
                              suffix: success.pass.isEmpty
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
                                                .hasMatch(success.pass)
                                            ? Colors.grey[400]
                                            : Colors.red,
                                      )),
                              obscureText: showPass ? false : true,
                              onChanged: (value) {
                                profilePageBloc.add(
                                    ProfilePagePassInputEvent(pass: value));
                              },
                              activeValidate:
                                  Validation.passRegex.hasMatch(success.pass) ||
                                          success.pass.isEmpty
                                      ? false
                                      : true,
                              errorText: Validation.passRegex
                                          .hasMatch(success.pass) ||
                                      success.pass.isEmpty
                                  ? ''
                                  : 'Need number, symbol, capital and small letter');
                      }
                      return CustomTextField(
                          labelText: 'Password',
                          onChanged: (value) {
                            profilePageBloc
                                .add(ProfilePagePassInputEvent(pass: value));
                          },
                          activeValidate: false);
                    },
                  ),
                ),
                CustomButton(
                    onPressed: () {
                      profilePageBloc.add(ProfilePageUpdateInfoEvent(
                          imageUrl: profilePageBloc.imageUrl,
                          name: profilePageBloc.name,
                          email: profilePageBloc.email,
                          phone: profilePageBloc.phone,
                          pass: profilePageBloc.pass,
                          context: context));
                    },
                    content: 'Save',
                    color: AppColor.globalPink),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

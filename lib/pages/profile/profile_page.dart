import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:template/source/export.dart';

part 'profile_page_extension_body.dart';
part 'profile_page_extension_header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfilePageBloc>().add(ProfilePageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: 1200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: AppColor.dividerGrey,
                      padding:
                          const EdgeInsets.only(top: 68, left: 24, bottom: 8),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: BlocBuilder<ProfilePageBloc,
                                  ProfilePageState>(
                                buildWhen: (previous, current) =>
                                    current is ProfilePageLoadedState ||
                                    current is ProfilePageUpdateInfoState,
                                builder: (context, state) {
                                  switch (state.runtimeType) {
                                    case ProfilePageLoadedState:
                                      final success =
                                          state as ProfilePageLoadedState;
                                      return avatarAndName(
                                          success.avatar, success.name);
                                    case ProfilePageUpdateInfoState:
                                      final success =
                                          state as ProfilePageUpdateInfoState;
                                      return avatarAndName(
                                          success.avatar, success.name);
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                            Center(
                              child: BlocBuilder<ProfilePageBloc,
                                  ProfilePageState>(
                                buildWhen: (previous, current) =>
                                    current is ProfilePageLoadedState,
                                builder: (context, state) {
                                  switch (state.runtimeType) {
                                    case ProfilePageLoadedState:
                                      final success =
                                          state as ProfilePageLoadedState;
                                      return success.address != null
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 40),
                                              child: CustomText(
                                                  content: success.address!),
                                            )
                                          : const SizedBox.shrink();
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                            const CustomText(
                                content: 'Account Settings',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColor.globalPink)
                          ])),
                ),
                Expanded(flex: 3, child: profileBody(context))
              ],
            ),
          ),
        ));
  }
}

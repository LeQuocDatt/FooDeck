part of 'profile_page.dart';

ListView profileBody(BuildContext context) {
  final profilePageBloc = context.read<ProfilePageBloc>();
  return ListView.separated(
    padding: EdgeInsets.zero,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: profileIcons.length,
    itemBuilder: (context, index) => GestureDetector(
      onTap: () {
        profilePageBloc.add(ProfilePageNavigateEvent(
            gate: profileIcons[index].label, context: context));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListTile(
          title: Text(profileIcons[index].label),
          leading: Icon(profileIcons[index].icon),
          trailing: index == profileIcons.length - 2
              ? BlocBuilder<ProfilePageBloc, ProfilePageState>(
                  buildWhen: (previous, current) =>
                      current is ProfilePageToggleThemeState,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case ProfilePageToggleThemeState:
                        return Switch.adaptive(
                          value: profilePageBloc.toggle,
                          onChanged: (value) {
                            profilePageBloc.add(
                                ProfilePageToggleThemeEvent(toggle: value));
                          },
                        );
                    }
                    return Switch.adaptive(
                      value: profilePageBloc.toggle,
                      onChanged: (value) {
                        profilePageBloc
                            .add(ProfilePageToggleThemeEvent(toggle: value));
                      },
                    );
                  },
                )
              : const Icon(Icons.arrow_forward_ios),
        ),
      ),
    ),
    separatorBuilder: (BuildContext context, int index) {
      return index == profileIcons.length - 5
          ? Container(
              height: 70,
              alignment: Alignment.bottomLeft,
              color: AppColor.dividerGrey,
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: const CustomText(
                  content: 'General Settings',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColor.globalPink))
          : Divider(color: Colors.grey.shade300);
    },
  );
}

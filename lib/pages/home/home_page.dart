import 'package:template/source/export.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tabs = [
    const ExplorePage(),
    const SavedPage(),
    const NotificationsPage(),
    const ProfilePage()
  ];

  @override
  void initState() {
    context.read<HomePageBloc>().add(HomePageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomePageLoadingState:
            return customLoading();
          case HomePageSelectIndexState:
            final selectIndex = state as HomePageSelectIndexState;
            return Scaffold(
                body: tabs[selectIndex.index],
                bottomNavigationBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    onTap: (value) {
                      context
                          .read<HomePageBloc>()
                          .add(HomePageSelectIndexEvent(index: value));
                    },
                    currentIndex: selectIndex.index,
                    selectedLabelStyle:
                        AppTextStyle.inter.copyWith(fontSize: 11),
                    unselectedLabelStyle:
                        AppTextStyle.inter.copyWith(fontSize: 11),
                    showUnselectedLabels: true,
                    unselectedItemColor: Colors.grey,
                    selectedItemColor: AppColor.globalPink,
                    elevation: 20,
                    items: [
                      ...List.generate(
                        bottomIcons.length,
                        (index) {
                          return BottomNavigationBarItem(
                              label: bottomIcons[index].label,
                              icon: Icon(bottomIcons[index].icon));
                        },
                      )
                    ]));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

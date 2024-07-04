import 'package:template/source/export.dart';

part 'restaurant_extension_appbar.dart';
part 'restaurant_extension_body.dart';
part 'restaurant_extension_bottom_app_bar.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  void initState() {
    context.read<RestaurantPageBloc>().add(RestaurantPageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: type.length,
      child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 200,
              flexibleSpace: const RestaurantAppBar()),
          body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) =>
                  [const RestaurantBottomAppBar()],
              body: const RestaurantBody())),
    );
  }
}

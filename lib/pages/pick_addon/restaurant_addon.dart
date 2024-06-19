import 'package:template/source/export.dart';

part 'restaurant_addon_extension_appbar.dart';
part 'restaurant_addon_extension_body.dart';

class RestaurantAddon extends StatefulWidget {
  const RestaurantAddon({super.key});

  @override
  State<RestaurantAddon> createState() => _RestaurantAddonState();
}

class _RestaurantAddonState extends State<RestaurantAddon> {
  @override
  void initState() {
    context.read<RestaurantAddonBloc>().add(RestaurantAddonInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: RestaurantAddonAppBar(expandedHeight: 200),
                pinned: true,
                floating: true,
              ),
              SliverToBoxAdapter(child: restaurantAddonBody(context))
            ],
          ),
        ));
  }
}

import 'package:template/features/my_orders/bloc/my_orders_bloc.dart';
import 'package:template/source/export.dart';

class AppBlocProviders {
  static List<BlocProvider> allBlocProviders() {
    return [
      BlocProvider<MyOrdersBloc>(
        create: (context) => MyOrdersBloc(),
      ),
      BlocProvider<MyLocationsBloc>(
        create: (context) => MyLocationsBloc(),
      ),
      BlocProvider<SearchPageBloc>(
        create: (context) => SearchPageBloc(),
      ),
      BlocProvider<ProfilePageBloc>(
        create: (context) => ProfilePageBloc(),
      ),
      BlocProvider<CreateCardBloc>(
        create: (context) => CreateCardBloc(),
      ),
      BlocProvider<PaymentMethodsBloc>(
        create: (context) => PaymentMethodsBloc(),
      ),
      BlocProvider<RestaurantCheckOutBloc>(
        create: (context) => RestaurantCheckOutBloc(),
      ),
      BlocProvider<RestaurantAddonBloc>(
        create: (context) => RestaurantAddonBloc(),
      ),
      BlocProvider<RestaurantCartBloc>(
        create: (context) => RestaurantCartBloc(),
      ),
      BlocProvider<RestaurantPageBloc>(
        create: (context) => RestaurantPageBloc(),
      ),
      BlocProvider<ExplorePageBloc>(
        create: (context) => ExplorePageBloc(),
      ),
      BlocProvider<HomePageBloc>(
        create: (context) => HomePageBloc(),
      ),
      BlocProvider<SplashPageBloc>(
        create: (context) => SplashPageBloc(),
      ),
    ];
  }
}

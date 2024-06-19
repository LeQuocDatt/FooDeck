import 'package:template/source/export.dart';

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static const splashPage = '/splashPage';
  static const homePage = '/homePage';
  static const loginPage = '/loginPage';
  static const loginEmail = '/loginEmail';
  static const createAccount = '/createAccount';
  static const myLocation = '/myLocation';
  static const restaurantAddon = '/restaurantAddon';
  static const searchPage = '/searchPage';
  static const restaurantPage = '/restaurantPage';
  static const loginOrRegister = '/loginOrRegister';
  static const forgotPassword = '/forgotPassword';
  static const editAccount = '/editAccount';
  static const myOrders = '/myOrders';
  static const paymentMethods = '/paymentMethods';
  static const myReviews = '/myReviews';
  static const detailHistoryOrder = '/detailHistoryOrder';
  static const restaurantCheckOut = '/restaurantCheckOut';
  static const orderComplete = '/orderComplete';
  static const restaurantCart = '/restaurantCart';
  static const createCard = '/createCard';
  static const otp = '/otp';

  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return pageBuilder((_) => const SplashPage(), settings: settings);
      case homePage:
        return pageBuilder((_) => const HomePage(), settings: settings);
      case loginPage:
        return pageBuilder((_) => const LoginPage(), settings: settings);
      case loginEmail:
        return pageBuilder((_) => const LoginEmail(), settings: settings);
      case createAccount:
        return pageBuilder((_) => const CreateAccount(), settings: settings);
      case myLocation:
        return pageBuilder((_) => const MyLocation(), settings: settings);
      case otp:
        final args = settings.arguments as Otp;
        return pageBuilder((_) => Otp(email: args.email), settings: settings);
      case restaurantAddon:
        return pageBuilder((_) => const RestaurantAddon(), settings: settings);
      case searchPage:
        return pageBuilder((_) => const SearchPage(), settings: settings);
      case restaurantPage:
        return pageBuilder((_) => const RestaurantPage(), settings: settings);
      case loginOrRegister:
        final args = settings.arguments as LoginOrRegister;
        return pageBuilder((_) => LoginOrRegister(index: args.index),
            settings: settings);
      case forgotPassword:
        return pageBuilder((_) => const ForgotPassword(), settings: settings);
      case editAccount:
        return pageBuilder((_) => const EditAccount(), settings: settings);
      case myOrders:
        return pageBuilder((_) => const MyOrders(), settings: settings);
      case paymentMethods:
        return pageBuilder((_) => const PaymentMethods(), settings: settings);
      case myReviews:
        return pageBuilder((_) => const MyReviews(), settings: settings);
      case detailHistoryOrder:
        final args = settings.arguments as DetailHistoryOrder;
        return pageBuilder((_) => DetailHistoryOrder(res: args.res),
            settings: settings);
      case restaurantCheckOut:
        return pageBuilder((_) => const RestaurantCheckOut(),
            settings: settings);
      case orderComplete:
        return pageBuilder((_) => const OrderComplete(), settings: settings);
      case restaurantCart:
        return pageBuilder((_) => const RestaurantCart(), settings: settings);
      case createCard:
        return pageBuilder((_) => const CreateCard(), settings: settings);
      default:
        return errorRoute();
    }
  }

  static PageRouteBuilder<dynamic> pageBuilder(
      Widget Function(BuildContext) page,
      {required RouteSettings settings}) {
    return PageRouteBuilder(
        settings: settings,
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (_, animation, __, child) {
          Animation<Offset> offset =
              Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                  .animate(animation);
          return SlideTransition(position: offset, child: child);
        },
        pageBuilder: (context, _, __) => page(context));
  }

  static MaterialPageRoute<dynamic> errorRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            ));
  }
}

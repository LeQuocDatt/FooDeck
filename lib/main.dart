import 'package:template/source/export.dart';

late SharedPreferences sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
      url: dotenv.env['URL'].toString(),
      anonKey: dotenv.env['ANONKEY'].toString());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(userProvider: UserProvider()),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SearchPageBloc>(
            create: (context) => SearchPageBloc(),
          ),
          BlocProvider<ProfilePageBloc>(
            create: (context) =>
                ProfilePageBloc(context.read<UserRepository>()),
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
          BlocProvider(
            create: (context) => RestaurantPageBloc(),
          ),
          BlocProvider(
            create: (context) =>
                ExplorePageBloc(context.read<UserRepository>()),
          ),
          BlocProvider(
            create: (context) => HomePageBloc(),
          ),
          BlocProvider(
            create: (context) => SplashPageBloc(),
          ),
        ],
        child: MaterialApp(
            navigatorKey: AppRouter.navigatorKey,
            theme: ThemeProvider.themeData,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRouter.splashPage,
            onGenerateRoute: AppRouter.routes),
      ),
    );
  }
}

final dataCard = supabase.from('card').stream(primaryKey: ['id']);

final dataReview = supabase.from('reviews').stream(primaryKey: ['id']);
final dataOrderComplete =
    supabase.from('order_complete').stream(primaryKey: ['id']);
final dataRestaurants = supabase.from('restaurants').stream(primaryKey: ['id']);

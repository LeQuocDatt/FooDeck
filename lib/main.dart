import 'package:template/source/export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefs.sharedPreferences = await SharedPreferences.getInstance();
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
    return MultiBlocProvider(
      providers: AppBlocProviders.allBlocProviders(),
      child: MaterialApp(
          navigatorKey: AppRouter.navigatorKey,
          theme: ThemeProvider.themeData,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRouter.splashPage,
          onGenerateRoute: AppRouter.routes),
    );
  }
}

final dataCard = supabase.from('card').stream(primaryKey: ['id']);

final dataReview = supabase.from('reviews').stream(primaryKey: ['id']);
final dataOrderComplete =
    supabase.from('order_complete').stream(primaryKey: ['id']);
final dataRestaurants = supabase.from('restaurants').stream(primaryKey: ['id']);

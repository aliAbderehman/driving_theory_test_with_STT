import 'package:abel_proj_01/provider/dark_theme_provider.dart';
import 'package:abel_proj_01/provider/text_size_provider.dart';
import 'package:abel_proj_01/screens/answer_screen.dart';
import 'package:abel_proj_01/screens/home_screen.dart';
import 'package:abel_proj_01/theme/them_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themechangeProvider = DarkThemeProvider();
  TextSizeProvider textSizeProvider = TextSizeProvider();
  // This widget is the root of your application.

  void getCurrentAppTheme() async {
    themechangeProvider.setDarkTheme =
        await themechangeProvider.darkThemePrefs.getTheme();
  }

  void getCurrentTextSize() async {
    textSizeProvider.setTextSize =
        await textSizeProvider.textSizePrefs.getTextSize();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    getCurrentTextSize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyMultiProvider(
      themechangeProvider: themechangeProvider,
      sizeChangeProvider: textSizeProvider,
    );
  }
}

class MyMultiProvider extends StatelessWidget {
  const MyMultiProvider(
      {super.key,
      required this.themechangeProvider,
      required this.sizeChangeProvider});

  final DarkThemeProvider themechangeProvider;
  final TextSizeProvider sizeChangeProvider;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themechangeProvider;
        }),
        ChangeNotifierProvider(create: (_) {
          return sizeChangeProvider;
        })
      ],
      child:
          // Consumer<DarkThemeProvider>(builder: (context, themeprovider,  child) {
          Consumer2<DarkThemeProvider, TextSizeProvider>(
              builder: (context, themeprovider, sizeprovider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Styles.themeData(themechangeProvider.getDarkTheme,
              sizeChangeProvider.getTextSize, context),
          routes: {
            '/': (context) => const HomeScreen(),
            'answer_screen': (context) => const AnswerScreen()
          },
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pmsna1/provider/flags_provider.dart';
import 'package:pmsna1/provider/theme_provider.dart';
import 'package:pmsna1/routes.dart';
import 'package:pmsna1/screens/login_screen.dart';
import 'package:pmsna1/settings/styles_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String theme = prefs.getString('theme') ?? 'lightTheme';
  initializeDateFormatting().then((_) => runApp(MyApp(theme: theme,)));
}
class MyApp extends StatelessWidget {
  final String theme;

  const MyApp({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(context)),
        ChangeNotifierProvider(create: (_) => FlagsProvider())
      ],
      child: PMSNApp(theme: theme),
    );
  }
}


class PMSNApp extends StatefulWidget {
  final String theme;

  const PMSNApp({Key? key, required this.theme}) : super(key: key);

  @override
  _PMSNAppState createState() => _PMSNAppState();
}

class _PMSNAppState extends State<PMSNApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    if (widget.theme == "darkTheme") {
      themeProvider.setthemeData(StyleSettings.darkTheme(context));
    }
    if (widget.theme == "lightTheme") {
      themeProvider.setthemeData(StyleSettings.lightTheme(context));
    }
    if (widget.theme == "lightBlueTheme") {
      themeProvider.setthemeData(StyleSettings.lightBlueTheme(context));
    }
    if (widget.theme == "darkBlueTheme") {
      themeProvider.setthemeData(StyleSettings.darkBlueTheme(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).getthemeData(),
      routes: getApplicationRoutes(),
      home: const LoginScreen(),
    );
  }
}

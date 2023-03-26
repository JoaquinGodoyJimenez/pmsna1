import 'package:flutter/material.dart';
import 'package:pmsna1/provider/flags_provider.dart';
import 'package:pmsna1/provider/theme_provider.dart';
import 'package:pmsna1/routes.dart';
import 'package:pmsna1/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  initializeDateFormatting().then((_) => runApp(MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(context)),
        ChangeNotifierProvider(create: (_) => FlagsProvider())
      ],
      child: PMSNApp(),
    );
  }
}

class PMSNApp extends StatelessWidget {
  const PMSNApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      theme: theme.getthemeData(),
      routes: getApplicationRoutes(),
      home: LoginScreen(),
    );
  }
}
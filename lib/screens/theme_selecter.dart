import 'package:flutter/material.dart';
import 'package:pmsna1/provider/theme_provider.dart';
import 'package:pmsna1/settings/styles_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class ThemeSelecter extends StatefulWidget {
  const ThemeSelecter({super.key});

  @override
  State<ThemeSelecter> createState() => _ThemeSelecterState();
}

class _ThemeSelecterState extends State<ThemeSelecter> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: .4,
                fit: BoxFit.cover,
                image: AssetImage('assets/fondo_itc.jpg'))),
        child: Column(
          children: [
            Container(height: 250),
            Center(
              child: Container(
                height: 44.0,
                width: 120,
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.grey, Colors.black12])),
                child: ElevatedButton(
                  onPressed: () async {
                    theme.setthemeData(StyleSettings.darkTheme(context));
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('theme', 'darkTheme');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text('Noche'),
                ),
              ),
            ),
            Container(height: 10),
            Container(
              height: 44.0,
              width: 120,
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.grey, Colors.white])),
              child: ElevatedButton(
                onPressed: () async {
                  theme.setthemeData(StyleSettings.lightTheme(context));
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('theme', 'lightTheme');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: Text('Día'),
              ),
            ),
            Container(height: 10),
            Container(
              height: 44.0,
              width: 120,
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.blue, Colors.black12])),
              child: ElevatedButton(
                onPressed: () async {
                  theme.setthemeData(StyleSettings.darkBlueTheme(context));
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('theme', 'darkBlueTheme');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                child: Text('Azul noche'),
              ),
            ),
            Container(height: 10),
            Container(
              height: 44.0,
              width: 120,
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.blue, Colors.white])),
              child: ElevatedButton(
                onPressed: () async {
                  theme.setthemeData(StyleSettings.lightBlueTheme(context));
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('theme', 'lightBlueTheme');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,
                    shadowColor: Colors.transparent),
                child: Text('Azul día'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

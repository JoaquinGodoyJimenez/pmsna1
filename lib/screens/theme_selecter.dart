import 'package:flutter/material.dart';
import 'package:pmsna1/provider/theme_provider.dart';
import 'package:pmsna1/settings/styles_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSelecter extends StatefulWidget {
  const ThemeSelecter({Key? key}) : super(key: key);

  @override
  State<ThemeSelecter> createState() => _ThemeSelecterState();
}

class _ThemeSelecterState extends State<ThemeSelecter> {
  late ThemeProvider theme;

  Future<void> _setTheme(String themeName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', themeName);
  }

  @override
  void initState() {
    super.initState();
    theme = Provider.of<ThemeProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: .4,
            fit: BoxFit.cover,
            image: AssetImage('assets/fondo_itc.jpg'),
          ),
        ),
        child: Column(
          children: [
            Container(height: 250),
            Center(
              child: Container(
                height: 44.0,
                width: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey, Colors.black12],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    theme.setthemeData(StyleSettings.darkTheme(context));
                    _setTheme('darkTheme');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Para aplicar los cambios es necesario reiniciar')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text('Noche'),
                ),
              ),
            ),
            Container(height: 10),
            Container(
              height: 44.0,
              width: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey, Colors.white],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  theme.setthemeData(StyleSettings.lightTheme(context));
                  _setTheme('lightTheme');
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Para aplicar los cambios es necesario reiniciar')),
          );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: const Text('Día'),
              ),
            ),
            Container(height: 10),
            Container(
              height: 44.0,
              width: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.black12],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  theme.setthemeData(StyleSettings.darkBlueTheme(context));
                  _setTheme('darkBlueTheme');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Para aplicar los cambios es necesario reiniciar')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                child: const Text('Azul noche'),
              ),
            ),
            Container(height: 10),
            Container(
              height: 44.0,
              width: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.white],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  theme.setthemeData(StyleSettings.lightBlueTheme(context));
                  _setTheme('lightBlueTheme');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Para aplicar los cambios es necesario reiniciar')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                  shadowColor: Colors.transparent,
                ),
                child: const Text('Azul día'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:pmsna1/provider/theme_provider.dart';
import 'package:pmsna1/screens/list_post.dart';
import 'package:pmsna1/settings/styles_settings.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {

    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Social TEC :) !'),
      ),
      body: ListPost(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.pushNamed(context, '/add').then((value) {
            setState(() {});
          });
        },
        label: const Text('Add post!'),
        icon: const Icon(Icons.add_comment),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/logo_itc.png"),
              ),
              accountName: Text('Joaquin Godoy Jimenez'), 
              accountEmail: Text('19030394@itcelaya.edu.mx')
            ),
            ListTile(
              onTap: () {Navigator.pushNamed(context, '/register');},
              title: Text('Práctica 1'),
              subtitle: Text('Registrar un usuario'),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              title: Text('Práctica 2'),
              subtitle: Text('Diseño responsivo'),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/board');
              },
              title: Text('Práctica 3'),
              subtitle: Text('Acerca de la institución'),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/events');
              },
              title: Text('Práctica 4'),
              subtitle: Text('Calendario de eventos'),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () => Navigator.pushNamed(context, '/popular'),
              title: Text('API Videos'),
              leading: Icon(Icons.movie),
              trailing: Icon(Icons.chevron_right),
            ),
            DayNightSwitcher(
              isDarkModeEnabled: isDarkModeEnabled, 
              onStateChanged: (isDarkModeEnabled) {
                isDarkModeEnabled
                ? theme.setthemeData(StyleSettings.darkTheme(context))
                : theme.setthemeData(StyleSettings.lightTheme(context));
                this.isDarkModeEnabled = isDarkModeEnabled;
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}
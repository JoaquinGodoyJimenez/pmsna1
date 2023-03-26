import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EventosScreen extends StatefulWidget {
  const EventosScreen({super.key});

  @override
  State<EventosScreen> createState() => _EventosScreenState();
}

class _EventosScreenState extends State<EventosScreen> {
  bool _showCalendar = true;
  String _appBarTitle = "Calendario de Eventos";
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_showCalendar ? Icons.list : Icons.calendar_today),
            onPressed: () {
              setState(() {
                _showCalendar = !_showCalendar;
                _appBarTitle = _showCalendar
                    ? 'Calendario de Eventos'
                    : 'Lista de Eventos';
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          if (_showCalendar)
            TableCalendar(
                locale: 'es_ES',
                rowHeight: 43,
                headerStyle: const HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),
                focusedDay: today,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2029, 12, 31),
                onDaySelected: _onDaySelected),
          if (!_showCalendar)
            CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const ListTile(
                        leading: Icon(Icons.calendar_today),
                        title: Text('Evento 1'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.calendar_today),
                        title: Text('Evento 2'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.calendar_today),
                        title: Text('Evento 3'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add').then((value) {
                  setState(() {});
                });
              },
              tooltip: 'Agregar evento',
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}

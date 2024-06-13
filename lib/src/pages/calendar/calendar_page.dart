import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../helpers/theme_colors.dart';

import '../../helpers/theme_colors.dart';
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void _addEvent(DateTime date, String event) {
    if (_events[date] != null) {
      _events[date]!.add(event);
    } else {
      _events[date] = [event];
    }
  }

  void _editEvent(DateTime date, int index, String newEvent) {
    setState(() {
      _events[date]![index] = newEvent;
    });
  }

  void _showAddEventDialog() {
    String eventName = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Agregar Evento'),
        content: TextField(
          onChanged: (value) {
            eventName = value;
          },
          decoration: InputDecoration(hintText: 'Nombre del evento'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (eventName.isNotEmpty) {
                setState(() {
                  _addEvent(_selectedDay!, eventName);
                });
              }
              Navigator.of(context).pop();
            },
            child: Text('Agregar'),
          ),
        ],
      ),
    );
  }

  void _showEditEventDialog(DateTime date, int index, String currentEvent) {
    String editedEvent = currentEvent;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Evento'),
        content: TextField(
          onChanged: (value) {
            editedEvent = value;
          },
          controller: TextEditingController(text: currentEvent),
          decoration: InputDecoration(hintText: 'Nombre del evento'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (editedEvent.isNotEmpty) {
                setState(() {
                  _editEvent(date, index, editedEvent);
                });
              }
              Navigator.of(context).pop();
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario de Eventos'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getEventsForDay,
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: _getEventsForDay(_selectedDay!).length,
              itemBuilder: (context, index) {
                String event = _getEventsForDay(_selectedDay!)[index];
                return ListTile(
                  title: Text(event),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _showEditEventDialog(_selectedDay!, index, event);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack',
      home: CalendarScreen(),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  final userInputName = TextEditingController();
  final userInputPrice = TextEditingController();
  final userInputDescription = TextEditingController();

  int _selectedIndex = 0;

  bool showEvents = true;

  final List<NeatCleanCalendarEvent> _todaysEvents = [
    NeatCleanCalendarEvent(
      'Event A',
      startTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0),
      endTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 0),
      description: 'A special event',
      color: Colors.blue[700],
    ),
  ];

  final List<NeatCleanCalendarEvent> _eventList = [
    NeatCleanCalendarEvent(
      'MultiDay Event A',
      description: 'test desc',
      startTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0),
      endTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + 2, 12, 0),
      color: Colors.orange,
      isMultiDay: true,
    ),
    NeatCleanCalendarEvent('Event X',
        description: 'test desc',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 11, 30),
        color: Colors.lightGreen,
        isAllDay: false,
        isDone: true,
        //icon: 'assets/event1.jpg',
        wide: false),
    NeatCleanCalendarEvent('Allday Event B',
        description: 'test desc',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day - 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: Colors.pink,
        isAllDay: true,
        //icon: 'assets/event1.jpg',
        wide: false),
    NeatCleanCalendarEvent(
      'Normal Event D',
      description: 'test desc',
      startTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 14, 30),
      endTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 17, 0),
      color: Colors.indigo,
      wide: true,
      //icon: 'assets/event1.jpg',
    ),
    NeatCleanCalendarEvent(
      'Normal Event E',
      description: 'test desc',
      startTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 7, 45),
      endTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0),
      color: Colors.indigo,
      wide: true,
      //icon: 'assets/event1.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Force selection of today on first load, so that the list of today's events gets shown.
    _handleNewDate(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          // Calendario y ajustes de color etc
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  child: Calendar(
                    startOnMonday: true,
                    eventsList: _eventList,
                    weekDays: const [
                      'Lunes',
                      'Martes',
                      'Miercoles',
                      'Jueves',
                      'Viernes',
                      'Sabado',
                      'Domingo'
                    ],
                    isExpandable: true,
                    eventDoneColor: Colors.green,
                    selectedColor: const Color.fromRGBO(231, 29, 97, 1),
                    selectedTodayColor: Colors.green,
                    todayColor: const Color.fromARGB(255, 255, 0, 0),
                    eventColor: null,
                    locale: 'es_ES',
                    isExpanded: true,
                    expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                    onEventSelected: (value) {
                      print('Event selected ${value.summary}');
                    },
                    onEventLongPressed: (value) {
                      print('Event long pressed ${value.summary}');
                    },
                    onMonthChanged: (value) {
                      print('Month changed $value');
                    },
                    onDateSelected: (value) {
                      print('Date selected $value');
                    },
                    onRangeSelected: (value) {
                      print('Range selected ${value.from} - ${value.to}');
                    },
                    datePickerType: DatePickerType.date,
                    dayOfWeekStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 11),
                    showEvents: showEvents,
                  ),
                ),
              ),
            ],
          ),
        ),
        //Funcionamiento del boton de abajo a la derecha de la app, Inputs del ususario Nombre de producto, precio y descripcion

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showEvents = !showEvents;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  title: const Text("Agregar producto"),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Nombre del producto",
                              icon: Icon(Icons.account_box),
                            ),
                            controller: userInputName,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Precio",
                              icon: Icon(Icons.price_change_outlined),
                            ),
                            controller: userInputPrice,
                          ),
                          TextFormField(
                            minLines: 1,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              labelText: "Informacion sobre el producto",
                              icon: Icon(Icons.info),
                            ),
                            controller: userInputDescription,
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      child: const Text("Aceptar"),
                      onPressed: () {
                        //Navigator.pop(context, context) le pasas el context del dialog para poder cerrarlo cuando se da click a aceptar
                        Navigator.pop(context, context);
                        _createItem();
                      },
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: Colors.green,
          child: Icon(showEvents ? Icons.add : Icons.add),
        ),
        //Botones de navegacion de la parte de abajo de la app, Home, Total and Ajustes
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet),
              label: 'Total',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Ajustes',
            ),
          ],
        ));
  }

  void _handleNewDate(date) {
    //print('Date selected: $date');
  }

  void _createItem() {
    // Crear producto y coger los datos del mismo para agregarlo a la lista
    print(userInputName.text);
    print(userInputPrice.text);
    print(userInputDescription.text);

    userInputName.clear();
    userInputPrice.clear();
    userInputDescription.clear();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

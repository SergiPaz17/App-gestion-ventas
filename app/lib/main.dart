import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:stack/profile.dart';
import 'package:stack/total.dart';
import 'package:stack/userlogin.dart';


import 'package:supabase/supabase.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://grbrlmomycarbycslati.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYnJsbW9teWNhcmJ5Y3NsYXRpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDYxODc3NzAsImV4cCI6MjAyMTc2Mzc3MH0.-NUf8aDmjbwTQxsn2Supd3gT12xO4_F9wH5EnrgsiMo',
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack',
      home: CalendarScreen(),
      routes: {
    '/createprofile': (context) =>  userlogin(),
    '/calendarScreen': (context) =>  CalendarScreen(),
    '/total': (context) => total(),
    '/profile': (context) => profile()

  },
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


  String nombre = "";
  String descripcion = "";
  String precio = "";

  int _selectedIndex = 0;

  bool showEvents = true;

  bool isLogued = false;


  final List<NeatCleanCalendarEvent> _eventList = [];
  

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
                    selectedTodayColor: Colors.pink,
                    todayColor: const Color.fromARGB(255, 255, 0, 0),
                    eventColor: null,
                    locale: 'es_ES',
                    isExpanded: true,
                    expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                    onEventSelected: (value) {
                      print('Event selected ${value.summary}');
                    },
                    onEventLongPressed: (value) {
                    showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  title: const Text("Eliminar venta"),
                  content: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Form(
                      child: Column(
                        children: [
                          Text("Seguro que quiere eliminar la venta?", style: TextStyle(fontWeight: FontWeight.bold))
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
                          _eventList.remove(value);
                          setState(() {});
                      },
                    ),
                    ElevatedButton(
                      child: const Text("Cancelar"),
                      onPressed: () {
                        //Navigator.pop(context, context) le pasas el context del dialog para poder cerrarlo cuando se da click a aceptar
                          Navigator.pop(context, context);
                      },
                    ),
                  ],
                );
              },
            );

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
              ),const Text("Testing de la aplicacion no se que"),
              
            ],
          ),
        ),
        //Funcionamiento del boton de abajo a la derecha de la app, Inputs del ususario Nombre de producto, precio y descripcion

        floatingActionButton: FloatingActionButton(
          onPressed: () {
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
          backgroundColor: const Color.fromARGB(255, 240, 76, 131),
          child: const Icon(Icons.add),
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
              icon: Icon(Icons.person),
              label: 'Perfil',
              
            ),
          ],
        ));
  }

  

  void _handleNewDate(date) {
    //print('Date selected: $date');
  }

  void _createItem() {
    // Crear producto y coger los datos del mismo para agregarlo a la lista

    nombre = userInputName.text;
    descripcion = userInputDescription.text;
    precio = userInputPrice.text;



    _eventList.add(
      NeatCleanCalendarEvent(
      nombre,
      description: descripcion,
      startTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute),
      endTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 0),
      price: precio,
      color: Colors.pink,
    ),);
    //print(_eventList[2].description);

    userInputName.clear();
    userInputPrice.clear();
    userInputDescription.clear();

    setState(() {});

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;});
      switch(index){
        case 2:
        if(!isLogued) { 
        Navigator.of(context).pushNamedAndRemoveUntil('/profile', (Route route) => false);
        }
        else { 
          Navigator.of(context).pushNamedAndRemoveUntil('/profile', (route) => false);
          // Crear pantalla para el perfil del usuario 
        }                            
        case 1: 
        Navigator.of(context).pushNamedAndRemoveUntil('/total', (Route route) => false);

      }
  }
}

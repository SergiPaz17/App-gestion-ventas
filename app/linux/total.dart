import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:stack/main.dart';


import 'package:supabase/supabase.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'userlogin.dart';

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
      home: total(),

    routes: {
    '/profile': (context) =>  userlogin(),
    '/calendarScreen': (context) =>  CalendarScreen(),
    '/total': (context) => total(),

  },

      
    );
    
  }
}

class total extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _total();
  }
}

class _total extends State<total> {


  @override
  void initState() {
    super.initState();
 
  }
    int _selectedIndex = 1;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: const Column(
          children: [Text("holfhgkehfkljseflha")],
        
        
        ),
        //Funcionamiento del boton de abajo a la derecha de la app, Inputs del ususario Nombre de producto, precio y descripcion

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
    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;});
          switch(index){
        case 0:                             
        Navigator.of(context).pushNamedAndRemoveUntil('/calendarScreen', (Route route) => false);
        case 2:
        Navigator.of(context).pushNamedAndRemoveUntil('/profile', (Route route) => false);

      }
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:stack/main.dart';


import 'package:supabase/supabase.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'total.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://grbrlmomycarbycslati.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYnJsbW9teWNhcmJ5Y3NsYXRpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDYxODc3NzAsImV4cCI6MjAyMTc2Mzc3MH0.-NUf8aDmjbwTQxsn2Supd3gT12xO4_F9wH5EnrgsiMo',
  );
  runApp(const MyApp());
}
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: userlogin(),
      
      routes: {
    '/profile': (context) =>  userlogin(),
    '/calendarScreen': (context) =>  CalendarScreen(),
    '/total': (context) => total(),

  },
      
    );
    
  }
}

class userlogin extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
    return _userlogin();
  }
}


class _userlogin extends State<userlogin> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userController= TextEditingController();

  String email = "";
  String password = "";
  String usuario = "";

  bool islogin = true;

  @override
  void initState() {
    super.initState();
 
  }
    int _selectedIndex = 2;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Form(
        key: _formKey,
        child: 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                
                children: <Widget>[
                  Expanded(child:               
                  Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 50.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if(!islogin){
                      changeIsLogin();
                      }
                    },
                    child: const Text('Login'),
                  ),
                ),
              ),),

              Expanded(child:              
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if(islogin){
                        changeIsLogin();
                      }
                      
                    },
                    child: const Text('Register'),
                  ),
                ),
              ), )
                ],
              ),
                    
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: userController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Usuario"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduzca su usuario';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: !islogin ? TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduzca su email';
                    }
                    return null;
                  },
                ) : const Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
              ),
              ),

              
              Padding(
                padding: 
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child:  TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Contraseña"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduzca su contraseña';
                    }
                    return null;
                  },
                ),
              ),
              
              
              ElevatedButton(
                    onPressed: () {
                      if(islogin){
                        _checkUserLogin();

                      }else{
                    
                      if (_formKey.currentState!.validate()) {
                        _createUser();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Usuario creado')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Por favor compruebe los campos')),
                        );
                      }
                      }
                    },

                    child: islogin ?  const Text('Login') : const Text('Register'),
          )],
          ),
        ),
      ),        //Botones de navegacion de la parte de abajo de la app, Home, Total and Ajustes
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
        case 1: 
        Navigator.of(context).pushNamedAndRemoveUntil('/total', (Route route) => false);
      }
  }

  void _createUser() async {

    email = emailController.text;
    password = passwordController.text;
    usuario = userController.text;

    await supabase
    .from('users')
    .insert({'name': usuario, 'password': password, 'email': email});


  }

  void _checkUserLogin() async {

    usuario = userController.text;
    password = passwordController.text;

    bool result;

    result = (await supabase.from('users').select('name, email, password').eq('name',usuario)).isNotEmpty;


    if(result){
      print(result);
      //Navigator.of(context).pushNamedAndRemoveUntil('/calendarScreen', (Route route) => false);
    }
    else{
      print("No hay usuario puto");
    }
  }

     void changeIsLogin(){
      setState(() {
       islogin = !islogin;
       });
    }
}


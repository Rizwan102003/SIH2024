import 'package:flutter/material.dart';
import 'package:hexa/login.dart';
import 'package:hexa/sign_up.dart';
import 'package:hexa/user_homepage.dart';
import 'package:hexa/welcome.dart';
import 'package:hexa/user_optionchoose.dart';

import 'package:hexa/admin_homepage.dart';
import 'package:hexa/doctor_homepage.dart';








//This is the first or the Welcome Page of the Project

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home:const Welcome(),
      routes: {
        '/login':(context)=>MyLogin(),
        '/signup':(context)=>MySign(),
        '/UserChoose':(context)=>UserChoose(),
        '/UserHomePage':(context)=> UserHomepage(),

         '/admin':(context)=>AdminPage(),
        '/doctor':(context)=>NewDashboardPage(),

    }
    );
  }
}




    }
    );
  }

void main() {
  runApp(MaterialApp(home: Text("Hello World")));

}


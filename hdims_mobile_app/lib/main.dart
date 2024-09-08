import 'package:flutter/material.dart';
import 'package:hexa/admin_login.dart';
import 'package:hexa/ai-assistant.dart';
import 'package:hexa/doctor_login.dart';
import 'package:hexa/doctor_signup.dart';
import 'package:hexa/heart_disease.dart';
import 'package:hexa/login.dart';
import 'package:hexa/parkinson.dart';
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
        '/doctorlogin':(context)=>MyLogin1(),
        '/adminlogin':(context)=>MyLogin2(),
        '/doctorsignup':(context)=>MySign1(),
        '/aibot':(context)=>ChatPage(),
        '/heart':(context)=>HeartDiseaseDetectionPage(),
        '/parkin':(context)=>ParkinsonsDiseaseDetectionPage(),
    }
    );
  }
}


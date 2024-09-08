import 'package:flutter/material.dart';
import 'package:hexa/login.dart';
import 'package:hexa/sign_up.dart';
import 'package:flutter/widgets.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(

            height: double.infinity,
            width: double.infinity,
          decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/welcome.jpg'),
          fit:BoxFit.cover),
          ),
          padding: EdgeInsets.all(16.0),

            child:SingleChildScrollView(
            child:Column(
              children: [
                Text ('WELCOME',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Font1',
                      ),
                    ),
                   Text ('TO',
                    style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.black,
                      fontFamily: 'Font1',
                    ),
                  ),
                Text ('HDIMS',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Font1'
                  ),
                ),
                  SizedBox(
                    height: 35,
                  ),

                  SizedBox(
                    height: 35,
                  ),
                  Text('Please select your profile',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                SizedBox(
                  height: 35,
                ),
                ElevatedButton(onPressed: () {
                  Navigator.pushNamed(context, '/UserChoose');
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shadowColor: Colors.blueGrey,
                    minimumSize: Size(20,53),
                  ),
                  child: Text('PATIENT',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                    ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: () {
                    Navigator.pushNamed(context, '/doctorlogin');
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shadowColor: Colors.blueGrey,
                    minimumSize: Size(20,53),
                  ),
                  child: Text('DOCTOR',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: () {
                  Navigator.pushNamed(context, '/adminlogin');
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shadowColor: Colors.blueGrey,
                    minimumSize: Size(20,53),
                  ),
                  child: Text('ADMIN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
    ),
        ),

        );


  }
}
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
          image: DecorationImage(image: AssetImage('assets/homescreen.jpeg'),
          fit:BoxFit.cover),
          ),
          padding: EdgeInsets.only(top: 150,bottom:100,left: 20),

            child:SingleChildScrollView(
            child:Column(
              children: [
                Text ('WELCOME',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                   Text ('TO',
                    style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.black,
                    ),
                  ),
                Text ('HDIMS',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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
                      fontWeight: FontWeight.bold,
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
                  child: Text('USER',
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
                    Navigator.pushNamed(context, '/doctor');
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
                  Navigator.pushNamed(context, '/admin');
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

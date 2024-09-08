import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hexa/user_optionchoose.dart';
//Making the login page
class MyLogin2 extends StatefulWidget {
  const MyLogin2({super.key});

  @override
  State<MyLogin2> createState() => _MyLogin2State();
}

class _MyLogin2State extends State<MyLogin2> {
  //sign user in method



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image:DecorationImage(
          image: AssetImage('assets/doctor.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.blue[500],
        ),
        body:Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 130,left: 105),
              child: Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Font1',
                ),
              ),
            ),
            //enable scrolling on screen
            SingleChildScrollView(
              child: Container(
                //padding set to satisfy any screen size
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5,
                  right: 35,
                  left: 35,
                ),
                child: Column(
                  children: [
                    //Email bar and password bar
                    TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,//insert the color
                          hintText: 'Email',
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),

                    //create space between the two textfiles
                    SizedBox(
                      height: 30,
                    ),


                    //Password Bar
                    TextField(
                      //to make the password hidden
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,//insert the color
                          hintText: 'Password',
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //forget password link

                    SizedBox(
                      height: 20,
                    ),
                    Row(

                      children: [Text('Do not have an account?',
                        style:TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ) ,),
                        //signup link
                        TextButton(onPressed: () {
                          Navigator.pushNamed(context,'/signup' );
                        },
                          child: Text('Sign Up',
                            style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          ),
                        ),

                      ],
                    ),
                    //a different dart file for login button
                    SizedBox(
                      height: 20,
                    ),

                    ElevatedButton(onPressed: () {
                      Navigator.pushNamed(context, '/admin');
                    },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shadowColor: Colors.blueAccent,
                          minimumSize: Size(20, 70),
                        ),
                        child: Text('LOGIN',
                          style: TextStyle(

                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
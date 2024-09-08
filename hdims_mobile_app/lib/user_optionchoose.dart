import 'package:flutter/material.dart';
import 'package:hexa/main.dart';
import 'package:hexa/welcome.dart';
import 'package:hexa/login.dart';
import 'package:hexa/welcome.dart';


import 'package:flutter/material.dart';
class UserChoose extends StatefulWidget {
  @override
  _UserChooseState createState() => _UserChooseState();
}

class _UserChooseState extends State<UserChoose> {
  // State variables for hover and click effects
  bool _isHoveringLogin = false;
  bool _isHoveringCreateAccount = false;
  bool _isPressedLogin = false;
  bool _isPressedCreateAccount = false;

  @override
  Widget build(BuildContext context) {
return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
      ),
      body: Container(
        // Set the solid color background here
        decoration: BoxDecoration(
           image: DecorationImage(image: AssetImage('assets/userchoose.jpg'),
           fit:BoxFit.cover,)
        ),







          padding: EdgeInsets.only(top:50,left:30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(

                  'WELCOME ',

                  style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Font1',
                  ),
                ),
            Text('USER',

            style: TextStyle(
              fontSize: 55,
              fontFamily: 'Font1',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
                SizedBox(height: 30),
                MouseRegion(
                  onEnter: (_) => setState(() => _isHoveringLogin = true),
                  onExit: (_) => setState(() => _isHoveringLogin = false),
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      print('Login tapped');
                    },
                    onTapDown: (_) => setState(() => _isPressedLogin = true),
                    onTapUp: (_) => setState(() => _isPressedLogin = false),
                    onTapCancel: () => setState(() => _isPressedLogin = false),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: _isHoveringLogin
                              ? [Colors.indigo[700]!, Colors.blue[400]!]
                              : [Colors.indigo, Colors.indigoAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: _isPressedLogin
                            ? [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.7),
                            spreadRadius: 4,
                            blurRadius: 20,
                            offset: Offset(0, 0),
                          ),
                        ]
                            : [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),


                       child: TextButton(
                         onPressed: () {
                           Navigator.pushNamed(context, '/login');
                         },
                         child: Text('LOGIN',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                      ),
                      ),
                    ),
                  ),

                SizedBox(height: 30,),
                MouseRegion(
                  onEnter: (_) => setState(() => _isHoveringCreateAccount = true),
                  onExit: (_) => setState(() => _isHoveringCreateAccount = false),
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      print('Create an Account tapped');
                    },
                    onTapDown: (_) =>
                        setState(() => _isPressedCreateAccount = true),
                    onTapUp: (_) =>
                        setState(() => _isPressedCreateAccount = false),
                    onTapCancel: () =>
                        setState(() => _isPressedCreateAccount = false),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: _isHoveringCreateAccount
                              ? [Colors.green[700]!, Colors.lightGreen[400]!]
                              : [Colors.teal, Colors.lightGreenAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: _isPressedCreateAccount
                            ? [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.7),
                            spreadRadius: 4,
                            blurRadius: 20,
                            offset: Offset(0, 0),
                          ),
                        ]
                            : [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text('Create an Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
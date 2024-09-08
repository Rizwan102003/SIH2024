import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexa/user_optionchoose.dart';
class MyLogin1 extends StatefulWidget {
  const MyLogin1({super.key});

  @override
  State<MyLogin1> createState() => _MyLogin1State();
}

class _MyLogin1State extends State<MyLogin1> {
  //sign user in method
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;

  final FlutterSecureStorage storage = FlutterSecureStorage();

  void signIn() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var loginBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      var response = await http.post(
        Uri.parse("http://10.0.2.2:8000/doctorAuth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(loginBody),
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        var responseBody = jsonDecode(response.body);

        // Check if response contains token
        if (responseBody['status'] == true && responseBody['token'] != null) {
          String token = responseBody['token'];

          // Store the token securely
          await storage.write(key: 'token', value: token);

          Navigator.pushNamed(context, '/doctor');
        } else {
          setState(() {
            _isNotValidate = true; // Handle invalid response case
          });
        }
      } else {
        // Handle HTTP error response
        setState(() {
          _isNotValidate = true;
        });
      }
    } else {
      setState(() {
        _isNotValidate = true; // Handle empty fields
      });
    }
  }


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
                      controller: emailController,
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
                      controller:passwordController,
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
                          Navigator.pushNamed(context,'/doctorsignup' );
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
                      Navigator.pushNamed(context, '/doctor');
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
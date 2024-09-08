import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Making the sign page
class MySign1 extends StatefulWidget {
  const MySign1({super.key});

  @override
  State<MySign1> createState() => _MySign1State();
}

  String usernameController = "abcdadmin";
  TextEditingController institutionEmailController = TextEditingController();
  String institutionNameController = "heritage";
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;

  // Sign up method
  void registerUser() async {
    if (institutionEmailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      var regBody = {
        "username":"",
        "InstitutionEmail": institutionEmailController.text,
        "InstitutionName": "",
        "password": passwordController.text
      };
      var response = await http.post(
        Uri.parse("http://localhost:8000/adminAuth/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/doctor');
      } else {
        setState(() {
          _isNotValidate = true;
        });
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/doctor.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.blue[500],
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 130, left: 85),
              child: Text(
                'SIGNUP',
                style: TextStyle(
                  fontSize: 55,
                  fontFamily: 'Font1',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            // Enable scrolling on screen
            SingleChildScrollView(
              child: Container(
                // Padding set to satisfy any screen size
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5,
                  right: 35,
                  left: 35,
                ),
                child: Column(
                  children: [
                    // Username field
                    TextField(
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true, // Insert the color
                        hintText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    // Space between text fields
                    SizedBox(height: 30),
                    // Institution Email field
                    TextField(
                      controller: institutionEmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true, // Insert the color
                        hintText: 'Institution Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    // Space between text fields
                    SizedBox(height: 30),
                    // Institution Name field
                    TextField(
                      controller: institutionNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true, // Insert the color
                        hintText: 'Institution Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    // Space between text fields
                    SizedBox(height: 30),
                    // Password field
                    TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true, // Insert the color
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Please fill all fields" : null,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // Space before the sign-up button
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        print("Sign Up");
                        registerUser();
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          registerUser();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shadowColor: Colors.blueAccent,
                          minimumSize: Size(20, 70),
                        ),
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Font1',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

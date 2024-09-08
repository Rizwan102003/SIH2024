import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import this for JSON encoding
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NewDashboardPage extends StatefulWidget {
  @override
  _NewDashboardPageState createState() => _NewDashboardPageState();
}

class _NewDashboardPageState extends State<NewDashboardPage> {
  bool _isChatVisible = false;
  bool _isVideoCallVisible = false;
  bool _isFloatingContainerVisible = false;
  String _patientID = '';
  TextEditingController _patientIDController = TextEditingController();

  // Define the server URL here
  final String serverUrl = 'https://10.0.2.2:8000/doctorAuth/}';

  // Initialize FlutterSecureStorage
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  _buildMenuButton(),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildPatientIDContainer(),
                if (_isFloatingContainerVisible) _buildPDFContainer(),
              ],
            ),
          ),
          if (_isVideoCallVisible) _buildVideoCallContainer(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleVideoCallContainer,
        backgroundColor: Colors.lightGreen,
        child: Icon(
          Icons.video_call,
          size: 28,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMenuButton() {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.menu,
        color: Colors.white,
      ),
      onSelected: (String value) {
        switch (value) {
          case 'AI Assistant':
            Navigator.pushNamed(context, '/aibot');
            print('AI Assistant Selected');
            break;
          case 'Heart Disease':
            Navigator.pushNamed(context,'/heart');
            print('Heart Disease Selected');
            break;
          case 'Parkinson\'s Disease':
            Navigator.pushNamed(context,'/parkin');
            print('Parkinson\'s Disease Selected');
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'AI Assistant',
            child: Text('AI Assistant'),
          ),
          PopupMenuItem(
            value: 'Heart Disease',
            child: Text('Heart Disease'),
          ),
          PopupMenuItem(
            value: 'Parkinson\'s Disease',
            child: Text('Parkinson\'s Disease'),
          ),
        ];
      },
    );
  }

  void _toggleVideoCallContainer() {
    setState(() {
      _isVideoCallVisible = !_isVideoCallVisible;
    });
  }

  void _toggleFloatingContainer() {
    setState(() {
      _isFloatingContainerVisible = !_isFloatingContainerVisible;
    });
  }

  Widget _buildPatientIDContainer() {
    return Container(
      height: 450,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/dashboard.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: _patientIDController,
            decoration: InputDecoration(
              fillColor: Colors.grey[300],
              filled: true,
              labelText: 'Type the Patient ID',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 10),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    bool _isHovering = false;
    bool _isTapped = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) {
            setState(() {
              _isHovering = true;
            });
          },
          onExit: (_) {
            setState(() {
              _isHovering = false;
            });
          },
          child: GestureDetector(
            onTapDown: (_) {
              setState(() {
                _isTapped = true;
              });
            },
            onTapUp: (_) {
              setState(() {
                _isTapped = false;
                _patientID = _patientIDController.text;
                _submitPatientID(); // Call the function to submit the patient ID
                _toggleFloatingContainer();
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              decoration: BoxDecoration(
                color: _isTapped
                    ? Colors.blue[900]
                    : _isHovering
                    ? Colors.blue[700]
                    : Colors.blue[800],
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPDFContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'PDF content will be displayed here...',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.blueGrey[800],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildVideoCallContainer() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            width: 150.0,
            height: 150.0,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              Icons.video_call,
              size: 60.0,
              color: Colors.blueGrey[700],
            ),
          ),
        ),
      ),
    );
  }

  // Function to submit the patient ID to the server
  Future<void> _submitPatientID() async {
    try {
      final response = await http.post(
        Uri.parse(serverUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'patientID': _patientID}),
      );

      if (response.statusCode == 200) {
        // If the server returns an OK response, parse the JSON.
        print('Patient ID submitted successfully.');
        // Handle the response or update the UI as needed
      } else {
        // If the server did not return a 200 OK response, throw an error.
        print('Failed to submit Patient ID. Server response: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while submitting Patient ID: $e');
    }
  }
}

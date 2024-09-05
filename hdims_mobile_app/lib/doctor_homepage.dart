import 'package:flutter/material.dart';


class NewDashboardPage extends StatefulWidget {
  @override
  _NewDashboardPageState createState() => _NewDashboardPageState();
}

class _NewDashboardPageState extends State<NewDashboardPage> {
  bool _isChatVisible = false; // State variable to control chat container visibility
  bool _isDetailsVisible = false; // State variable to control patient details container visibility
  String _patientID = ''; // Variable to store the patient ID
  TextEditingController _patientIDController = TextEditingController();

  List<String> _chatMessages = []; // List to store chat messages
  TextEditingController _chatMessageController = TextEditingController(); // Controller for the chat input
  ScrollController _chatScrollController = ScrollController(); // Controller for scrolling the chat

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Dashboard',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color:Colors.white,
            ),),
            SizedBox(width: 40),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: _buildRoundButton(),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: Stack(
        children: [
          SingleChildScrollView( // Make the page scrollable
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildPatientIDContainer(),
                if (_isDetailsVisible) _buildPatientDetailsContainer(),
              ],
            ),
          ),
          if (_isChatVisible) _buildChatContainer(), // Show the chat container if it's visible
        ],
      ),
    );
  }

  // Method to build the round button next to the "Dashboard" title
  Widget _buildRoundButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isChatVisible = !_isChatVisible; // Toggle the chat container visibility
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300), // Smooth transition
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.green, Colors.lightGreen],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Icon(Icons.chat, color: Colors.white), // Chat icon inside the button
        ),
      ),
    );
  }

  // Method to build the chat container
  Widget _buildChatContainer() {
    return Positioned(
      bottom: 20.0,
      right: 20.0,
      left: 20.0,
      child: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          height: 300, // Set fixed height for chat container
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Text(
                'Talk to Us!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[600],
                ),
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: ListView.builder(
                  controller: _chatScrollController, // Use ScrollController
                  itemCount: _chatMessages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            _chatMessages[index],
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildChatInput(),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build the chat input field and send button
  Widget _buildChatInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _chatMessageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blueGrey[800]),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  // Method to send a message
  void _sendMessage() {
    if (_chatMessageController.text.isNotEmpty) {
      setState(() {
        _chatMessages.add(
            _chatMessageController.text); // Add the message to the list
        _chatMessageController.clear(); // Clear the input field
      });

      // Scroll to the bottom when a new message is added
      _chatScrollController.animateTo(
        _chatScrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  // Method to build the container for typing the Patient ID
  Widget _buildPatientIDContainer() {
    return Center(
        child: Container(
      height: 450,
      width: 1000,
      padding: const EdgeInsets.only(top:175,left:16,right:16,bottom:16),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/dashboard.png'),
        fit:BoxFit.cover,),
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
              labelText: 'Type the Patient ID',
              fillColor: Colors.grey.shade100,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 10,),
          _buildSubmitButton(),
        ],
      ),
        ),
    );
  }

  // Method to build the submit button
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
                _showPatientDetails();
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              decoration: BoxDecoration(
                color: _isTapped
                    ? Colors.blueAccent[900]
                    : _isHovering
                    ? Colors.blue[700]
                    : Colors.blue[800],
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
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

  // Method to build the patient details container
  Widget _buildPatientDetailsContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50]?.withOpacity(0.8),
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
          Text(
            'Patient Details for ID: $_patientID',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 150,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailText('Name:'),
                  _buildDetailText('Age:'),
                  _buildDetailText('Birthdate:'),
                  _buildDetailText('Gender:'),
                  _buildDetailText('Height:'),
                  _buildDetailText('Weight:'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailText(String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        detail,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blueGrey[800],
        ),
      ),
    );
  }

  void _showPatientDetails() {
    setState(() {
      _isDetailsVisible = true;
    });
  }
}

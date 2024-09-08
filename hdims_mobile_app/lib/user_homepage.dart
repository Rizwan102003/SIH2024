import 'package:flutter/material.dart';

class UserHomepage extends StatefulWidget {
  @override
  _UserHomepageState createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  bool _isChatVisible = false; // State variable to control chat container visibility
  List<String> _messages = []; // List to store chat messages
  TextEditingController _messageController = TextEditingController();


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
                color: Colors.white,
                fontSize: 40,
              ),
            ),
            SizedBox(width: 30), // Increase spacing between title and button
            Padding(
              padding: const EdgeInsets.only(right: 8.0), // Move button slightly to the right
              child: _buildRoundButton(),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800], // Darker background color for AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent[100],
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              // Make the page scrollable
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildInfoContainer(),
                  SizedBox(height: 20),
                  _buildButton(
                      'Update Details', Colors.blueAccent[200], Colors.lightBlue[200]), // "Update Details" button
                  SizedBox(height: 10),
                  _buildButton(
                      'My records', Colors.blue[800], Colors.lightBlueAccent), // "My records" button
                  SizedBox(height: 20),
                  _buildNoticesContainer(), // New "Notices" container
                ],
              ),
            ),
            if (_isChatVisible) _buildChatContainer(), // Show the chat container if it's visible
          ],
        ),
      ),
    );
  }

  // Method to build the round button next to the "Dashboard" title
  Widget _buildRoundButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Change cursor to pointer
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

  // Method to build the floating chat container
  Widget _buildChatContainer() {
    return Positioned(
      bottom: 20.0,
      right: 20.0,
      left: 20.0,
      child: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95), // Opaque background
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Talk to Us!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[600], // Light grey heading
                ),
              ),
              SizedBox(height: 10.0),
              Flexible(
                child: Container(
                  height: 200, // Set a max height for the chat container
                  child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_messages[index]),
                      );
                    },
                  ),
                ),
              ),
              TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send, color: Colors.blueGrey[800]),
                    onPressed: () {
                      setState(() {
                        if (_messageController.text.isNotEmpty) {
                          _messages.add(_messageController.text); // Add the message to the list
                          _messageController.clear(); // Clear the text field
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/dashboard.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlue,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Icon(
              Icons.person,
              size: 50,
            ),
            radius: 40,
            backgroundColor: Colors.blue[200], // Circular icon placeholder
          ),
          SizedBox(height: 20), // Spacing between icon and text
          _buildInfoRow('Name:Asmi Ray'),
          _buildInfoRow('Age:55'),
          _buildInfoRow('Birthday:11th September'),
          _buildInfoRow('Height:115'),
          _buildInfoRow('Weight:115'),
          _buildInfoRow('Blood Type:  O -'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.blueGrey[800],
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 150, // Width of the text input container
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter $label',
                    hintStyle: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build buttons
  Widget _buildButton(String text, Color? color, Color? hoverColor) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Change cursor to pointer
      child: GestureDetector(
        onTap: () {
          // Add your onTap functionality here
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2), // Shadow position
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
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
  }

  // New method to build the "Notices" container
  Widget _buildNoticesContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[100], // Light background for the notices container
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notices',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[900],
            ),
          ),
          // Additional notices content can be added here
        ],
      ),
    );
  }
}
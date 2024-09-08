
import 'package:flutter/material.dart';



class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String? _selectedFilter; // Variable to hold the selected filter option
  bool _showInventoryContainer = false; // Variable to control the visibility of the inventory container

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.lightBlueAccent[100],
      appBar: AppBar(
        title:Text('Dashboard',
        style: TextStyle(
          fontSize: 40,
          fontWeight:FontWeight.bold,
          color: Colors.white,
        ),),
        centerTitle: true,
        backgroundColor: Colors.blue[800], // Darker color for the AppBar
      ),


      body:SingleChildScrollView( // Make the page scrollable
          padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 450,
          width: 1000,
          padding: const EdgeInsets.only(top:16,left:16,right:16,bottom:16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(image: AssetImage('assets/dashboard.png'),
            fit:BoxFit.cover,),

          ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterButton(), // "Filter by" button
            SizedBox(height: 20), // Space between buttons
            _buildCheckInventoryButton(), // "Check Inventory" button
            if (_selectedFilter != null) ...[
              SizedBox(height: 20), // Space between button and container
              _buildFilterContainer(), // Opaque container based on selection
            ],
            if (_showInventoryContainer) ...[
              SizedBox(height: 20), // Space between buttons and container
              _buildInventoryContainer(), // Empty container for inventory
            ],
          ],
        ),
      ),
      ),
      
    );
  }

  // Method to build the "Filter by" button
  Widget _buildFilterButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Cursor changes to pointer
      child: GestureDetector(
        onTap: _showFilterOptions, // Shows dropdown menu when tapped
        child: Container(
          width: double.infinity,  // Make button take full width
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0), // Increased padding for a larger button
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2), // Shadow position
              ),
            ],
          ),
          child: Center( // Center-align the text within the button
            child: Text(
              'Filter by',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0, // Increased font size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method to show dropdown menu for filter options
  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: ListView(
            children: [
              ListTile(
                title: Text('1. By Name (Alphabetical)'),
                onTap: () {
                  setState(() {
                    _selectedFilter = 'By Name (Alphabetical)';
                  });
                  Navigator.pop(context); // Close the dropdown after selection
                },
              ),
              ListTile(
                title: Text('2. By Birthdate'),
                onTap: () {
                  setState(() {
                    _selectedFilter = 'By Birthdate';
                  });
                  Navigator.pop(context); // Close the dropdown after selection
                },
              ),
              ListTile(
                title: Text('3. By Age'),
                onTap: () {
                  setState(() {
                    _selectedFilter = 'By Age';
                  });
                  Navigator.pop(context); // Close the dropdown after selection
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to build the "Check Inventory" button
  Widget _buildCheckInventoryButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Cursor changes to pointer
      child: GestureDetector(
        onTap: () {
          setState(() {
            _showInventoryContainer = !_showInventoryContainer; // Toggle the visibility of the inventory container
          });
        },
        child: Container(
          width: double.infinity,  // Make button take full width
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0), // Increased padding for a larger button
          decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2), // Shadow position
              ),
            ],
          ),
          child: Center( // Center-align the text within the button
            child: Text(
              'Check Inventory',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0, // Increased font size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method to build the filter container based on the selected option
  Widget _buildFilterContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50]?.withOpacity(0.7), // Slightly opaque background
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
      child: Text(
        'Filtered by: $_selectedFilter', // Display the selected filter option
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.blueGrey[800],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Method to build the inventory container
  Widget _buildInventoryContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50]?.withOpacity(0.7), // Slightly opaque background
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
      child: Text(
        'Inventory Details: (Currently Empty)', // Placeholder text
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.blueGrey[800],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
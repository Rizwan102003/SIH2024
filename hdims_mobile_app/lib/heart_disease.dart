import 'package:flutter/material.dart';

class HeartDiseaseDetectionPage extends StatelessWidget {
  // Reusable method to create an info row with label and a translucent box
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Vertical gap
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
            width: 150,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5), // Translucent background
              border: Border.all(
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blueGrey[800],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Disease Detection'),
        backgroundColor: Colors.blue[800], // AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: ListView(
          children: [
            _buildInfoRow('Age:', '45'),
            _buildInfoRow('Sex:', '0'),
            _buildInfoRow('cp:', '1'),
            _buildInfoRow('trestbps:', '130'),
            _buildInfoRow('chol:', '204'),
            _buildInfoRow('fbs:', '0'),
            _buildInfoRow('restecg:', '0'),
            _buildInfoRow('thalach:', '172'),
            _buildInfoRow('exang:', '0'),
            _buildInfoRow('oldpeak:', '1.4'),
            _buildInfoRow('slope:', '2'),
            _buildInfoRow('ca:', '0'),
            _buildInfoRow('th:', '2'),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HeartDiseaseDetectionPage(),
    debugShowCheckedModeBanner: false, // Hide the debug banner
  ));
}
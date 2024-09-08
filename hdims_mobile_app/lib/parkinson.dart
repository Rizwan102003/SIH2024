import 'package:flutter/material.dart';

class ParkinsonsDiseaseDetectionPage extends StatelessWidget {
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
            _buildInfoRow('MDVP_Fo:', '197.076'),
            _buildInfoRow('MDVP_Fhi:', '206.896'),
            _buildInfoRow('MDVP_Flo', '192.055'),
            _buildInfoRow('MDVP_Jitter_%', '0.00289'),
            _buildInfoRow('MDVP_Jitter_Abs', '0.00001'),
            _buildInfoRow('MDVP_RAP', '0.00166'),
            _buildInfoRow('MDVP_PPQ:', '0.00168'),
            _buildInfoRow('Jitter_DDP', '0.00498'),
            _buildInfoRow('MDVP_Shimmer', '0.01098'),
            _buildInfoRow('MDVP_Shimmer_dB', '0.09700'),
            _buildInfoRow('Shimmer_APQ3', '0.00563'),
            _buildInfoRow('Shimmer_APQ5', '0.00680'),
            _buildInfoRow('MDVP_APQ', '0.00802'),
            _buildInfoRow('Shimmer_DDA', '0.0168'),
            _buildInfoRow('NHR', '0.00339'),
            _buildInfoRow('HNR', '26.7750'),
            _buildInfoRow('RPDE', '0.422229'),
            _buildInfoRow('DFA', '0.74136'),
            _buildInfoRow('spread1', '-7.3483'),
            _buildInfoRow('spread2', '0.177551'),
            _buildInfoRow('D2', '1.74386'),
            _buildInfoRow('PPE', '0.08556'),

          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ParkinsonsDiseaseDetectionPage(),
    debugShowCheckedModeBanner: false, // Hide the debug banner
  ));
}

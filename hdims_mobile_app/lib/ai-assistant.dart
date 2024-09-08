import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
bool _isNotValidate = false;

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> _messages = []; // List to store messages
  TextEditingController _messageController = TextEditingController(); // Controller for the message input
  ScrollController _scrollController = ScrollController();

  // Controller for scrolling to the bottom

  Future fetchPrediction(String inputData) async {
    final url = Uri.parse('http://10.0.2.2:5000/predict');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'symptoms': inputData}),
      );

      if (response.statusCode == 200) {
        // Successfully got a response from the AI model
        final prediction = jsonDecode(response.body);
        print('Prediction: $prediction');
        // Update the UI with the prediction data
      } else {
        print('Failed to get prediction. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Column(
        children: [
          // Expanded ListView for displaying messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft, // Align messages to the left
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        _messages[index],
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Message input box with a send button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                onPressed: () {
                    fetchPrediction('input data from UI');
                },
                  child: Text('Get Prediction'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ChatPage(),
  ));
}
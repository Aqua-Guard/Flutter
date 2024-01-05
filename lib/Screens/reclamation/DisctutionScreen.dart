import 'package:flutter/material.dart';
import 'package:aquaguard/Models/discution.dart';
import 'package:aquaguard/services/ReclamationWebService.dart'; // Import your ReclamationWebService
import 'package:http/http.dart' as http;

class DiscutionScreen extends StatefulWidget {
  final String token;
  final String reclamationId;

  DiscutionScreen({required this.token, required this.reclamationId});

  @override
  _DiscutionScreenState createState() => _DiscutionScreenState();
}

class _DiscutionScreenState extends State<DiscutionScreen> {
  late List<Discution> discutionList;
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    discutionList = []; // Initialize discutionList
    _messageController = TextEditingController();
    fetchDiscutionData();
  }

  Future<void> fetchDiscutionData() async {
    try {
      List<Discution> discutions = await ReclamationWebService().fetchDisction(widget.token, widget.reclamationId);
      setState(() {
        discutionList = discutions;
      });
    } catch (error) {
      print('Error fetching discution: $error');
    }
  }

  Future<void> sendMessageAdmin(String token, String reclamationId, String message) async {
    final response = await http.post(
      Uri.parse('https://aquaguard-tux1.onrender.com/discution/sendmessageadmin'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'reclamationId': reclamationId,
        'message': message,
      },
    );

    if (response.statusCode == 200) {
      // Handle successful response if needed
    } else {
      throw Exception('Failed to send message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discution Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: discutionList.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(discutionList[index]);
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Discution discution) {
    bool isSentByMe = discution.userRole == 'admin'; // Modify this condition based on your logic

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSentByMe ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                discution.message,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 4),
              Text(
                'Sent at: ${discution.createdAt}',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendMessage();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage() async {
    // Implement the logic to send a message
    String message = _messageController.text;

    try {
      await sendMessageAdmin(
        widget.token,
        widget.reclamationId,
        message,
      );

      // Fetch updated discution data after sending the message
      await fetchDiscutionData();
    } catch (error) {
      print('Error sending message: $error');
    }

    // Clear the input field after sending the message
    _messageController.clear();
  }
}

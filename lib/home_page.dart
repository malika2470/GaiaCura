import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dashboard_screen.dart'; 


class HomePage extends StatefulWidget {
  final String recognizedIngredients;
 const HomePage({super.key, this.recognizedIngredients = ''});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController promptController;
  List<Map<String, String>> chatHistory = []; // To store question-answer pairs

  @override
  void initState() {
    promptController = TextEditingController();
    super.initState();
        if (widget.recognizedIngredients.isNotEmpty) {
      promptController.text = "What are the harms of these ingredients: ${widget.recognizedIngredients}? Are these chemicals known to cause any adverse health effects? and is the pad sustainable?";
      completionFun(); 
    }
  }

  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }

  Future<void> completionFun() async {
    final userQuestion = promptController.text;

    setState(() {
      // Add the user's question to the chat history with type 'user'
      chatHistory.add({'type': 'user', 'content': userQuestion});
      promptController.clear(); // Clear the text field after submission
    });

    try {
      print('Prompt: $userQuestion');

      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.env['token']}',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "system",
              "content":
                  "You are an expert on sustainable period products. You provide advice and answer questions about sustainable menstrual products such as reusable pads, menstrual cups, organic tampons, and more."
            },
            {"role": "user", "content": userQuestion}
          ],
          "max_tokens": 250,
          "temperature": 0.7,
        }),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String answer = data['choices'][0]['message']['content'];

        if (!mounted) return;

        setState(() {
          
          chatHistory.add({'type': 'assistant', 'content': answer});
        });
      } else {
        if (!mounted) return;
        setState(() {
          
          chatHistory.add({'type': 'assistant', 'content': 'Error: ${response.statusCode}'});
        });
      }
    } catch (e) {
      print('Error: $e');
      if (!mounted) return;
      setState(() {
        
        chatHistory.add({'type': 'assistant', 'content': 'Error: $e'});
      });
    }
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DashboardScreen(username: 'User')),
      );
    } else if (index == 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 2) {
      // Scan Camera - do nothing yet
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F0), // Matching the login/signup page background color
      appBar: AppBar(
        title: const Text(
          'Welcome to GaiaChat!',
          style: TextStyle(color: Colors.black), // Match text color with lighter theme
        ),
        backgroundColor: const Color(0xFFD6D6D6), // Slightly darker background for AppBar
        elevation: 0, // Make the AppBar blend with the background
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
         child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chatHistory.length,
                itemBuilder: (context, index) {
                  final chatItem = chatHistory[index];
                  bool isUser = chatItem['type'] == 'user';

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser
                                ? const Color(0xFFA8E6CF)
                                : const Color(0xFFDCEDC1),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(12),
                              topRight: const Radius.circular(12),
                              bottomLeft: isUser
                                  ? const Radius.circular(12)
                                  : const Radius.circular(0),
                              bottomRight: isUser
                                  ? const Radius.circular(0)
                                  : const Radius.circular(12),
                            ),
                          ),
                          child: Text(
                            chatItem['content']!,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            TextFormFieldBldr(
              promptController: promptController,
              btnFun: completionFun,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30), 
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, size: 30), 
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt, size: 30), 
            label: 'Scan',
          ),
        ],
        currentIndex: 1,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFFD6D6D6), 
      ),
    );
  }
}

class TextFormFieldBldr extends StatelessWidget {
  const TextFormFieldBldr({
    super.key,
    required this.promptController,
    required this.btnFun,
  });

  final TextEditingController promptController;
  final Function btnFun;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                cursorColor: Colors.black,
                controller: promptController,
                autofocus: true,
                style: const TextStyle(color: Colors.black, fontSize: 15),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFE0E0E0),
                    ),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE0E0E0),
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFFFFFF),
                  hintText: 'Ask me anything about sustainable period products!',
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                  onPressed: () => btnFun(),
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
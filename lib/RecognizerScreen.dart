import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class Recognizerscreen extends StatefulWidget {
  final File image;
  Recognizerscreen(this.image);

  @override
  State<Recognizerscreen> createState() => _RecognizerscreenState();
}

class _RecognizerscreenState extends State<Recognizerscreen> {
  late TextRecognizer textRecognizer;
  String responseTxt = '';

  @override
  void initState() {
    super.initState();
    textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    doTextRecognition();
  }

  doTextRecognition() async {
    InputImage inputImage = InputImage.fromFile(widget.image);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String text = recognizedText.text;
    print(text); // Print the recognized text

    // Call completionFun with the recognized text
    if (text.isNotEmpty) {
      await completionFun(text);
    }
  }

  Future<void> completionFun(String ingredients) async {
    setState(() => responseTxt = 'loading...');

    try {
      // Create a prompt that asks for toxicity levels of the entered ingredients
      String prompt = """
Evaluate the following ingredients, considering variations in spelling and context:

1. If the ingredients contain any of the following terms or variations of them (e.g., "dioxin", "pesticides", "fragrance", etc.):
   - Dioxins and Furans
   - Pesticide Residues
   - Fragrances
   - Phthalates
   - Volatile Organic Compounds (VOCs)
   - Parabens
   - Chlorine Bleaching Byproducts
   - Formaldehyde Releasing Agents
   - Super Absorbent Polymers (SAPs)
   - Synthetic Fibers (Rayon)
   - Artificial Dyes
   - PFOA (Perfluorooctanoic acid)
   - PFAS (Per- and polyfluoroalkyl substances)
   - BPA (Bisphenol A)

   consider them **Toxic**.

2. If the ingredients contain any of the following terms or variations but none of the toxic ones:
   - Adhesives
   - Polyethylene
   - Polypropylene

   consider them **Moderate**.

3. If none of the above ingredients or their variations are present, consider them **Safe**.

Only provide the classification (Toxic, Moderate, Safe) based on the provided ingredients and the name of ingredient(s) that caused to be toxic or Moderate nothing else: $ingredients
""";

      // Log the prompt to see what is being sent to the API
      print('Prompt: $prompt');

      final response = await http.post(
        Uri.parse(
            'https://api.openai.com/v1/chat/completions'), // Corrected endpoint
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.env['token']}',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo", // Updated model
          "messages": [
            {"role": 'user', "content": prompt}
          ],
          "max_tokens": 250,
          "temperature": 0.7,
        }),
      );

      // Log the response status and body
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (!mounted) return;
        setState(() {
          responseTxt = data['choices'][0]['message']['content'];
        });
      } else {
        if (!mounted) return;
        setState(() => responseTxt = 'Error: ${response.statusCode}');
      }
    } catch (e) {
      // Log the error
      print('Error: $e');
      if (!mounted) return;
      setState(() => responseTxt = 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recognizer'),
      ),
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(widget.image),
            SizedBox(height: 20),
            Text(
              responseTxt,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

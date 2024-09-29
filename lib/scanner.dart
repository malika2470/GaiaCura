import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gaia_cura_/RecognizerScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'dashboard_screen.dart'; // Import the Dashboard screen

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  late ImagePicker imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  Future<void> captureImage() async {
    XFile? xfile = await imagePicker.pickImage(source: ImageSource.camera);
    if (xfile != null) {
      File image = File(xfile.path);
      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
        return Recognizerscreen(image);
      }));
    }
  }

  Future<void> pickImageFromGallery() async {
    XFile? xfile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      File image = File(xfile.path);
      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
        return Recognizerscreen(image);
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF6F0),
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen(username: 'User')), // Replace 'User' with the actual username if needed
            );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 241, 241, 241), 
      ),
      body: Column(
        children: [
          Expanded(
            child: Card(
              color: Colors.black,
              child: Container(
                height: MediaQuery.of(context).size.height - 300,
              ),
            ),
          ),
          Card(
            color: const Color.fromARGB(255, 141, 137, 133),
            child: Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 35,
                          color: Colors.white,
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onTap: () {
                      captureImage();
                    },
                  ),
                  InkWell(
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 35,
                          color: Colors.white,
                        ),
                        Text(
                          'Gallery',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onTap: () {
                      pickImageFromGallery();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

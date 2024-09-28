import 'package:flutter/material.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFCF6F0),
      padding: EdgeInsets.only(top: 50, bottom: 10, left: 5, right: 5),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
            color: const Color.fromARGB(255, 221, 147, 74),
            child: Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.scanner_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                        Text(
                          'Scan',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onTap: () {
                      // code to scan
                    },
                  ),
                  InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.scanner_outlined,
                          size: 25,
                          color: Color(0xFFFCF6F0),
                        ),
                        Text(
                          'Recognize',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onTap: () {
                      // code to scan
                    },
                  ),
                  InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.image_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                        Text(
                          'Enhance',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onTap: () {
                      // code to scan
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(

            color: Colors.black,
            child: Container(
              height: MediaQuery.of(context).size.height-300,
            ),
          ),

          Card(
            color: const Color.fromARGB(255, 206, 221, 74),
            child: Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: const Icon(
                      Icons.rotate_left,
                      size: 35,
                      color: Colors.white,
                    ),
                    onTap: () {
                      // code to rotate camera
                    },
                  ),
                  InkWell(
                    child: const Icon(
                      Icons.camera,
                      size: 50,
                      color: Colors.white,
                    ),
                    onTap: () {
                      // code to capture image
                    },
                  ),
                  InkWell(
                    child: const Icon(
                      Icons.image_outlined,
                      size: 35,
                      color: Colors.white,
                    ),
                    onTap: () {
                      // write code to open gallery
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

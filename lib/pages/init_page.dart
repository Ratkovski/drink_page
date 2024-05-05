import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';


class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _HomePageState();
}

class _HomePageState extends State<InitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(12, 17, 28, 1),
      backgroundColor: Colors.black12,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Padding(
                padding: EdgeInsets.all(25.0),
                child: Image.asset('lib/images/drink_logo.png', height: 280,
                color: Colors.white,),
              ),

              const SizedBox(height:48),

                 //start now button

              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(),
                    ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12)
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: const Center(
                    child: const Text("Open Bar",
                    style: TextStyle(color: Colors.black87,
                    fontWeight: FontWeight.bold,
                      fontSize: 16
                    ) ,),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

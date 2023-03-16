import 'package:flutter/material.dart';
import 'package:mygreen/screen/pot_registration_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.8,
                height: MediaQuery.of(context).size.width*0.25,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  //color: ,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationPage()));
                  },
                  child: const Icon(Icons.add),
                 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


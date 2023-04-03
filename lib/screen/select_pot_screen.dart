import 'package:flutter/material.dart';
import 'package:mygreen/screen/pot_registration_screen.dart';

class SelectPotScreen extends StatefulWidget {
  const SelectPotScreen({super.key});

  @override
  State<SelectPotScreen> createState() => _SelectPotScreenState();
}

class _SelectPotScreenState extends State<SelectPotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("내 화분"),
      ),
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


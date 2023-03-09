import 'package:flutter/material.dart';
import 'package:mygreen/screen/registration.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPage();
  }
}

class MainPage extends StatelessWidget { //Main page
  const MainPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("MyGreen"),
      ),
      body: RegistrationButton(),
      )
    );
  }
}

class RegistrationButton extends StatelessWidget {
  const RegistrationButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      width: 500,
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: IconButton(onPressed: (){
        Navigator.push(context, 
        MaterialPageRoute(builder: (context) => RegistrationPage()));
      }, icon: Icon(Icons.add)),
    );
  }
}


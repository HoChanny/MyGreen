import 'package:flutter/material.dart';
import 'package:mygreen/screen/create_account_screen.dart';
import 'package:mygreen/screen/select_pot_screen.dart';
import 'package:mygreen/utilites/post_request.dart';



//need login validation.

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  final loginFormKey = GlobalKey<FormState>();
  dynamic id;
  dynamic pw;
  dynamic test;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("로그인"),
        ),
        body: Center(
          child: Form(
              key: loginFormKey,
              child: Column(
                children: [
                 
                  TextFormField(
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      prefixIcon: const Icon(Icons.person),
                      hintText: "아이디",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: Colors.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(0.0)),

                      //focus border
                      focusedBorder: UnderlineInputBorder(
                          //<-- SEE HERE
                          borderSide: const BorderSide(
                              width: 3, color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(0.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "아이디를 입력하세요";
                      } else {}
                    },
                    onSaved: (value) {
                      setState(() {
                        id = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      prefixIcon: const Icon(Icons.key),
                      hintText: "비밀번호",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: Colors.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(0.0)),

                      //focus border
                      focusedBorder: UnderlineInputBorder(
                          //<-- SEE HERE
                          borderSide: const BorderSide(
                              width: 3, color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(0.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "비밀번호를 입력하세요";
                      } else {}
                    },
                    onSaved: (value) {
                      setState(() {
                        pw = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final accountState = loginFormKey.currentState;
                        if (accountState!.validate()) {
                          accountState.save();
                          postRequest(id, pw);
                          print(test);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SelectPotScreen()));
                        }
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: const Center(child: Text("로그인")),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CreateAccountPage()));
                      },
                      child: const Text(
                        "회원가입",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              )),
        ));
  }
}

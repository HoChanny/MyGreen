import 'package:flutter/material.dart';
import 'package:mygreen/screen/pot_registration_screen.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mygreen/provider/global_state.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:mygreen/screen/view_my_pot_screen.dart';

import 'package:mygreen/screen/qrscanner_registration.dart';
import 'package:mygreen/utils.dart';

class SelectPotScreen extends StatefulWidget {
  const SelectPotScreen({Key? key}) : super(key: key);

  @override
  _SelectPotScreenState createState() => _SelectPotScreenState();
}

class _SelectPotScreenState extends State<SelectPotScreen> {
  final profileController = Get.put(GlobalState());
  // 예시 데이터
  List<Map<String, dynamic>> potData = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      final url = Uri.parse('https://iotvase.azurewebsites.net/green');
      final response =
          await http.get(url, headers: {'Cookie': profileController.cookie});

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          potData =
              jsonData.map((data) => data as Map<String, dynamic>).toList();
 
        });
      } else {
        print('Failed to fetch data. Error code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error while fetching data: $error');
    }
    if (mounted) {
      setState(() {});
    }
  }

  void refreshData() {
    fetchDataFromServer();
  }

  Color getColor(String rawColor) {
    RegExp regExp = RegExp(r'primary value: (Color\(.+?\))');

    Match? match = regExp.firstMatch(rawColor);
    String extractedColor = match?.group(1) ?? "";
    print(extractedColor);
    Color color = parseColor(extractedColor);
    return color;
  }

  Color parseColor(String colorString) {
    String hexColor = colorString.split('(0x')[1].split(')')[0];
    int value = int.parse(hexColor, radix: 16);
    return Color(value);
  }

  Widget decodeBase64Image(String base64String) {
    Uint8List bytes = base64Decode(base64String);
    return CircleAvatar(
      backgroundImage: MemoryImage(bytes),
      radius: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("내 화분"),
        actions: [
          IconButton(
              iconSize: 40,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QRViewExample(),
                  ),
                ).then((value) {
                  if (value == true) {
                    refreshData();
                  }
                });
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Center(
        child: Expanded(
          child: ListView.builder(
              itemCount: potData.length,
              itemBuilder: (context, i) {
                var data = potData[i];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewMyPotPage(
                          id : data['id'],
                          name: data['plant_name'],
                          color: getColor(data['color']),
                          image: MemoryImage(base64Decode(data['profile'])),
                          temperature: data['temperature'],
                          wateringCycle: data['wateringCycle'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: getColor(data['color']),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              MemoryImage(base64Decode(data['profile'])),
                          radius: 50,
                        ),
                        Column(
                          children: [
                            Text(
                              data['plant_name'],
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('온도 : ${data['temperature']}',
                            style: const TextStyle(
                              fontSize: 15,
                            ),),
                            Text('물 주기 : ${data['wateringCycle']}',
                            style: const TextStyle(
                              fontSize: 15,
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

Future<void> getDataFromServer(String cookie) async {
  final url = Uri.parse('https://iotvase.azurewebsites.net/green');

  // Send GET request to server
  final response = await http.get(url, headers: {'Cookie': cookie});

  if (response.statusCode == 200) {
    // Parse the response
    final data = response.body;
    // Process the data as needed
    print('Received data: $data');
  } else {
    print('Failed to get data. Error code: ${response.statusCode}');
  }
}

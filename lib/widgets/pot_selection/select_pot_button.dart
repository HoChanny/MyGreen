import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../screen/view_my_pot_screen.dart';

class SelectPotButton extends StatelessWidget {
  final Map<String, dynamic> data;

  const SelectPotButton({Key? key, required this.data}) : super(key: key);

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
    var verticalSize = MediaQuery.of(context).size.height;
    var horizontalSize = MediaQuery.of(context).size.width;
    print(data['color']);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewMyPotPage(
                name: data['plant_name'],
                color: getColor(data['color']),
                image: MemoryImage(base64Decode(data['profile'])),
              ),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(verticalSize * 0.03),
          child: Row(
            children: [
              Container(
                width: horizontalSize * 0.33,
                height: horizontalSize * 0.33,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: horizontalSize * 0.02,
                      color: getColor(data['color'])),
                ),
                child: Container(child: decodeBase64Image(data['profile'])
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   image: DecorationImage(
                    //     image: ,
                    //   ),
                    // ),
                    ),
              ),
              SizedBox(width: horizontalSize * 0.1),
              Column(
                children: [
                  Text(data['plant_name']), // 예시로 'N/A'를 사용할 수 있습니다.
                  Text(data['status']),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

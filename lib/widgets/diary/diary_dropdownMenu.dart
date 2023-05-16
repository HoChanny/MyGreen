import 'package:flutter/material.dart';

class MyDropdownMenu extends StatefulWidget {
  final void Function(String) onValueChanged; // 수정: 콜백 함수 추가

  const MyDropdownMenu({Key? key, required this.onValueChanged})
      : super(key: key);

  @override
  State<MyDropdownMenu> createState() => _MyDropdownMenuState();
}
class _MyDropdownMenuState extends State<MyDropdownMenu> {
  String dropdownValue = '먀몸미';
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            
            // Step 2.
            DropdownButton<String>(
              // Step 3.
              value: dropdownValue,
              // Step 4.
              items: <String>['먀몸미','두룩이','설이']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 15),
                  ),
                );
              }).toList(),
              // Step 5.
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  widget.onValueChanged(newValue);
                  
                });
              },
            ),
          ],
        ),
      
    );
  }
}
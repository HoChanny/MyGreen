import 'package:flutter/material.dart';

class SelectPotButton extends StatelessWidget {
  const SelectPotButton({super.key});

  @override
  Widget build(BuildContext context) {
    var verticalSize = MediaQuery.of(context).size.height;
    var horizontalSize = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black)
        )
      ),
      child: GestureDetector(
          onTap: () {
            // Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => ViewMyPotPage(
            //               name: data['plant_name'],
            //               color: getColor(data['color']),
            //               image: MemoryImage(base64Decode(data['profile'])),
            //               temperature: data['temperature'],
            //               wateringCycle: data['wateringCycle'],
            //             ),
            //           ),
            //         );
          },
          child: Container(
            margin: EdgeInsets.all(verticalSize*0.03),
            child: Row(
              children: [
                Container(
                  width: horizontalSize * 0.33,
                  height: horizontalSize * 0.33,
                  
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: horizontalSize * 0.02, color: Colors.black)),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image:  
                      AssetImage('assets/image/MyGreen.png')),
                    ),
                  ),
                ),
                SizedBox(width: horizontalSize*0.1,),
                Column(
                  children: [
                    Text('name'),
                    Text('온도'),
                    Text('습도')
                  ],
                )
              ],
            ),
          )),
    );
  }
}

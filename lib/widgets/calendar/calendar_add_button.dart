import 'package:mygreen/screen/registration_diary.dart';


import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
    final String id;
    final String plant_name;
const AddButton(
      {required this.id,
      required this.plant_name,key});
  _AddButton createState() => _AddButton();
}

class _AddButton extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      tooltip: 'Add',
      onPressed: () {
        // ignore: avoid_print
        print('Add button is clicked');

        Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Registration_Diary( id: widget.id,plant_name : widget.plant_name)));
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../../screen/register_diary/set_pot.dart';

class AddButton extends StatefulWidget {
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
            context, MaterialPageRoute(builder: (context) => SetPotScreen()));
      },
    );
  }
}

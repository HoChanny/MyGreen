import 'package:flutter/material.dart';

class BackButton extends StatefulWidget {
  _BackButton createState() => _BackButton();
}

class _BackButton extends State<BackButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      tooltip: 'Back',
      onPressed: () {
        // ignore: avoid_print
        print('back button is clicked');
        Navigator.pop(context);
      },
    );
  }
}

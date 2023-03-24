import 'package:flutter/material.dart';

class SearchButton extends StatefulWidget {
  _SearchButton createState() => _SearchButton();
}

class _SearchButton extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      tooltip: 'Search',
      onPressed: () {
        // ignore: avoid_print
        print('Search button is clicked');
      },
    );
  }
}

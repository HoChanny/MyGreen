import 'package:flutter/material.dart';

class ListV extends StatefulWidget {

  final List<String> lst;
  _ListV createState() => _ListV();

  ListV({Key? key,
  required this.lst
  }) : super(key: key);
}

class _ListV extends State<ListV> {
  @override
  Widget build(BuildContext context) {
    return    Expanded(
  child: ListView.builder(
    itemCount: widget.lst.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text(widget.lst[index]),
      );
    },
  ),
);

  }
}

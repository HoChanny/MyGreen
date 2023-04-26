// import 'package:flutter/material.dart';

// class CustomTextFormField extends StatefulWidget {
//   final String hintText;
//   final IconData prefixIcon;
//   final Function()? validator;
//   final Function()? onSaved;

//   const CustomTextFormField({
//     Key? key,
//     required this.hintText,
//     required this.prefixIcon,
//     this.validator,
//     this.onSaved,
//   }) : super(key: key);

//   @override
//   _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
// }

// class _CustomTextFormFieldState extends State<CustomTextFormField> {
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         focusColor: Colors.white,
//         prefixIcon: Icon(widget.prefixIcon),
//         hintText: widget.hintText,
//         enabledBorder: UnderlineInputBorder(
//           borderSide: BorderSide(width: 2, color: Colors.black),
//           borderRadius: BorderRadius.circular(0.0),
//         ),

//         //focus border
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(width: 3, color: Colors.greenAccent),
//           borderRadius: BorderRadius.circular(0.0),
//         ),
//       ),
//       validator: widget.validator,
//       onSaved: widget.onSaved,
//     );
//   }
// }

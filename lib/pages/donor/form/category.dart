/*
  Dropdown for Otheration Category
*/

import 'package:flutter/material.dart';

class OtherCategory extends StatefulWidget {
  final Function callback;
  const OtherCategory(this.callback, {super.key});

  @override
  State<OtherCategory> createState() => _OtherCategoryState();
}

class _OtherCategoryState extends State<OtherCategory> {
  // controller
  final _controller = TextEditingController();
  String _category = "";
 
  // dispose
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      // validator: (val) {
      //   // if(val==null) return "Invalid";
      //   // return null;
      // },
      onChanged: (val) {
        setState(() {
          _category = val;
        });
        widget.callback(_category);
      },
    );
  }

}
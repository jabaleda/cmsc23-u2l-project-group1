/*
  Dropdown for Otheration Category
*/

import 'package:flutter/material.dart';

class OtherCategory extends StatefulWidget {
  final bool otherSelected;
  final Function callback;
  const OtherCategory(this.otherSelected, this.callback, {super.key});

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
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 239, 239, 239),
        borderRadius: BorderRadius.circular(10),
        
      ),
      child: TextFormField(
        controller: _controller,
        validator: (val) {
          if(widget.otherSelected == true && (val == null || val.isEmpty)) {
            return "Invalid category!";
          }
          return null;
        },
        onChanged: (val) {
          setState(() {
            _category = val;
          });
          widget.callback(_category);
        },
        decoration: InputDecoration(
          label: Text("Please specify"),
          enabledBorder: InputBorder.none,
        ),
      )
    ) ;
  }

}
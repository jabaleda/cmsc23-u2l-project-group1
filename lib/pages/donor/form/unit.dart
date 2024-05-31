import 'package:flutter/material.dart';

class Unit extends StatefulWidget {
  final Function callback;
  const Unit(this.callback, {super.key});

  @override
  State<Unit> createState() => _UnitState();
}

class _UnitState extends State<Unit> {
  static final List<String> _units = ["kg", "lbs"];

  String _unit = _units.first;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 239, 239, 239),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonFormField(
          value: _unit,
          onChanged: (val) {
            setState(() {
              _unit = val!;
            });
            widget.callback(_unit);
          },
          items: _units.map((String unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: Text(unit)
            );
          }).toList(),
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 35,
          decoration: InputDecoration(
            label: Text("Unit"),
            enabledBorder: InputBorder.none,
          ),
        ),
      ) ,
    );
  }
}
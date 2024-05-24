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
      ),
    );
  }
}
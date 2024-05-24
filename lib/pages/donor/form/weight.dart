import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Weight extends StatefulWidget {
  final Function callback;
  const Weight(this.callback, {super.key});

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  // controller
  final _controller = TextEditingController();

  // dispose
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: _controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))],
        validator: (val) {
          if(val==null || val.isEmpty) return "Invalid weight!";
          return null;
        },
        onChanged: (val) {
          widget.callback(_controller.text);
        },
      ),
    );
  }
}
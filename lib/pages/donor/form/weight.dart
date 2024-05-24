import 'package:flutter/material.dart';

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
        keyboardType: TextInputType.number,
        // validator: (val) {
        //   // validate
        // },
        onChanged: (val) {
          widget.callback(_controller.text);
        },
      ),
    );
  }
}
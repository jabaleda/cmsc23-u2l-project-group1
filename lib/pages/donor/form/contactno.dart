import 'package:flutter/material.dart';

class ContactNo extends StatefulWidget {
  final bool isPickUp;
  final Function callback;
  const ContactNo(this.isPickUp, this.callback, {super.key});

  @override
  State<ContactNo> createState() => _ContactNoState();
}

class _ContactNoState extends State<ContactNo> {
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
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.phone,
      validator: (val) {
        if(widget.isPickUp == true && (val==null || val.isEmpty)){
          return "Invalid contact number!";
        }
        return null;
      },
      onChanged: (val) {
        widget.callback(_controller.text);
      },
    );
  }
}
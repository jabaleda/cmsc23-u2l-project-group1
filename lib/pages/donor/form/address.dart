import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  final bool isPickUp;
  final Function callback;
  const Address(this.isPickUp, this.callback, {super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
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
          if(widget.isPickUp == true && (val==null || val.isEmpty)){
            return "Invalid address!";
          }
          return null;
        },
        onChanged: (val) {
          widget.callback(_controller.text);
        },
        decoration: InputDecoration(
          label: Text("Address"),
          enabledBorder: InputBorder.none,
        ),
      ),
    )
    ;
  }
}
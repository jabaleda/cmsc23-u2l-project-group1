/*
  Donor donate screen
  - Form with fields:
    - checkbox (item category)
    - dropdown? or single select (pickup/drop-off)
    - numfield (item weight) with unit changer (kg/lbs)
    - OPTIONAL: photo
    - date and time (date of pick-up/drop-off)
    - text field (address for pick up only)
    - contact number (for pick up only)
    - generate QR (for drop-off only)
    
*/

import 'package:flutter/material.dart';
import 'package:my_app/pages/donor/form/category.dart';
import 'package:my_app/pages/donor/form/unit.dart';

import 'form/weight.dart';


class DonorDonate extends StatefulWidget {
  const DonorDonate({super.key});

  @override
  State<DonorDonate> createState() => _DonorDonateState();
}

class _DonorDonateState extends State<DonorDonate> {
  static final List<String> _categories = ["Food", "Clothes", "Necessities", "Others"];
  static final List<String> _modes = ["Pick up", "Drop off"];
  
  final _formKey = GlobalKey<FormState>();
  // fields
  String category = "Food";
  bool othersSelected = false; 
  String weight = "";
  String unit = "kg";
  String dateSelected = "";
  // time

  String _mode = _modes.first;

  // controller
  final _datecontroller = TextEditingController();

  // dispose
  @override
  void dispose() {
    _datecontroller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40,
        title: const Text("Donation Form"),
        
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric( horizontal: 35),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                donateToOrg("Org name"),    // pass selected org name to this page
                
                const Divider(),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("Donation Information"),
                ),

                // * Choose Item Category ----------
                DropdownButtonFormField(
                  value: category,
                  onChanged: (val) {
                    setState(() {
                      if(val! == "Others"){
                        othersSelected = true;
                      } else {
                        othersSelected  = false;
                        category = val;
                      }
                    });
                  },
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category)
                    );
                  }).toList(),
                ),

                // * Text field for input of other category
                Offstage(
                  offstage: !othersSelected,
                  child: OtherCategory((String val) => category = val),
                ),
                
                // othersSelected ? Text("Others selected") : Text("Others not selected"),

                // * Input weight and its unit ----------
                Row(
                  children: [
                    Weight( (String val) => weight = val),
                    Unit( (String val) => unit = val),
                  ],
                ),
                
                const Divider(),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("Logistics Information"),
                ),

                // * Pick a Date and Time ----------
                TextFormField(
                  controller: _datecontroller,
                  decoration: InputDecoration(
                    labelText: 'DATE',
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today),

                  ),
                  readOnly: true,
                  validator: (val) {
                    // make sure date is in the future
                    if(val==null) return "Invalid";
                    return null;
                  },
                  onTap: () {
                    _selectDate();
                  },
                ),

                // * Pick mode  ----------
                DropdownButtonFormField(
                  value: _mode,
                  onChanged: (val) {
                    setState(() {
                      _mode = val!;
                    });
                  },
                  items: _modes.map((String mode) {
                    return DropdownMenuItem<String>(
                      value: mode,
                      child: Text(mode)
                    );
                  }).toList(),
                ),

                // offstage isPickUp ? pickup : drop off


                // * Testing
                ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      print(category);
                      print(weight);
                      print(unit);
                      print(dateSelected);
                    }
                  }, 
                  child: Text("Display input")
                )


              ],
            ),
          ),
        )
      )
    );
  }


  Widget donateToOrg(String orgname) => Align(
    alignment: Alignment.topLeft,
    child: Text("Donating to: $orgname"),
  );   

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now() ,
      firstDate: DateTime(2000), 
      lastDate: DateTime(2100)
    );

    if(picked != null){
      setState(() {
        _datecontroller.text = picked.toString().split(" ")[0];
      });
    }

    setState(() {
      dateSelected = _datecontroller.text;
    });

  }


}
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
import 'package:my_app/providers/donation_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';



import '../../models/donation.dart';
import '../../models/organization.dart';
import 'form/address.dart';
import 'form/other_category.dart';
import 'form/contactno.dart';
import 'form/unit.dart';
import 'form/weight.dart';


class DonorDonate extends StatefulWidget {
  final Organization org;
  final String donorEmail;
  const DonorDonate(this.org, this.donorEmail, {super.key});

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

  String mode = _modes.first;
  bool isPickUp = true;
  String address = "";
  String contact = "";

  String qrData = "";
  bool qrGenerated = false;

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
                donateToOrg(widget.org.name),    // pass selected org name to this page
                
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
                  child: OtherCategory(othersSelected, (String val) => category = val),
                ),
                
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
                    if(val==null || val.isEmpty) return "Invalid date";
                    return null;
                  },
                  onTap: () {
                    _selectDate();
                  },
                ),

                // * Pick mode  ----------
                DropdownButtonFormField(
                  value: mode,
                  onChanged: (val) {
                    setState(() {
                      if(val == "Pick up"){
                        setState(() {
                          isPickUp = true;
                          qrGenerated = false;
                        });
                      }else{
                        setState(() {
                          isPickUp = false;
                        });
                      }
                      mode = val!;
                    });
                  },
                  items: _modes.map((String mode) {
                    return DropdownMenuItem<String>(
                      value: mode,
                      child: Text(mode)
                    );
                  }).toList(),
                ),

                // * For Pick up: Address and Contact No ----------
                Offstage(
                  offstage: !isPickUp,
                  child: Address( isPickUp, (String val) => address = val),
                ),

                Offstage(
                  offstage: !isPickUp,
                  child: ContactNo( isPickUp, (String val) => contact = val),
                ),

                // * For Drop off: QR Generation ----------
                Offstage(
                  offstage: isPickUp,
                  child: ElevatedButton(
                    onPressed: () {
                      // * Unique Identifier for QR
                      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
                      setState(() {
                        qrData = widget.org.name + timestamp;
                        qrGenerated = true;
                      });
                    },
                    child: Text("Generate QR Code"),
                  )
                ),

                // * QR Image
                // ? What to do with the generated QR image? Download to device? Store to db?
                Offstage(
                  offstage: !(qrGenerated && !isPickUp),
                  child: qrGenerated ? QrImageView(data: qrData) : Container(),
                ),
                


                // * Testing
                ElevatedButton(
                  onPressed: () {
                    print(_formKey.currentState!.validate());
                    if(_formKey.currentState!.validate()){
                      print(category);
                      print(weight);
                      print(unit);
                      print(dateSelected);
                      print(mode);

                      // Donation Object
                      Donation newDonation = Donation(
                        org: widget.org.email!,
                        orgname: widget.org.name,
                        donor: widget.donorEmail,
                        category: category,
                        pickUp: isPickUp,
                        weight: weight,
                        unit: unit,
                        date: dateSelected,
                        contactNo: contact,
                        status: "Pending",
                        address: address,
                        // TODO: qr code  
                        // TODO: firebase storage url of photo 
                      );

                      // store to db
                      context.read<DonorDonationProvider>().addDonation(newDonation);

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
      initialDate: DateTime.now().add(const Duration(days: 1)) ,
      firstDate: DateTime.now().add(const Duration(days: 1)), 
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

    print(dateSelected);

  }


  Widget showGeneratedQR(String data) {
    return Container(
      child: QrImageView(
        data: data,
        size: 100,
      ),
    );
  }


}
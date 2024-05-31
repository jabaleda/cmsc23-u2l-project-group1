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

  static final List<String> _categories = ["Food", "Clothes", "Cash", "Necessities", "Others"];
  static final List<String> _modes = ["Pick up", "Drop off"];
  
  final _formKey = GlobalKey<FormState>();
  // fields
  String category = "Food";
  bool othersSelected = false; 
  bool cashSelected = false;
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

                donationInfoHeading(),
                

                // * Choose Item Category ----------
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 239, 239, 239),
                    borderRadius: BorderRadius.circular(10),
                    
                  ),
                  child: DropdownButtonFormField(
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 35,
                    decoration: InputDecoration(
                      label: Text("Item Category"),
                      enabledBorder: InputBorder.none,
                    ),
                    value: category,
                    onChanged: (val) {
                      setState(() {
                        if(val! == "Others"){
                          othersSelected = true;
                          
                        } else if (val == "Cash") {
                          othersSelected = false;
                          cashSelected = true;
                        } else {
                          othersSelected  = false;
                          cashSelected = false;
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
                ),
                

                // * Text field for input of other category
                Offstage(
                  offstage: !othersSelected,
                  child: OtherCategory(othersSelected, (String val) => category = val),
                ),
                
                // * Input weight and its unit ----------
                // Hide when cash is selected
                Offstage(
                  offstage: cashSelected,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Weight( (String val) => weight = val),
                      Spacer(),
                      Unit( (String val) => unit = val),
                    ],
                  ),
                ),
                
                const Divider(),

                logisticsInfoHeading(),
                

                // * Pick a Date and Time ----------
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 239, 239, 239),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _datecontroller,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      filled: false,
                      prefixIcon: Icon(Icons.calendar_today),
                      enabledBorder: InputBorder.none
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
                ), 

                // * Pick mode  ----------
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 239, 239, 239),
                    borderRadius: BorderRadius.circular(10),
                    
                  ),
                  child: DropdownButtonFormField(
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
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 35,
                  decoration: InputDecoration(
                    label: Text("Mode of Delivery"),
                    enabledBorder: InputBorder.none,
                  ),
                ),
                )
                ,

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
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                  ),
                  ) 
                ),

                // * QR Image
                // ? What to do with the generated QR image? Download to device? Store to db?
                Offstage(
                  offstage: !(qrGenerated && !isPickUp),
                  child: qrGenerated ? QrImageView(data: qrData) : Container(),
                ),
                


                // * Testing
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ElevatedButton(
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
                    child: Text("Send Donation")
                  ),
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
    child: Container(
      margin:  EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        "Donating to: $orgname",
        style: TextStyle(
          fontSize: 18,
          
        ),
      ),
    )
  ); 

  Widget donationInfoHeading() => Align(
    alignment: Alignment.topLeft,
    child: Container(
      margin:  EdgeInsets.only(top: 5, bottom: 5),
      child: Text("Donation Information"),
    )
  ); 

  Widget logisticsInfoHeading() => Align(
    alignment: Alignment.topLeft,
    child: Container(
      margin:  EdgeInsets.only(top: 5, bottom: 5),
      child: Text("Logistics Information"),
    )
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
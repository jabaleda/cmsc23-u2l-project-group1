import 'package:flutter/material.dart';
import 'package:my_app/providers/donation_provider.dart';
import 'package:provider/provider.dart';

import '../../models/donation.dart';

class DDonationDetail extends StatefulWidget {
  final Donation donation;
  const DDonationDetail(this.donation, {super.key});

  @override
  State<DDonationDetail> createState() => _DonationDetailState();
}

class _DonationDetailState extends State<DDonationDetail> {
  late bool cancellableFlag;

  @override
  void initState() {
    super.initState();
    if(widget.donation.status == "Pending"){
      cancellableFlag = true;
    } else {
      cancellableFlag = false;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donation details"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.donation.category),
            Text("${widget.donation.weight} ${widget.donation.unit}"),
            Text(widget.donation.pickUp.toString()),
            Text(widget.donation.status),

            // DONE: Button for cancelling
            // - check if donation status is pending
            // - if pending -> render cancel button
            // else do not render
            // TODO: add action confirmation modal, then rebuild whole page
            Offstage(
              offstage: !cancellableFlag,
              child: ElevatedButton(
                onPressed: () {
                  //
                  print("cancel me");
                  context.read<DonorDonationProvider>().editDonStat(widget.donation.id!, "Canceled");

                  setState(() {
                    cancellableFlag = false;
                  });

                  // TODO: Make whole widget rebuild on cancellation

                },
                child: Text("Cancel Donation"),
              ),
            )
            

          ],
        ),
      )
    );
  }
}
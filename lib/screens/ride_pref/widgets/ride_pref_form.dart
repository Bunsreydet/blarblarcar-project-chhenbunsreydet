import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;
  final RidePref? onSearch;

  const RidePrefForm({super.key, this.initRidePref, this.onSearch});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  //declare validation for handle all event
  get isValid => null;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    // My note: initState() is a lifecycle method called
    // exactly once when a StatefulWidget is inserted into the widget tree.
    // It is used to initialize state variables, set up animations, controllers,
    // Listeners before the widget is built and rendered. It run immediately after
    // the State object is created and must include super.initState()
    // departure = widget.initRidePref?.departure;
    // departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    // arrival = widget.initRidePref?.departure;
    // requestedSeats = widget.initRidePref?.requestedSeats ?? 1;

    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      departureDate = widget.initRidePref!.departureDate;
      arrival = widget.initRidePref!.arrival;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } 
    //update else
    else {
      departure = null;
      departureDate = DateTime.now();
      arrival = null;
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // This void is my mistake
  // void _handleSearch() {
  //   if (isValid != null) {
  //     return;
  //   }

  //   final prefride = RidePref(
  //     departure = widget.,
  //     departureDate: departureDate,
  //     arrival: arrival,
  //     requestedSeats: requestedSeats,
  //   );
  //   widget.onSearch?.call(prefride);
  // }

  //My correction from my teacher

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [ 
 
        ]);
  }
}

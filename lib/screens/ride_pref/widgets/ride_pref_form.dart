import 'package:blarblarcar/utils/animations_util.dart';
import 'package:blarblarcar/widgets/actions/bla_button.dart';
import 'package:blarblarcar/widgets/display/bla_divider.dart';
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

  // void _handleSelectDeparture() {}
  // void _handleSelectArrival() {}
  // void _handleSelectDate() {}
  // void _handleSelectSeats() {}
  // void _handleSwitchLocations() {}
  // void _handleSearch() {
  //   if (!isValid) return;
  //   final ridePref = RidePref(
  //     departure: departure!,
  //     departureDate: departureDate!,
  //     arrival: arrival!,
  //     requestedSeats: requestedSeats,
  //   );
  //   widget.onSearch(ridePref);
  // }

  void onDeparturePressed() async {
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(
        BlaLocationPicker(initLocation: departure),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onArrivalPressed() async {}

  void onSubmit() {}

  void onSwappingLocationPressed() {
    setState(() {
      if (departure != null && arrival != null) {
        Location temp = departureDate!;
        departure = Location.copy(arrival!);
        arrival = Location.copy(temp);
      }
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  String get departureLabel =>
      departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";
  bool get showDeparturePlaceHolder => departure == null;
  bool get showArrivalPlaceHolder => arrival == null;

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get switchVisible => arrival != null && departure != null;
  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [ 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacing.m),
          child: Column(
            children: [
              RidePrefInput(
                isPlaceHolder: showDeparturePlaceHolder,
                title: departureLabel,
                leftIcon: Icons.location_on,
                onPressed: onDeparturePressed,
                rightIcon: switchVisible ? Icons.swap_vert : null,
                onRightIconPressed: switchVisible ? onSwappingLocationPressed : null,
              ),
              const BlaDivider(),

              RidePrefInput(
                isPlaceHolder: showArrivalPlaceHolder,
                title: arrivalLabel,
                leftIcon: Icons.location_on,
                onPressed: onArrivalPressed,
              ),
              const BlaDivider(),

              RidePrefInput(
                isPlaceHolder: showArrivalPlaceHolder,
                title: arrivalLabel,
                leftIcon: Icons.person_2_outlined,
                onPressed: () => {},
              ),
            ],
          ),
        ),
        BlaButton(
          text: 'Search',
          onPressed: onSubmit 
          ),
      ]);
  }
}

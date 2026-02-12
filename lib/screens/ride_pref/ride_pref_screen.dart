import 'package:flutter/material.dart';

import '../../model/ride_pref/ride_pref.dart';
import '../../service/ride_prefs_service.dart';
import '../../theme/theme.dart';

import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///
class RidePrefScreen extends StatefulWidget {
  const RidePrefScreen({super.key});

  @override
  State<RidePrefScreen> createState() => _RidePrefScreenState();
}

class _RidePrefScreenState extends State<RidePrefScreen> {
  const int transitionSpeed = 500; //declare static transition
  Route createBottomToTopRoute<T>(Widget screen) {
    const begin = Offset(0.0, 1.0);
    const end = Offset(0.0, 0.0);
    return _createAnimateRoute(screen, begin, end);
  }

  Route _createAnimateRoute<T>(Widget screen, Offset begin, Offset end) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: transitionSpeed),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void onRidePrefSelected(RidePref ridePref) {
    // 1 - Navigate to the rides screen (with a buttom to top animation)
  }

  //void onSea

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1 - Background  Image
        _buildBackground(),

        // 3 - To input the locations, date and seats and press on Search
        //_buildinput(),
        // 2 - Foreground content
        _buildForeground(),
      ],
    );
  }
}

Widget _buildBackground() {
  return SizedBox(
    width: double.infinity,
    height: 340,
    child: Image.asset(
      blablaHomeImagePath,
      fit: BoxFit.cover, // Adjust image fit to cover the container
    ),
  );
}

Widget _buildForeground() {
  return Column(
    children: [
      SizedBox(height: 16),
      Text(
        "Your pick of rides at low price",
        style: BlaTextStyles.heading.copyWith(color: Colors.white),
      ),
      SizedBox(height: 100),
      Container(
        padding: EdgeInsets.fromLTRB(0, 200, 0, 100),
        margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
        decoration: BoxDecoration(
          color: Colors.white, // White background
          borderRadius: BorderRadius.circular(16), // Rounded corners
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 2.1 Display the Form to input the ride preferences
            RidePrefForm(initRidePref: RidePrefService.currentRidePref),
            SizedBox(height: BlaSpacings.m),

            // 2.2 Optionally display a list of past preferences
            SizedBox(
              height: 200, // Set a fixed height
              child: ListView.builder(
                shrinkWrap: true, // Fix ListView height issue
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: RidePrefService.ridePrefsHistory.length,
                itemBuilder: (ctx, index) => RidePrefHistoryTile(
                  ridePref: RidePrefService.ridePrefsHistory[index],
                  onTap: () {
                    onRidePrefSelected(RidePrefService.ridePrefsHistory[index]);
                  },
                ),
              ),
            ),
            // 2.3 Search button
            // SizedBox(
            //   height: 50,
            //   child: Container(
            //     width: 100,
            //     child: b,
            //   ),
            // )
          ],
        ),
      ),
    ],
  );
}

void onRidePrefSelected(RidePref ridePrefsHistory) {}

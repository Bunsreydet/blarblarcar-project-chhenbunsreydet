import 'package:blarblarcar/model/ride/locations.dart';
import 'package:blarblarcar/service/locations_service.dart';
import 'package:blarblarcar/theme/theme.dart';
import 'package:flutter/material.dart';

class BlaLocationPicker extends StatefulWidget {
  final Location? initLocation;
  const BlaLocationPicker({super.key, required this.initLocation});

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  String currentSearchText = "";

  void onTap(Location location) {
    Navigator.pop<Location>(context, location);
  }

  void onBackTap() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    if (widget.initLocation != null) {
      setState(() {
        currentSearchText = widget.initLocation!.name;
      });
    }
  }

  void onSearchChnaged(String search) {
    setState(() {
      currentSearchText = search;
    });
  }

  List<Location> get filteredLocation {
    if (currentSearchText.length < 2) {
      return [];
    }
    return LocationsService.availableLocations
        .where(
          (location) => location.name.toUpperCase().contains(
            currentSearchText.toUpperCase(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            LocationSearchBar(
              initSearch: currentSearchText,
              onBackTap: onBackTap,
              onSearchChanged: onSearchChanged,
            ),

            SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: filteredLocation.length,
                itemBuilder: (context, index) => LocationTile(
                  location: filteredLocation[index],
                  onTap: onTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationSearchBar extends StatefulWidget {
  final String initSearch;
  final VoidCallback onBackTap;
  final ValueChanged<String> onSearchChanged;
  const LocationSearchBar({
    super.key,
    required this.onBackTap,
    required this.onSearchChanged,
    required this.initSearch,
  });

  @override
  State<LocationSearchBar> createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void onClearTap() {
    _searchController.clear();
  }

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.initSearch;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool get searchIsNotEmpty => _searchController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BlaColors.greyLight,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onBackTap,
            icon: Icon(
              Icons.arrow_back_ios,
              color: BlaColors.iconLight,
              size: 16,
            ),
          ),

          Expanded(
            child: TextField(
              focusNode: _focusNode,
              controller: _searchController,
              onChanged: widget.onSearchChanged,
              style: TextStyle(color: BlaColors.textLight),
              decoration: InputDecoration(
                hintText: "Any city, street...",
                border: InputBorder.none,
                filled: false,
              ),
            ),
          ),

          searchIsNotEmpty
              ? IconButton(
                  onPressed: onClearTap,
                  icon: Icon(Icons.close, color: BlaColors.iconLight, size: 16),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class LocationTile extends StatelessWidget {
  final Location location;
  final ValueChanged<Location> onTap;
  String get title => location.name;
  String get subTitle => location.country.name;
  const LocationTile({super.key, required this.location,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => onTap(location),
          leading: Icon(Icons.history, color: BlaColors.textLight,),
        )
        title: Text(title, style: BlaTextStyles.body),
          subtitle: Text(
            subTitle,
            style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
          ),

          trailing: Icon(
            Icons.arrow_forward_ios,
            color: BlaColors.iconLight,
            size: 16,
          ),
      ],
    );
  }
}

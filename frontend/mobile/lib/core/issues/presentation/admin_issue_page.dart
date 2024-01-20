import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swaraksha/core/issues/application/issues_manager.dart';
import 'package:swaraksha/core/issues/presentation/issue_detail_page.dart';
import 'package:swaraksha/globals.dart';
import 'package:swaraksha/models/issue.dart';

class AdminIssuePage extends StatefulWidget {
  final LatLng? location;
  const AdminIssuePage({
    super.key,
    this.location,
  });

  @override
  State<AdminIssuePage> createState() => _AdminIssuePageState();
}

class _AdminIssuePageState extends State<AdminIssuePage> {
  late BitmapDescriptor markerIcon;
  CameraPosition currentPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.5,
  );
  GoogleMapController? controller;
  Set<Marker> markers = {};

  List<Issue> issues = [];
  final startAddressController = TextEditingController();

  _determinePosition() async {
    if (locationData.currentLocation == null) {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        bool res = await Geolocator.openLocationSettings();
        if (!res) return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      var pos = await Geolocator.getCurrentPosition();
      var currentLatLng = LatLng(pos.latitude, pos.longitude);
      locationData.currentLocation = currentLatLng;
    }

// Add marker only if the location passed is null
    if (widget.location != null) return;

    currentPosition = CameraPosition(
      target: locationData.currentLocation!,
      zoom: 15.0,
    );
    if (controller != null) {
      // addMarker(currentPosition.target);
      controller!.moveCamera(
        CameraUpdate.newCameraPosition(currentPosition),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    getMarkers();
    if (widget.location != null) {
      currentPosition = CameraPosition(
        target: widget.location!,
        zoom: 15.0,
      );
      addMarker(widget.location!, () {});
      setState(() {});
    }
    super.initState();
  }

  void getMarkers() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(12, 12)),
      'assets/marker.png',
    );

    final issues = await IssuesManager().getIssuesByDepartment();

    for (var item in issues) {
      final latLng = LatLng(
        item.location.coordinates[0],
        item.location.coordinates[1],
      );
      addMarker(
        latLng,
        () => navigateTo(
          IssueDetailPage(issue: item),
          context,
        ),
      );
    }

    setState(() {});
  }

  void addMarker(LatLng loc, Function onClick) async {
    markers.add(
      Marker(
        icon: markerIcon,
        markerId: MarkerId(DateTime.now().microsecondsSinceEpoch.toString()),
        position: loc,
        onTap: () {
          onClick();
        },
      ),
    );
  }

  _getAddress(String address) async {
    List<Location> data = await locationFromAddress(address);
    if (data.isEmpty) return;

    addMarker(LatLng(data[0].latitude, data[0].longitude), () {});
    currentPosition = CameraPosition(
      target: LatLng(data[0].latitude, data[0].longitude),
      zoom: 15.0,
    );
    controller!.moveCamera(
      CameraUpdate.newCameraPosition(currentPosition),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Issues"),
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        scrollGesturesEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: currentPosition,
        compassEnabled: true,
        myLocationButtonEnabled: true,
        markers: markers,
        onTap: (e) async {
          print(e.toJson().toString());
          // markers.clear();

          // markers.add(Marker(
          //   markerId:
          //       MarkerId(DateTime.now().microsecondsSinceEpoch.toString()),
          //   position: e,
          // ));
          // setState(() {});
        },
        onMapCreated: (GoogleMapController? c) {
          if (c != null) {
            controller = c;
            _determinePosition();
          }
        },
      ),
    );
  }
}

class LocationData {
  LatLng? currentLocation;
  LatLng? pickupLocation;
  LatLng? destinationLocation;
}

LocationData locationData = LocationData();

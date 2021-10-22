import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/stores/profile_store.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _gmController = Completer();
  CameraPosition? _initialPosition;
  ProfileStore _profileStore = locator<ProfileStore>();
  bool _loadingPosition = true;
  // ProfileController _meController = locator<ProfileController>();
  // MeProfileVM _meProfile = MeProfileVM();

  @override
  void initState() {
    super.initState();

    _setUserPosition();

    new Timer.periodic(new Duration(seconds: 15), (timer) {
      _setUserPosition();
    });
  }

  void _setUserPosition() async {
    Position position = await _determinePosition();

    _profileStore.setLocalization(position.latitude, position.longitude);

    setState(() {
      _initialPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.4746,
      );
      _loadingPosition = false;
    });
  }

  // void _updateUserLocalization() {
  //   _meController.updateProfile(_meProfile);
  // }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    // var locationOptions =
    //     LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    // StreamSubscription<Position> positionStream =
    //     Geolocator.getPositionStream().listen((Position position) {
    //   print(position == null
    //       ? 'Unknown'
    //       : position.latitude.toString() +
    //           ', ' +
    //           position.longitude.toString());
    // });

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      timeLimit: Duration(seconds: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadingPosition
          ? null
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _initialPosition!,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              rotateGesturesEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _gmController.complete(controller);
              },
            ),
    );
  }
}

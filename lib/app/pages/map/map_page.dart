import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:party_mobile/app/controllers/profile_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/view_models/me_profile_vm.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _gmController = Completer();
  CameraPosition? _initialPosition;
  ProfileController _meController = locator<ProfileController>();
  MeProfileVM _meProfile = MeProfileVM();
  bool _loadingPosition = true;

  @override
  void initState() {
    super.initState();
    _setUserPosition();
  }

  void _setUserPosition() async {
    Position position = await _determinePosition();
    setState(() {
      _initialPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.4746,
      );
      _loadingPosition = false;
      _meProfile.latitude = position.latitude;
      _meProfile.longitude = position.longitude;
      _updateUserLocalization();
    });
  }

  void _updateUserLocalization() {
    _meController.updateProfile(_meProfile);
  }

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

  Widget eventStatus(String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget eventDescription(IconData iconName, String information) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(iconName, size: 16),
          Container(width: 5),
          Text(
            information,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadingPosition
          ? null
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _initialPosition!,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  rotateGesturesEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    _gmController.complete(controller);
                  },
                ),
                Positioned(
                    left: 10,
                    bottom: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              constraints: BoxConstraints(
                                maxHeight: 130.0,
                              ),
                              child: Image.network(
                                'https://pix10.agoda.net/hotelImages/301716/-1/fe9724d8fb4da3dd4590353bd771a276.jpg?s=1024x768',
                                height: 100,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 15, bottom: 5),
                                  child: eventStatus('10m Distância'),
                                ),
                                Text(
                                  "FESTA NA PRAIA",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                eventDescription(Icons.map, "Sport Mar"),
                                eventDescription(Icons.timer, "Qua, 4 maio 10"),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 4),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          'https://pix10.agoda.net/hotelImages/301716/-1/fe9724d8fb4da3dd4590353bd771a276.jpg?s=1024x768',
                                          width: 18,
                                          height: 18,
                                          // height: double.infinity,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Por Arthur Novais",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
    );
  }
}

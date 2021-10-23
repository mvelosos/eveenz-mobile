import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  List<dynamic> events = [
    // {
    //   'eventAdmin': 'Vinicius',
    //   'eventDistance': '10m de Distância',
    //   'adminImage':
    //       'https://uploads.metropoles.com/wp-content/uploads/2019/12/29110853/os-cantores-sertanejos-matheus-e-kauan-respectivamente-1577615861427_v2_1920x1230.jpg',
    //   'name': 'Matheus e Kauan Forrock',
    //   'place': 'Sport Marina',
    //   'date': 'Qua, 2 abril - 19:00',
    //   'image':
    //       'https://uploads.metropoles.com/wp-content/uploads/2019/12/29110853/os-cantores-sertanejos-matheus-e-kauan-respectivamente-1577615861427_v2_1920x1230.jpg'
    // },
    // {
    //   'eventAdmin': 'Matheus',
    //   'eventDistance': '50m de Distância',
    //   'adminImage':
    //       'https://i2.wp.com/cadernopop.com.br/wp-content/uploads/2020/03/Jorge-Mateus.jpg?fit=900%2C900&ssl=1',
    //   'name': 'Jorge e Mateus',
    //   'place': 'Sport Marina Clube',
    //   'date': 'Sex, 17 abril - 21:00H',
    //   'image':
    //       'https://i2.wp.com/cadernopop.com.br/wp-content/uploads/2020/03/Jorge-Mateus.jpg?fit=900%2C900&ssl=1'
    // },
    // {
    //   'eventAdmin': 'Moises',
    //   'eventDistance': '30m de Distância',
    //   'adminImage':
    //       'https://uploads.metropoles.com/wp-content/uploads/2019/12/29110853/os-cantores-sertanejos-matheus-e-kauan-respectivamente-1577615861427_v2_1920x1230.jpg',
    //   'name': 'Matheus e Kauan Forrock',
    //   'place': 'Sport Marina',
    //   'date': 'Qua, 2 abril - 19:00H',
    //   'image':
    //       'https://uploads.metropoles.com/wp-content/uploads/2019/12/29110853/os-cantores-sertanejos-matheus-e-kauan-respectivamente-1577615861427_v2_1920x1230.jpg'
    // }
  ];

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
          style: GoogleFonts.poppins(
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
            style: GoogleFonts.poppins(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget card(Map<String, dynamic> event) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                event['image'],
                height: 100,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 5),
                    child: eventStatus(event['eventDistance']),
                  ),
                  Text(
                    event['name'],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  eventDescription(Icons.map, event['place']),
                  eventDescription(Icons.timer, event['date']),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            event['adminImage'],
                            width: 18,
                            height: 18,
                            // height: double.infinity,
                          ),
                        ),
                      ),
                      Text(
                        event['eventAdmin'],
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
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
                events.length > 0
                    ? Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.75,
                        ),
                        constraints: BoxConstraints(
                          maxHeight: 130,
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: card(events[index]),
                            );
                          },
                        ),
                      )
                    : Container()
              ],
            ),
    );
  }
}

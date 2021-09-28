import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/controllers/events_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/event_model.dart';
import 'package:party_mobile/app/pages/account/account_page.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/shared/utils/commons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventPageArguments {
  final String uuid;

  EventPageArguments({required this.uuid});
}

class EventPage extends StatefulWidget {
  final EventPageArguments args;

  EventPage({required this.args});

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  EventsController _eventsController = locator<EventsController>();
  EventModel _event = EventModel();
  CameraPosition? _eventCameraPosition;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    super.initState();
    _getEvent();
  }

  Future<void> _getEvent() async {
    var result = await _eventsController.getEvent(widget.args.uuid);
    if (result.isRight()) {
      setState(() {
        _event = result.getOrElse(() => {} as EventModel);
      });
      _setEventCameraPosition();
      _setEventMapMarker();
      // _pageScrollController.
    }
  }

  List<Widget> _eventCategories() {
    List<Widget> _categoryChips = [];

    _event.categories?.forEach((category) {
      _categoryChips.add(Chip(label: Text(category.titleizedName)));
    });

    return _categoryChips;
  }

  void _setEventCameraPosition() {
    _eventCameraPosition = CameraPosition(
      target: LatLng(
          _event.localization!.latitude!, _event.localization!.longitude!),
      zoom: 17,
    );
  }

  void _setEventMapMarker() {
    final MarkerId markerId = MarkerId(_event.uuid!);

    Marker _eventMarker = Marker(
      markerId: markerId,
      position: LatLng(
        _event.localization!.latitude!,
        _event.localization!.longitude!,
      ),
    );

    setState(() {
      markers[markerId] = _eventMarker;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () async {
            await _getEvent();
          },
          child: SingleChildScrollView(
            primary: false,
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 262,
                        enableInfiniteScroll: false,
                        viewportFraction: 1,
                      ),
                      items: _event.images.map((image) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              child: image != null
                                  ? Image.network(
                                      image,
                                      fit: BoxFit.cover,
                                      color: Colors.black.withOpacity(.1),
                                      colorBlendMode: BlendMode.hardLight,
                                    )
                                  : SizedBox.shrink(),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Positioned(
                      left: 10,
                      top: 50,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    top: _size.width * .06,
                    left: _size.width * .06,
                    right: _size.width * .06,
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _event.name ?? '',
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.inter(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkPurple,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text(
                              _event.startDate != null
                                  ? Commons.formatDate(_event.startDate!)
                                  : '',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text('•'),
                            SizedBox(width: 10),
                            Icon(
                              Icons.watch_later_outlined,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text(
                              _event.startDate != null
                                  ? Commons.formatTime(_event.startTime!)
                                  : '',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    foregroundImage: NetworkImage(
                                        'https://conexao.segurosunimed.com.br/wp-content/uploads/2018/11/mes-homem-1.jpg'),
                                  ),
                                  Positioned(
                                    left: 20,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.green,
                                      foregroundImage: NetworkImage(
                                          'https://blog.certisign.com.br/wp-content/uploads/2018/03/imposto-de-renda-como-separar-a-pessoa-fisica-da-pessoa-juridica.jpg'),
                                    ),
                                  ),
                                  Positioned(
                                    left: 45,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.yellow,
                                      foregroundImage: NetworkImage(
                                          'https://static1.tudosobremake.com.br/articles/9/21/15/9/@/232849-o-delineador-tambem-deixa-qualquer-mulhe-article_media_new_3_2-4.jpg'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: RichText(
                                  overflow: TextOverflow.clip,
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: AppColors.gray1,
                                      // fontSize: size.height * .015,
                                      // fontWeight: FontWeight.w700,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Mais de 200 pessoas',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' confirmaram a presença nesse evento',
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Sobre',
                        style: GoogleFonts.inter(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkPurple,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        _event.description ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: AppColors.gray1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Wrap(
                          spacing: 5,
                          children: _eventCategories(),
                        ),
                      ),
                      SizedBox(height: 25),
                      Text(
                        'O anfitrião',
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkPurple,
                        ),
                      ),
                      SizedBox(height: 12),
                      RawMaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            RouteNames.showAccount,
                            arguments: AccountPageArguments(
                                username: _event.hostUsername!),
                          );
                        },
                        child: Row(
                          children: [
                            _event.hostAvatar != null &&
                                    _event.hostAvatar!.isNotEmpty
                                ? CircleAvatar(
                                    radius: 30,
                                    foregroundImage:
                                        NetworkImage(_event.hostAvatar!),
                                  )
                                : CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xffd3d5db),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _event.hostName ?? '',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.darkPurple,
                                    ),
                                  ),
                                  Text(
                                    _event.hostUsername != null &&
                                            _event.hostUsername!.isNotEmpty
                                        ? '@${_event.hostUsername}'
                                        : '',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.darkPurple,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Divider(),
                      SizedBox(height: 15),
                      Text(
                        'Local',
                        style: GoogleFonts.inter(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkPurple,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        '250m de distância',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkPurple,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        _event.address != null
                            ? '${_event.address!.street!}, ${_event.address!.number!}${_event.address!.complement != null ? ', ${_event.address!.complement}' : ''}'
                            : '',
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.darkPurple,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        _event.address != null
                            ? '${_event.address!.city!} - ${_event.address!.state!}'
                            : '',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.darkPurple,
                        ),
                      ),
                      _eventCameraPosition != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 5),
                              child: Container(
                                height: 230,
                                child: GoogleMap(
                                  initialCameraPosition: _eventCameraPosition!,
                                  mapType: MapType.normal,
                                  myLocationButtonEnabled: false,
                                  markers: Set<Marker>.of(markers.values),
                                  gestureRecognizers: Set()
                                    ..add(
                                      Factory<PanGestureRecognizer>(
                                        () => PanGestureRecognizer(),
                                      ),
                                    ),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: RawMaterialButton(
                          onPressed: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                                vertical: _size.height * .007),
                            padding: EdgeInsets.symmetric(
                                vertical: _size.height * .024),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: Offset(2, 4),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                              color: AppColors.orange,
                            ),
                            child: Text(
                              'CONFIRMAR PRESENÇA',
                              style: GoogleFonts.roboto(
                                fontSize: _size.height * .015,
                                color: Colors.white,
                                letterSpacing: 4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

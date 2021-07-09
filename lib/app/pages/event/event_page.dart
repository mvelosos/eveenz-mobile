import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/events_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/event_model.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';

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

  @override
  void initState() {
    super.initState();
    _getEvent();
  }

  Future<void> _getEvent() async {
    var result = await _eventsController.getEvent(widget.args.uuid);
    if (result.isRight()) {
      _event = result.getOrElse(() => {} as EventModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: AppColors.orange),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _getEvent();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                ),
                items: _event.images?.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Colors.amber),
                        child: Image.network(image),
                      );
                    },
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

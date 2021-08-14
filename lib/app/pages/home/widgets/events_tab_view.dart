import 'package:flutter/material.dart';
import 'package:party_mobile/app/pages/home/widgets/square_event_card_list.dart';
import 'package:party_mobile/app/pages/home/widgets/wide_event_card_list.dart';

class EventsTabView extends StatefulWidget {
  const EventsTabView({Key? key}) : super(key: key);

  @override
  _EventsTabViewState createState() => _EventsTabViewState();
}

class _EventsTabViewState extends State<EventsTabView> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () async {},
      child: Container(
        padding: EdgeInsets.only(
          left: _size.width * .06,
          right: _size.width * .06,
        ),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              WideEventCardList(label: 'EM ALTA'),
              SquareEventCardList(label: 'PERTO DE MIM'),
              SquareEventCardList(label: '#TO CONFIRMADO'),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}

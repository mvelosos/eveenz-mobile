import 'dart:async';

import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/home_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/pages/home/widgets/square_event_card_list.dart';
import 'package:party_mobile/app/pages/home/widgets/wide_event_card_list.dart';
import 'package:party_mobile/app/stores/profile_store.dart';

class EventsTabView extends StatefulWidget {
  const EventsTabView({Key? key}) : super(key: key);

  @override
  _EventsTabViewState createState() => _EventsTabViewState();
}

class _EventsTabViewState extends State<EventsTabView> {
  HomeController _homeController = locator<HomeController>();
  ProfileStore _profileStore = locator<ProfileStore>();
  List? _cardsList;

  @override
  void initState() {
    super.initState();
    _setDefaultCards();
    _initCards();
  }

  _setDefaultCards() {
    setState(() {
      _cardsList = [
        {'cardType': 'wide', 'title': '', 'data': []},
        {'cardType': 'square', 'title': '', 'data': []},
        {'cardType': 'square', 'title': '', 'data': []},
      ];
    });
  }

  Future<void> _initCards() async {
    new Timer(Duration(seconds: 1), () async {
      if (_profileStore.latitude.value != .0) {
        var result = await _homeController.getCards(
          _profileStore.latitude.value,
          _profileStore.longitude.value,
        );
        setState(() {
          _cardsList = result.getOrElse(() => null);
        });
      }
    });
  }

  Future<void> _getCards() async {
    var result = await _homeController.getCards(
      _profileStore.latitude.value,
      _profileStore.longitude.value,
    );
    setState(() {
      _cardsList = result.getOrElse(() => null);
    });
  }

  List<Widget> _buildCards() {
    List<Widget> cardsColumnChildren = [];

    _cardsList?.forEach((card) {
      switch (card['cardType']) {
        case 'wide':
          cardsColumnChildren.add(WideEventCardList(card: card));
          break;
        case 'square':
          cardsColumnChildren.add(SquareEventCardList(card: card));
          break;
      }
    });

    cardsColumnChildren.add(SizedBox(height: 20));

    return cardsColumnChildren;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: () async {
        await _getCards();
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: _buildCards(),
          ),
        ),
      ),
    );
  }
}

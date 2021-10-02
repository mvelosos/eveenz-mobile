import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/pages/event/event_page.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class EventListTile extends StatelessWidget {
  final _item;

  EventListTile(this._item);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          RouteNames.showEvent,
          arguments: EventPageArguments(uuid: _item.uuid),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 25,
                spreadRadius: 5,
                offset: Offset(0, 20),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 98,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  child: Image.network(
                    _item.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _item.name,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkPurple,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.mapMarkerAlt,
                            size: 15,
                            color: Colors.grey[400],
                          ),
                          SizedBox(width: 5),
                          Text('Sport Marina'),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.calendarAlt,
                            size: 15,
                            color: Colors.grey[400],
                          ),
                          SizedBox(width: 5),
                          Text('Qua, 2 abril - 19:00H'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

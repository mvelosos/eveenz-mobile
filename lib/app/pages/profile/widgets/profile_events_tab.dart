import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/pages/profile/widgets/my_event_list_item.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';

class ProfileEventsTab extends StatelessWidget {
  List<dynamic> events = [
    {
      'name': 'Matheus e Kauan Forrock',
      'place': 'Sport Marina',
      'date': 'Qua, 2 abril - 19:00',
      'image':
          'https://uploads.metropoles.com/wp-content/uploads/2019/12/29110853/os-cantores-sertanejos-matheus-e-kauan-respectivamente-1577615861427_v2_1920x1230.jpg'
    },
    {
      'name': 'Jorge e Mateus',
      'place': 'Sport Marina Clube',
      'date': 'Sex, 17 abril - 21:00H',
      'image':
          'https://i2.wp.com/cadernopop.com.br/wp-content/uploads/2020/03/Jorge-Mateus.jpg?fit=900%2C900&ssl=1'
    },
    {
      'name': 'Garota White',
      'place': 'Sport Marina',
      'date': 'Sab, 30 abril - 23:00H',
      'image':
          'https://diaonline.ig.com.br/aproveite/wp-content/uploads/2021/04/live-wesley-safadao-cantor-faz-show-on-line-chamado-segue-o-lider.jpeg'
    },
    {
      'name': 'Matheus e Kauan Forrock',
      'place': 'Sport Marina',
      'date': 'Qua, 2 abril - 19:00H',
      'image':
          'https://uploads.metropoles.com/wp-content/uploads/2019/12/29110853/os-cantores-sertanejos-matheus-e-kauan-respectivamente-1577615861427_v2_1920x1230.jpg'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.profileTabViewContainer,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'MEUS EVENTOS',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3F414E),
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Ver todos',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFBDBDBD),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Container(
              height: 218,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                itemBuilder: (context, index) => MyEventListItem(events[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

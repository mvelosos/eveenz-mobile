import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class EventsTabView extends StatefulWidget {
  const EventsTabView({Key? key}) : super(key: key);

  @override
  _EventsTabViewState createState() => _EventsTabViewState();
}

class _EventsTabViewState extends State<EventsTabView> {
  List<String> _items = ['a', 'b', 'c', 'd'];

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
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'EVENTOS EM ALTA',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: AppColors.darkPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Ver todos',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: AppColors.gray3,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 169,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _items.length,
                        separatorBuilder: (_, __) => SizedBox(width: 12),
                        itemBuilder: (context, item) => Container(
                          height: 169,
                          width: 264,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 15, left: 10),
                                  child: Container(
                                    height: 13,
                                    width: 120,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10, left: 10),
                                  child: Container(
                                    height: 10,
                                    width: 200,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_base_project/models/m_report.dart';
import 'package:flutter_base_project/utils/values/colors.dart';

class ItemReport extends StatelessWidget {
  final List report;

  const ItemReport({Key key, this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: report.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            ///untuk tekan ke Detail
            ///bisa pakai juga : Gesture Detector
            child: makeCard(report[index], index, context),
            onTap: () {
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailStudent(loan: report[index],),
                ),
              );*/
            },
          );
        },
      ),
    );
  }

  ///ini Membuat Card
  makeCard(Data reports, int index, BuildContext context) => Container(
    child: Card(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5.0,
      child: contentList(reports, context),
    ),
  );

  ///Ini List dari layout Card
  contentList(Data reports, BuildContext context) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
             Text(reports.workDesc),
             Text(reports.employer),
             Text(reports.vendor),
            ],
          ),
        ),
      ],
    ),
  );
}

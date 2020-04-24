import 'package:flutter/material.dart';
import '../../model/radio_schedule_model.dart';

class IndexSchedule extends StatefulWidget {
  @override
  _IndexScheduleState createState() => _IndexScheduleState();
}

class _IndexScheduleState extends State<IndexSchedule> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            for (MapEntry day in radioScheduleData.entries) ...[
              Card(
                color: day.key == 'Senin' ||
                        day.key == 'Rabu' ||
                        day.key == 'Jumat' ||
                        day.key == 'Minggu'
                    ? Colors.yellow.shade100
                    : Colors.blue.shade100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        day.key,
                        style: TextStyle(
                            fontFamily: 'Acme',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                            fontSize: 15.0),
                      ),
                    ),
                    for (var content in day.value) ...[
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.timer,
                                  size: 13.0,
                                ),
                                Text(' '),
                                Text(
                                  content['Pukul'],
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Acme'),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    content['Acara'],
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        fontFamily: 'Kalam',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    content['Penyiar'],
                                    style: TextStyle(
                                        fontSize: 10.0, fontFamily: 'Acme'),
                                  ),
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.all(3))
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Divider(),
            ],
          ],
        ),
      ),
    );
  }
}

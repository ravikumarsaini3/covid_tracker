import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/recordapi.dart';
import 'package:flutter_application_1/model/Worldrecord.dart';
import 'package:flutter_application_1/screen/country.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();
  List<Color> color = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
  ];

  final Recordapi _recordapi = Recordapi();
  var _mediaQuery;
  @override
  Widget build(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: _recordapi.getrecordapi(),
              builder: (context, AsyncSnapshot<Worldrecordmodel> snapshot) {
                if (!snapshot.hasData) {
                  return SpinKitCircle(
                    size: 100,
                    color: Colors.white,
                    controller: _animationController,
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: _mediaQuery.size.height * 0.03,
                      ),
                      PieChart(
                        colorList: color,
                        animationDuration: const Duration(seconds: 2),
                        dataMap: {
                          'Cases':
                              double.parse(snapshot.data!.cases.toString()),
                          'Active':
                              double.parse(snapshot.data!.active.toString()),
                          'recover':
                              double.parse(snapshot.data!.recovered.toString()),
                          'death':
                              double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartType: ChartType.ring,
                        chartRadius: 160,
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true),
                      ),
                      SizedBox(
                        height: _mediaQuery.size.height * 0.05,
                      ),
                      SizedBox(
                        height: 300,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Reuseablerow(
                                  title: 'cases',
                                  value: snapshot.data!.cases.toString()),
                              Reuseablerow(
                                  title: 'Active',
                                  value: snapshot.data!.active.toString()),
                              Reuseablerow(
                                  title: 'recovered',
                                  value: snapshot.data!.recovered.toString()),
                              Reuseablerow(
                                  title: 'critical',
                                  value: snapshot.data!.critical.toString()),
                              Reuseablerow(
                                  title: 'tests',
                                  value: snapshot.data!.tests.toString()),
                              Reuseablerow(
                                  title: 'deaths',
                                  value: snapshot.data!.deaths.toString()),
                              Reuseablerow(
                                  title: 'todayCases',
                                  value: snapshot.data!.todayCases.toString()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _mediaQuery.size.height * 0.04,
                      ),
                      SizedBox(
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const Country();
                                },
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    const Color.fromARGB(255, 12, 35, 13)),
                            child: const Text(
                              'Track Country',
                              style: TextStyle(fontSize: 20),
                            )),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Reuseablerow extends StatelessWidget {
  final String title;
  final String value;

  const Reuseablerow({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 17),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                Text(
                  value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
                ),
              ],
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}

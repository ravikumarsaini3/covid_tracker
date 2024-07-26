import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final int cases, population, tests, active, recovered, deaths;
  final String country, flag;
  const Details(
      {super.key,
      required this.cases,
      required this.population,
      required this.tests,
      required this.active,
      required this.recovered,
      required this.deaths,
      required this.country,
      required this.flag});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(widget.flag),
            ),
          ),
          SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Reuseablerow(
                        title: 'Cases', value: widget.cases.toString()),
                    Reuseablerow(
                        title: 'population',
                        value: widget.population.toString()),
                    Reuseablerow(
                        title: 'tests', value: widget.tests.toString()),
                    Reuseablerow(
                        title: 'active', value: widget.active.toString()),
                    Reuseablerow(
                        title: 'deaths', value: widget.deaths.toString()),
                    Reuseablerow(
                        title: 'Cases', value: widget.cases.toString()),
                    Reuseablerow(
                        title: 'Cases', value: widget.cases.toString()),
                  ],
                ),
              )),
        ],
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

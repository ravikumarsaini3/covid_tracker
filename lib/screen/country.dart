import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/api/recordapi.dart';
import 'package:flutter_application_1/screen/details.dart';

import 'package:shimmer/shimmer.dart';

class Country extends StatefulWidget {
  const Country({super.key});

  @override
  State<Country> createState() => _CountryState();
}

class _CountryState extends State<Country> {
  var _searchcontroller = TextEditingController();
  final Recordapi _recordapi = Recordapi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              onChanged: (value) {
                setState(() {});
              },
              controller: _searchcontroller,
              decoration: InputDecoration(
                  hintText: 'search with country',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: _recordapi.getcountry(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    String title = snapshot.data![index]['country'];
                    if (_searchcontroller.text.isEmpty) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Details(
                                  cases: snapshot.data![index]['cases'],
                                  population: snapshot.data![index]
                                      ['population'],
                                  tests: snapshot.data![index]['tests'],
                                  active: snapshot.data![index]['active'],
                                  recovered: snapshot.data![index]['recovered'],
                                  deaths: snapshot.data![index]['deaths'],
                                  country: snapshot.data![index]['country'],
                                  flag: snapshot.data![index]['countryInfo']
                                      ['flag']);
                            },
                          ));
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot
                                      .data![index]['countryInfo']['flag']),
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (title
                        .toLowerCase()
                        .contains(_searchcontroller.text.toLowerCase())) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Details(
                                  cases: snapshot.data![index]['cases'],
                                  population: snapshot.data![index]
                                      ['population'],
                                  tests: snapshot.data![index]['tests'],
                                  active: snapshot.data![index]['active'],
                                  recovered: snapshot.data![index]['recovered'],
                                  deaths: snapshot.data![index]['deaths'],
                                  country: snapshot.data![index]['country'],
                                  flag: snapshot.data![index]['countryInfo']
                                      ['flag']);
                            },
                          ));
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot
                                      .data![index]['countryInfo']['flag']),
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              } else {
                return Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    enabled: true,
                    child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Container(
                                color: Color.fromRGBO(242, 238, 238, 1),
                                height: 30,
                                width: 40,
                              ),
                              title: Container(
                                color: Colors.white,
                                height: 10,
                                width: 80,
                              ),
                              subtitle: Container(
                                color: Colors.white,
                                height: 10,
                                width: 80,
                              ),
                            )
                          ],
                        );
                      },
                    ));
              }
            },
          ))
        ],
      ),
    );
  }
}

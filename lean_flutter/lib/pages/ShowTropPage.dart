import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lean_flutter/config/config.dart';
import 'package:lean_flutter/config/internal_config.dart';
import 'package:lean_flutter/model/response/trips_get_response.dart';
import 'package:lean_flutter/pages/profile.dart';
import 'package:lean_flutter/pages/trip.dart';

class Showtroppage extends StatefulWidget {
  int cid = 0;
  Showtroppage({super.key, required this.cid});

  @override
  State<Showtroppage> createState() => _ShowtroppageState();
}

class _ShowtroppageState extends State<Showtroppage> {
  List<TripsGetResponse> tripGetResponses = [];
  List<TripsGetResponse> tripzone = [];
  late Future<void> loadData;
  //Only one time executon and can't not run asyn function
  @override
  void initState() {
    super.initState();
    loadData = getTrips();
    log(widget.cid.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('trip'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              log(value);
              if (value == 'proflie') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(idx: widget.cid),
                  ),
                );
              } else if (value == 'logout') {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(child: Text('ข้อมูลส่วนตัว'), value: 'proflie'),
              PopupMenuItem(child: Text('ออกจากระบบ'), value: 'logout'),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ปลายทาง', style: TextStyle(fontSize: 15)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 8,
                  children: [
                    FilledButton(onPressed: () {}, child: Text('ทั้งหมด')),
                    FilledButton(
                      onPressed: () {
                        zone('เอเชีย');
                      },
                      child: Text('เอเชีย'),
                    ),
                    FilledButton(
                      onPressed: () {
                        zone('ยุโรป');
                      },
                      child: Text('ยุโรป'),
                    ),
                    FilledButton(
                      onPressed: () {
                        zone('เอเชียตะวันออกเฉียงใต้');
                      },
                      child: Text('อาเซียน'),
                    ),
                    FilledButton(
                      onPressed: () {
                        zone('อื่นๆ');
                      },
                      child: Text('อื่นๆ'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: tripzone
                      .map(
                        (e) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 8,
                                  children: [
                                    Image.network(e.coverimage, width: 180),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(e.country),
                                        Text('ระยะเวลา ${e.duration} วัน'),
                                        Text('ราคา ${e.price} บาท'),
                                        Text('โซน ${e.destinationZone} '),
                                        FilledButton(
                                          onPressed: () => gotoTrip(e.idx),
                                          child: Text('รายละเอียด'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                  255,
                                                  22,
                                                  116,
                                                  238,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void gotoTrip(int idx) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Trippage(idx: idx)),
    );
  }

  Future<void> getTrips() async {
    var res = await http.get(Uri.parse('$api_Endpoint/trips'));
    log(res.body);
    tripGetResponses = tripsGetResponseFromJson(res.body);
    tripzone = tripsGetResponseFromJson(res.body);
    log(tripGetResponses.length.toString());
  }

  Future<void> zone(String zone) async {
    tripzone.clear();
    for (var trip in tripGetResponses) {
      if (trip.destinationZone == zone) {
        tripzone.add(trip);
      }
    }
    setState(() {});
  }
}

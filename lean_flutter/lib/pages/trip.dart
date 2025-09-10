import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lean_flutter/config/config.dart';
import 'package:lean_flutter/model/response/trip_idx_get_res.dart';

class Trippage extends StatefulWidget {
  int idx = 0;
  Trippage({super.key, required this.idx});
  @override
  State<Trippage> createState() => _tripState();
}

class _tripState extends State<Trippage> {
  String url = "";
  late TripsidxGetResponse tripIdxGetResponse;
  late Future<void> loadData;
  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: loadData,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Text(
                tripIdxGetResponse.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(tripIdxGetResponse.country),
              SizedBox(height: 8),
              Image.network(tripIdxGetResponse.coverimage),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ราคา ${tripIdxGetResponse.price.toString()}'),
                  Text('โซน ${tripIdxGetResponse.destinationZone}'),
                ],
              ),
              SizedBox(height: 10),
              Text(tripIdxGetResponse.detail),
              SizedBox(height: 16),
              FilledButton(
                onPressed: () {},
                child: Text('จองทริป'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 22, 116, 238),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> loadDataAsync() async {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];
    var res = await http.get(Uri.parse('$url/trips/${widget.idx}'));
    log(res.body);
    tripIdxGetResponse = tripsidxGetResponseFromJson(res.body);
  }
}

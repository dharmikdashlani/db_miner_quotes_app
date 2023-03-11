import 'package:flutter/material.dart';
import 'package:quotes_app/helper/db_helper.dart';
import 'package:quotes_app/models/db_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class Attitude extends StatefulWidget {
  const Attitude({Key? key}) : super(key: key);

  @override
  State<Attitude> createState() => _AttitudeState();
}

class _AttitudeState extends State<Attitude> {
  late Future<List<QUT>> getAllQuotes;

  fetch() async {
    Future.delayed(
        const Duration(seconds: 10),
        () => setState(() {
              getAllQuotes = DBHelper.dbHelper.fetachAlAttitudeRecords();
            }));
  }

  forGetVariable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isAttitudeArrived = prefs.getBool('attitudeArrived') ?? false;

    (isAttitudeArrived == false)
        ? DBHelper.dbHelper.lodeAttitudeJasonBank()
        : getAllQuotes = DBHelper.dbHelper.fetachAlAttitudeRecords();
  }

  @override
  void initState() {
    super.initState();
    forGetVariable();
    getAllQuotes = DBHelper.dbHelper.fetachAlAttitudeRecords();

    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Attitude Quotes",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getAllQuotes,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.hasError}"),
            );
          } else if (snapshot.hasData) {
            List<QUT> data = snapshot.data as List<QUT>;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 10,
                    child: Container(
                      alignment: Alignment.center,
                      height: 400,
                      decoration: BoxDecoration(
                          color: (i % 2 == 0)
                              ? Colors.greenAccent
                              : Colors.lightGreen,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              "${data[i].quote}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              "- ${data[i].name}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await Share.share("Name: ${data[i].quote}");
                                  },
                                  icon: const Icon(
                                    Icons.share,
                                    size: 30,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.download,
                                    size: 30,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.star,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // title: Text("${data[i].name}"),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  isDataArrived() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('attitudeArrived', true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isDataArrived();
  }
}

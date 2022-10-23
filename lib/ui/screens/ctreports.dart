import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:researchapp/env.dart';
import 'package:researchapp/logic/auth_status/authstatus_cubit.dart';
import 'package:researchapp/ui/screens/Report.dart';
import 'package:researchapp/ui/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CovidCT extends StatefulWidget {
  CovidCT({Key? key}) : super(key: key);

  @override
  State<CovidCT> createState() => _CovidCTState();
}

class _CovidCTState extends State<CovidCT> {
  var jwt = Hive.box("main").get("jwt");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarr,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AuthstatusCubit, AuthstatusState>(
          builder: (context, state) {
            if (state is LoggedIn) {
              return Container(
                child: FutureBuilder<http.Response>(
                    future: http.post(
                      Uri.parse(SERVER_URL + '/GetCases'),
                      headers: {
                        'X-API-Key': API_KEY,
                        'Content-Type': 'application/json',
                        'x-access-token': jwt
                      },
                      body: jsonEncode({"Type": "CovidCT"}),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.connectionState == ConnectionState.active ||
                          snapshot.connectionState == ConnectionState.none) {
                        return Container();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        final data = jsonDecode(snapshot.data!.body);
                        final data2 = data["result"];
                        print(data2);
                        return ListView.builder(
                            itemCount: data2.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Report(
                                                name: state.username as String,
                                                Age: state.age as String,
                                                diseases: "Covid CT" as String,
                                                gender: state.Gender as String,
                                                prediction: data2[index]
                                                        ["result"]
                                                    .toString(),
                                                ImgFile: data2[index]
                                                    ["ImgFile"],
                                              )));
                                },
                                child: ListTile(
                                    title: Text(
                                        "Report Of " + data2[index]["date"])),
                              );
                            });
                      } else
                        return Container();
                    }),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

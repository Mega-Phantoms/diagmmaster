import 'package:flutter/material.dart';
import 'package:researchapp/constants.dart';
import 'package:researchapp/logic/auth_status/authstatus_cubit.dart';
import 'package:researchapp/logic/themecubit/theme_cubit.dart';
import 'package:researchapp/ui/screens/add_case.dart';
import 'package:researchapp/ui/screens/awarenesspage.dart';
import 'package:researchapp/ui/screens/ctreports.dart';
import 'package:researchapp/ui/screens/reports.dart';
import '../../logic/splashscreen/splashscreen_cubit.dart';
import '../widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<AuthstatusCubit, AuthstatusState>(
      builder: (context, state) {
        if (state is LoggedIn) {
          return Scaffold(
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 215, 225, 207),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Color.fromARGB(255, 125, 174, 112),
                        ),
                        Text(
                          state.phno,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('Covid CT Reports'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CovidCT()));
                    },
                  ),
                  ListTile(
                    title: const Text('Covid X-Ray Reports'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Reports()));
                    },
                  ),
                  ListTile(
                    title: const Text('TuberCulosis Reports'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Reports()));
                    },
                  ),
                  ListTile(
                    title: const Text('Awareness Programs'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AwarennessPage()));
                    },
                  ),
                  ListTile(
                    title: const Text('Logout'),
                    leading: Icon(Icons.logout),
                    onTap: () {
                      context.read<AuthstatusCubit>().logout();
                      context.read<SplashscreenCubit>().initialize();
                      Navigator.of(context)
                          .popUntil(ModalRoute.withName(SPLASH_SCREEN));
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text("DIAGMASTER"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(
                        " Welcome ${state.username}",
                        style: GoogleFonts.notoSans(
                            fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final box = Hive.box("main");
                        final jwt = box.get("jwt");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCase(
                                    title: "Covid Xray",
                                    path: "/new-CovidCT",
                                    JWT: jwt)));
                      },
                      child: Container(
                        height: height / 6,
                        width: width,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                          ),
                          elevation: 0,
                          color: Color.fromARGB(255, 125, 174, 112),
                          child: Container(
                            height: height / 6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Covid X-Ray")],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final box = Hive.box("main");
                        final jwt = box.get("jwt");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCase(
                                    title: "Covid Xray",
                                    path: "/new-CovidCT",
                                    JWT: jwt)));
                      },
                      child: Container(
                        height: height / 6,
                        width: width,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                          ),
                          elevation: 0,
                          color: Color.fromARGB(255, 125, 174, 112),
                          child: Container(
                            height: height / 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Tuber Culosis")],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: height / 6,
                        width: width,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                          ),
                          elevation: 0,
                          color: Color.fromARGB(255, 125, 174, 112),
                          child: Container(
                            height: height / 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Covid X-Ray")],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: Text("unknown state")),
          );
        }
      },
    );
  }
}

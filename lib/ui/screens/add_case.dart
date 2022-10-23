import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:researchapp/env.dart';
import 'package:researchapp/logic/add_case/add_case_cubit.dart';
import 'package:researchapp/logic/file_upload/file_uploadf_cubit.dart';
import 'package:researchapp/logic/themecubit/theme_cubit.dart';
import '../../logic/view_cases/view_cases_cubit.dart';
import '../widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:file_picker/file_picker.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddCase extends StatefulWidget {
  String title;
  String path;
  String JWT;
  AddCase({required this.title, required this.path, required this.JWT})
      : super();

  @override
  State<AddCase> createState() => _AddCaseState();
}

class _AddCaseState extends State<AddCase> {
  @override
  void initState() {
    super.initState();
    context.read<FileUploadfCubit>().reload();
    context.read<AddCaseCubit>().reload();
  }

  Future<bool> getPrediction(String FileID, String jwt, String path) async {
    try {
      var response = await http.post(
        Uri.parse(SERVER_URL + path),
        headers: {
          'X-API-Key': API_KEY,
          'Content-Type': 'application/json',
          'x-access-token': jwt
        },
        body: jsonEncode({"ImgID": FileID}),
      );
      print(response.body);
      var res = jsonDecode(response.body);
      return false;
    } catch (e) {
      return false;
    }
    return false;
  }

  showtoast(String message) {
    Fluttertoast.showToast(
      msg: message, // message
      toastLength: Toast.LENGTH_SHORT, // length
      gravity: ToastGravity.BOTTOM, // location
      timeInSecForIosWeb: 4,
    );
  }

  var casen = TextEditingController();
  var descont = TextEditingController();
  var fkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarr,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: height,
          width: width,
          // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          child: Form(
            key: fkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: height / 2,
                        width: width / 1.5,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: BlocBuilder<FileUploadfCubit, FileUploadfState>(
                          builder: (context, state) {
                            if (state is FileUploadfInitial) {
                              return GestureDetector(
                                onTap: () async {
                                  File file;
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: [
                                        "jpeg",
                                        "jpg",
                                        "png"
                                      ]);
                                  if (result != null) {
                                    file = File(result.files.single.path!);
                                    context.read<FileUploadfCubit>().fileupload(
                                        file, widget.path, widget.JWT);
                                  } else {
                                    showtoast("No File was selected");
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color:
                                        context.read<ThemeCubit>().gettheme() ==
                                                "Light"
                                            ? Colors.black
                                            : Colors.teal,
                                  )),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Select a File",
                                            style: GoogleFonts.notoSans(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500)),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              Icon(FontAwesomeIcons.fileImage),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else if (state is FileUploadLoad) {
                              return SpinKitRotatingCircle(
                                color: context.read<ThemeCubit>().gettheme() ==
                                        "Light"
                                    ? Colors.black
                                    : Colors.teal,
                                size: 50.0,
                              );
                            } else if (state is FileUploadSuccess) {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      child: Center(
                                          child: Text(
                                              "File was uploaded Please while we predict"))),
                                  ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<FileUploadfCubit>()
                                            .reload();
                                      },
                                      child: Text("Reload")),
                                ],
                              );
                            } else if (state is PredictionTrue) {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      child: Center(
                                          child: Text(widget.title +
                                              "prediction was true"))),
                                  ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<FileUploadfCubit>()
                                            .reload();
                                      },
                                      child: Text("Reload")),
                                  Image.file(
                                    state.file,
                                    width: width / 2,
                                    height: height / 2.5,
                                  )
                                ],
                              );
                            } else if (state is PredictionFalse) {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      child: Center(
                                          child: Text(widget.title +
                                              "prediction was false"))),
                                  ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<FileUploadfCubit>()
                                            .reload();
                                      },
                                      child: Text("Reload")),
                                  Image.file(
                                    state.file,
                                    width: width / 2,
                                    height: height / 2.5,
                                  )
                                ],
                              );
                            } else {
                              return Container(
                                child: Text("oomf state"),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

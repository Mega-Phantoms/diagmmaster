import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:researchapp/constants.dart';
import 'package:researchapp/env.dart';
import 'package:researchapp/logic/auth_status/authstatus_cubit.dart';
import 'package:researchapp/logic/logincubit/logincubit_cubit.dart';
import 'package:researchapp/logic/signupcubit/signup_cubit.dart';
import 'package:researchapp/logic/themecubit/theme_cubit.dart';
import 'package:researchapp/ui/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

showtoast(String message) {
  print("abc");
  Fluttertoast.showToast(
    msg: message, // message
    toastLength: Toast.LENGTH_SHORT, // length
    gravity: ToastGravity.BOTTOM, // location
    timeInSecForIosWeb: 5,
  );
}

void sendOTP(String phoneNumber) async {
  showtoast("OTP Sent to " + phoneNumber);
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  final phonenumber = TextEditingController();
  final otpfield = TextEditingController();

  Future<void> sendOTP(String phoennum) async {
    final response = await http.post(Uri.parse(SERVER_URL + "/signup"),
        headers: {'X-API-Key': API_KEY, 'Content-Type': 'application/json'},
        body: jsonEncode({
          "MobileNum": phoennum,
        }));
    print(response.body);
  }

  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarr,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Phone Number:",
                textAlign: TextAlign.left,
              ),
            ),
            TextFormField(
              controller: phonenumber,
              validator: ((value) {
                if (value == null || value.isEmpty)
                  return 'Please enter some text';
                else if (value.length < 6) return "Enter a longer username";
                return null;
              }),
            ),
            Container(
              height: 30,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "OTP:",
                textAlign: TextAlign.left,
              ),
            ),
            TextFormField(
              controller: otpfield,
              obscureText: true,
              validator: ((value) {
                if (value == null || value.isEmpty)
                  return 'Please enter some text';
                else if (value.length < 6) return "Enter a longer password";
                return null;
              }),
            ),
            Container(
              height: 30,
            ),
            BlocConsumer<LogincubitCubit, LogincubitState>(
              listener: ((context, state) {
                if (state is PasswordErrorState) {
                  showtoast("Incorrect Password !");
                } else if (state is UserNotFound) {
                  showtoast("User not found !");
                } else if (state is LoginError) {
                  showtoast("Weird Error !");
                } else if (state is LoginSuccess) {
                  context.read<AuthstatusCubit>().login(
                      state.name, state.phonenumber, state.gender, state.age);
                  Navigator.pushNamedAndRemoveUntil(
                      context, HOME_ROUTE, (route) => false);
                }
              }),
              builder: (context, state) {
                if (state is LogincubitInitial) {
                  return ElevatedButton(
                      onPressed: () {
                        context
                            .read<LogincubitCubit>()
                            .login(phonenumber.text, otpfield.text);
                      },
                      child: Text("Submit"));
                } else if (state is LoginLoad) {
                  return SpinKitRotatingCircle(
                    color: context.read<ThemeCubit>().gettheme() == "Light"
                        ? Colors.black
                        : Colors.teal,
                    size: 50.0,
                  );
                } else
                  return ElevatedButton(
                      onPressed: () {
                        context.read<LogincubitCubit>().reload();
                      },
                      child: Text("Retry"));
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  if (phonenumber.text.length == 10) sendOTP(phonenumber.text);
                },
                child: Text("Send OTP"))
          ]),
        ),
      ),
    );
  }
}

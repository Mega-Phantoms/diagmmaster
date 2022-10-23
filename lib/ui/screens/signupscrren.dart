import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:researchapp/logic/signupcubit/signup_cubit.dart';
import 'package:researchapp/ui/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../env.dart';
import '../../logic/themecubit/theme_cubit.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formkey = GlobalKey<FormState>();

  final phonecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final otpcontroller = TextEditingController();
  final gendercontroller = TextEditingController();
  final namecontroller = TextEditingController();

  showtoast(String message) {
    Fluttertoast.showToast(
      msg: message, // message
      toastLength: Toast.LENGTH_SHORT, // length
      gravity: ToastGravity.BOTTOM, // location
      timeInSecForIosWeb: 4,
    );
  }

  Future<void> sendOTP(String phoennum) async {
    final response = await http.post(Uri.parse(SERVER_URL + "/signup"),
        headers: {'X-API-Key': API_KEY, 'Content-Type': 'application/json'},
        body: jsonEncode({
          "MobileNum": phoennum,
        }));
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarr,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name :"),
                    TextFormField(
                      controller: namecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter some text';

                        return null;
                      },
                    ),
                  ],
                )),
            Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Age:"),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter some text';
                        else if (value.length < 6)
                          return "Enter a longer address";
                        return null;
                      },
                      controller: agecontroller,
                    ),
                  ],
                )),
            Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Phone Number"),
                    TextFormField(
                      // obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter some text';
                        else if (value.length != 10)
                          return "Enter a valid Phone Number";
                        return null;
                      },
                      controller: phonecontroller,
                    ),
                  ],
                )),
            Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("OTP"),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter some text';
                        else if (value.length != 10)
                          return "Enter a valid Phone Number";
                        return null;
                      },
                      controller: otpcontroller,
                    ),
                  ],
                )),
            Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Gender"),
                    TextFormField(
                      // obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter some text';
                        else if (value.length != 10)
                          return "Enter a valid Phone Number";
                        return null;
                      },
                      controller: gendercontroller,
                    ),
                  ],
                )),
            Container(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  await sendOTP(phonecontroller.text);
                },
                child: Text("Send OTP")),
            BlocConsumer<SignupCubit, SignupState>(
              listener: ((context, state) {
                if (state is SignUpSucess)
                  showtoast("Signup success");
                else if (state is EmailExists)
                  showtoast("email already exists");
                else if (state is SignUpFail) showtoast("signup had failed");
              }),
              builder: (context, state) {
                if (state is SignupInitial) {
                  return Container(
                    child: ElevatedButton(
                        onPressed: () {
                          context.read<SignupCubit>().signup(
                              phonecontroller.text,
                              otpcontroller.text,
                              int.parse(agecontroller.text),
                              namecontroller.text,
                              gendercontroller.text);
                        },
                        child: Text("Sign Up")),
                  );
                } else if (state is SignUpLoad) {
                  return SpinKitRotatingCircle(
                    color: context.read<ThemeCubit>().gettheme() == "Light"
                        ? Colors.black
                        : Colors.teal,
                    size: 50.0,
                  );
                } else {
                  return ElevatedButton(
                      onPressed: () {
                        context.read<SignupCubit>().reload();
                      },
                      child: Text("retry"));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

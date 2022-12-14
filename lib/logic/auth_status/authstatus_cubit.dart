import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'authstatus_state.dart';

class AuthstatusCubit extends Cubit<AuthstatusState> {
  AuthstatusCubit() : super(AuthstatusInitial());
  var box = Hive.box("main");

  void login(String name, String phonenumber, String gender, String age) {
    emit(LoggedIn(username: name, phno: phonenumber, Gender: gender, age: age));
  }

  void logout() {
    box.put("user", null);
    box.put("jwt", null);
    emit(LoggedOut());
  }

  int isLoggedIn() {
    return (state is LoggedIn) ? 1 : 0;
  }
}

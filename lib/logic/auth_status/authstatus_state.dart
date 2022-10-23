part of 'authstatus_cubit.dart';

@immutable
abstract class AuthstatusState {}

class AuthstatusInitial extends AuthstatusState {}

class LoggedIn extends AuthstatusState {
  String username;
  String phno;
  String age;
  String Gender;
  LoggedIn({required this.username,required this.Gender,required this.age,required this.phno});
}

class LoggedOut extends AuthstatusState {}

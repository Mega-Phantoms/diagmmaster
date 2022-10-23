part of 'logincubit_cubit.dart';

@immutable
abstract class LogincubitState {}

class LogincubitInitial extends LogincubitState {}

class LoginLoad extends LogincubitState {}

class LoginSuccess extends LogincubitState {
  String name;
  String age;
  String gender;
  String phonenumber;
  LoginSuccess({required this.name,required this.age,required this.gender,required this.phonenumber});
}

class PasswordErrorState extends LogincubitState {}

class UserNotFound extends LogincubitState {}

class LoginError extends LogincubitState {}

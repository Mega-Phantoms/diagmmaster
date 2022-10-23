import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:researchapp/services/auth_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:researchapp/services/exceptions.dart';

part 'logincubit_state.dart';

class LogincubitCubit extends Cubit<LogincubitState> {
  AuthService authService;
  final box = Hive.box("main");
  LogincubitCubit({required this.authService}) : super(LogincubitInitial());

  void login(String phoneno, String OTP) async {
    emit(LoginLoad());

    try {
      Map<String, dynamic> response = await authService.login(phoneno, OTP);
      if (response["success"]) {
        box.put("jwt", response["token"]);
        box.put("user", phoneno);
      }
      emit(LoginSuccess(
          name: response["user"]["FirstName"],
          age: response["user"]["age"].toString(),
          gender: response["user"]["gender"],
          phonenumber: response["user"]["MobileNum"]));
    } on PasswordError {
      emit(PasswordErrorState());
    } on UserNotFoundError {
      emit(UserNotFound());
    } on APIKeyError {
      emit(LoginError());
    } on InternetError {
      emit(LoginError());
    }
  }

  void reload() {
    emit(LogincubitInitial());
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:researchapp/services/auth_service.dart';
import 'package:researchapp/services/exceptions.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  AuthService authService;

  SignupCubit({required this.authService}) : super(SignupInitial());

  void signup(
      String phoneno, String OTP, int age, String name, String gender) async {
    emit(SignUpLoad());
    try {
      var response = await authService.signup(phoneno, OTP, name, age, gender);
      print(response);
      if (response["success"] == true)
        emit(SignUpSucess());
      else
        emit(SignUpFail());
    } on EmailAlreadyExistsError {
      emit(EmailExists());
    } on APIKeyError {
      emit(SignUpFail());
    }
  }

  void reload() {
    emit(SignupInitial());
  }
}

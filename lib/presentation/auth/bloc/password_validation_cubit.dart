import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordValidationCubit extends Cubit<String?> {
  PasswordValidationCubit() : super(null);

  void validate(String password) {
    if (password.isEmpty) {
      emit('Please enter your password');
    } else if (!_isValidPassword(password)) {
      emit('Password must be at least 8 characters,\ninclude upper/lowercase and a number');
    } else {
      emit(null); // no error
    }
  }

  bool _isValidPassword(String password) {
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(password);
  }
}

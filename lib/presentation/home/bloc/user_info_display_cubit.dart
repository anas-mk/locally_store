import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/domain/auth/usecases/get_user.dart';
import 'package:locally/presentation/home/bloc/user_info_display_state.dart';
import 'package:locally/service_locator.dart';

class UserInfoDisplayCubit extends Cubit<UserInfoDisplayState> {
  
  UserInfoDisplayCubit() : super(UserInfoLoading());

  void displayUserInfo() async {
    var returnedData = await sl<GetUserUseCase>().call();
    returnedData.fold(
      (error){
        emit(
          LoadUserInfoFailure()
        );
      }, 
      (data){
        emit(
          UserInfoLoaded(
            user: data
          )
        );
      }
    );
  }


}
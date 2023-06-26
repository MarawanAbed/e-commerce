part of 'Register_cubit.dart';

@immutable
abstract class ReigsterState {}

class RegisterInitial extends ReigsterState {}
class RegisterLoading extends ReigsterState {}

class RegisterSuccess extends ReigsterState {
  final LoginModel loginModel;

  RegisterSuccess(this.loginModel);

}
class RegisterError extends ReigsterState {
  final String error;

  RegisterError(this.error);


}

class RegisterPasswordVisiability extends ReigsterState{}


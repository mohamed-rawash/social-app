abstract class AuthStates {}

class InitialState extends AuthStates {}

class ChangePasswordVisibilityState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}
class RegisterSuccessState extends AuthStates {}
class RegisterErrorState extends AuthStates {
  final String? error;

  RegisterErrorState({this.error});
}

class LoginLoadingState extends AuthStates {}
class LoginSuccessState extends AuthStates {}
class LoginErrorState extends AuthStates {
  final String? error;

  LoginErrorState({this.error});
}

class SignOutSuccessState extends AuthStates {}

class AddUserToFireStoreState extends AuthStates {}
class GetUserFromFireStoreState extends AuthStates {}


import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/view_model/services/fire_store_service.dart';
import 'package:social_app/view_model/states/auth_states.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit() : super(InitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordInvisible = true;
  String? userName;
  String? email;
  String? phone;
  String? image;
  String? password;
  String? message;

  changePasswordVisibility(){
    isPasswordInvisible = !isPasswordInvisible;
    emit(ChangePasswordVisibilityState());
  }

  signUp()async {
    emit(RegisterLoadingState());
    try {
      UserCredential _userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!,
          password: password!
      );
      await addUserToFireStore(_userCredential);
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        print('The password provided is too weak');
        message = 'The password provided is too weak';
        emit(RegisterErrorState(error: message));
      } else if (error.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        message = 'The account already exists for that email';
        emit(RegisterErrorState(error: message));
      } else {
        emit(RegisterErrorState(error: error.message));
      }
    }

  }

  signIn() async {
    emit(LoginLoadingState());
    try {
      UserCredential _userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email!,
          password: password!
      );
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('No user found for that email.');
        message = 'No user found for that email';
        emit(LoginErrorState(error: message));
      } else if (error.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        message = 'Wrong password provided for that user';
        emit(LoginErrorState(error: message));
      } else {
        emit(LoginErrorState(error: error.message));
      }
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(SignOutSuccessState());
  }

  addUserToFireStore(UserCredential userCredential) async{
    UserModel _userModel = UserModel(
      id: userCredential.user!.uid,
      email: userCredential.user!.email,
      name: userName??userCredential.user!.displayName,
      phone: phone??userCredential.user!.phoneNumber,
      image: "",
      coverImage: "",
      bio: "Write Your Bio..."
    );
    await Firestore().addUserToFirestore(_userModel);
    emit(AddUserToFireStoreState());
  }



}



import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:education_app/core/enums/update-user.enum.dart';
import 'package:education_app/src/auth/domain/entities/user.entities.dart';
import 'package:education_app/src/auth/domain/usecases/forgot-password.usecase.dart';
import 'package:education_app/src/auth/domain/usecases/sign-in.usecase.dart';
import 'package:education_app/src/auth/domain/usecases/sign-up.usecase.dart';
import 'package:education_app/src/auth/domain/usecases/update-user.usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth-event.dart';
part 'auth-state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required UpdateUserUseCase updateUserUseCase,
  })  : _signInUseCase = signInUseCase,
        _signUpUseCase = signUpUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        _updateUserUseCase = updateUserUseCase,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoading());
    });
    on<SignInEvent>(_signInHandler);
    on<SignUpEvent>(_signUpHandler);
    on<ForgotPassWordEvent>(_forgotPasswordHandler);
    on<UpdateUserEvent>(_updateUserHandler);
  }
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final UpdateUserUseCase _updateUserUseCase;
  Future<void> _signInHandler(
      SignInEvent event, Emitter<AuthState> emit) async {
    final result = await _signInUseCase(
        SignInParams(email: event.email, password: event.password));
    result.fold(
      (f) => emit(AuthError(f.errorMessage)),
      (user) => emit(SignedIn(user)),
    );
  }

  Future<void> _signUpHandler(
      SignUpEvent event, Emitter<AuthState> emit) async {
    final result = await _signUpUseCase(SignUpParams(
        email: event.email,
        password: event.password,
        fullName: event.fullName));
    result.fold(
      (f) => emit(AuthError(f.errorMessage)),
      (_) => emit(const SignedUp()),
    );
  }

  Future<void> _forgotPasswordHandler(
      ForgotPassWordEvent event, Emitter<AuthState> emit) async {
    final result = await _forgotPasswordUseCase(event.email);
    result.fold(
      (f) => emit(AuthError(f.errorMessage)),
      (_) => emit(const ForgotPasswordSent()),
    );
  }

  Future<void> _updateUserHandler(
      UpdateUserEvent event, Emitter<AuthState> emit) async {
    final result = await _updateUserUseCase(
        UpdateUserParams(action: event.action, userData: event.userData));
    result.fold(
      (f) => emit(AuthError(f.errorMessage)),
      (_) => emit(const UserUpdated()),
    );
  }
}

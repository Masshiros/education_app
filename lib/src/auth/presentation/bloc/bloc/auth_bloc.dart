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

part 'auth_event.dart';
part 'auth_state.dart';

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
        super(const AuthInitial()) {}
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final UpdateUserUseCase _updateUserUseCase;
}

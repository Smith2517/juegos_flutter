/// BLoC de autenticación
///
/// Maneja toda la lógica de negocio relacionada con autenticación
///
/// Autor: [Tu nombre]
/// Fecha: 2025

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    // Registrar manejadores de eventos
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthLinkParentalEmail>(_onAuthLinkParentalEmail);
  }

  /// Verificar estado de autenticación al inicio
  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = _authRepository.currentUser;
      if (user != null) {
        // Usuario existe, obtener datos de Firestore
        final userData = await _authRepository.getUserData(user.uid);
        if (userData != null) {
          emit(AuthAuthenticated(userData));
        } else {
          emit(AuthUnauthenticated());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError('Error al verificar autenticación: $e'));
    }
  }

  /// Manejar registro de nuevo usuario
  Future<void> _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.register(
        username: event.username,
        password: event.password,
        displayName: event.displayName,
        avatarId: event.avatarId,
        age: event.age,
        gender: event.gender,
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  /// Manejar inicio de sesión
  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.login(
        username: event.username,
        password: event.password,
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  /// Manejar cierre de sesión
  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authRepository.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Error al cerrar sesión: $e'));
    }
  }

  /// Vincular email parental
  Future<void> _onAuthLinkParentalEmail(
    AuthLinkParentalEmail event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authRepository.linkParentalEmail(
        event.email,
        event.password,
      );
      // Recargar datos de usuario
      final user = _authRepository.currentUser;
      if (user != null) {
        final userData = await _authRepository.getUserData(user.uid);
        if (userData != null) {
          emit(AuthAuthenticated(userData));
        }
      }
    } catch (e) {
      emit(AuthError('Error al vincular email: $e'));
    }
  }
}

/// Estados del BLoC de autenticación
///
/// Define todos los estados posibles de autenticación
///
/// Autor: [Tu nombre]
/// Fecha: 2025

import 'package:equatable/equatable.dart';
import '../../../data/models/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial (sin verificar autenticación)
class AuthInitial extends AuthState {}

/// Estado de carga (procesando autenticación)
class AuthLoading extends AuthState {}

/// Estado autenticado (usuario logueado)
class AuthAuthenticated extends AuthState {
  final UserModel user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// Estado no autenticado (sin sesión)
class AuthUnauthenticated extends AuthState {}

/// Estado de error
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

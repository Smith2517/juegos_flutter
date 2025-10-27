/// Eventos del BLoC de autenticación
///
/// Define todos los eventos posibles relacionados con autenticación
///
/// Autor: [Tu nombre]
/// Fecha: 2025

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Evento para verificar el estado de autenticación al iniciar la app
class AuthCheckRequested extends AuthEvent {}

/// Evento para registrar nuevo usuario
class AuthRegisterRequested extends AuthEvent {
  final String username;
  final String password;
  final String displayName;
  final String avatarId;
  final int age;
  final String gender; // 'male' o 'female'

  const AuthRegisterRequested({
    required this.username,
    required this.password,
    required this.displayName,
    required this.avatarId,
    required this.age,
    this.gender = 'male',
  });

  @override
  List<Object?> get props => [username, password, displayName, avatarId, age, gender];
}

/// Evento para iniciar sesión con credenciales
class AuthLoginRequested extends AuthEvent {
  final String username;
  final String password;

  const AuthLoginRequested({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}

/// Evento para cerrar sesión
class AuthLogoutRequested extends AuthEvent {}

/// Evento para vincular email parental
class AuthLinkParentalEmail extends AuthEvent {
  final String email;
  final String password;

  const AuthLinkParentalEmail({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

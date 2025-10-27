/// Paleta de colores de la aplicación
///
/// Colores vibrantes pero no saturados, apropiados para niños
///
/// Autor: [Tu nombre]
/// Fecha: 2025

import 'package:flutter/material.dart';

class AppColors {
  // Prevenir instanciación
  AppColors._();

  // Colores primarios
  static const Color primary = Color(0xFF4A90E2); // Azul brillante
  static const Color secondary = Color(0xFF50E3C2); // Verde agua
  static const Color accent = Color(0xFFF5A623); // Naranja cálido

  // Colores de fondo
  static const Color background = Color(0xFFF5F7FA); // Gris muy claro
  static const Color surface = Color(0xFFFFFFFF); // Blanco

  // Colores por categoría
  static const Color mathColor = Color(0xFF5C6AC4); // Púrpura
  static const Color languageColor = Color(0xFFE74C3C); // Rojo
  static const Color scienceColor = Color(0xFF2ECC71); // Verde
  static const Color creativityColor = Color(0xFFF39C12); // Amarillo

  // Colores de estado
  static const Color success = Color(0xFF27AE60); // Verde éxito
  static const Color warning = Color(0xFFF39C12); // Amarillo advertencia
  static const Color error = Color(0xFFE74C3C); // Rojo error
  static const Color info = Color(0xFF3498DB); // Azul información

  // Colores de texto
  static const Color textPrimary = Color(0xFF2C3E50); // Gris oscuro
  static const Color textSecondary = Color(0xFF7F8C8D); // Gris medio
  static const Color textLight = Color(0xFFFFFFFF); // Blanco

  // Colores de recompensas
  static const Color gold = Color(0xFFFFD700); // Oro
  static const Color silver = Color(0xFFC0C0C0); // Plata
  static const Color bronze = Color(0xFFCD7F32); // Bronce

  // Gradientes comunes
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
  );

  static const LinearGradient mathGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5C6AC4), Color(0xFF7B83EB)],
  );

  static const LinearGradient languageGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE74C3C), Color(0xFFFF6B6B)],
  );

  static const LinearGradient scienceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2ECC71), Color(0xFF55EFC4)],
  );

  static const LinearGradient creativityGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF39C12), Color(0xFFFDCB6E)],
  );
}

/// Estilos de texto de la aplicación
///
/// Tipografía optimizada para legibilidad infantil
///
/// Autor: [Tu nombre]
/// Fecha: 2025

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  // Prevenir instanciación
  AppTextStyles._();

  // Display Styles (Titulares muy grandes)
  static TextStyle displayLarge = GoogleFonts.fredoka(
    fontSize: 57,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle displayMedium = GoogleFonts.fredoka(
    fontSize: 45,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle displaySmall = GoogleFonts.fredoka(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Headline Styles (Títulos de sección)
  static TextStyle headlineLarge = GoogleFonts.fredoka(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineMedium = GoogleFonts.fredoka(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineSmall = GoogleFonts.fredoka(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Title Styles (Títulos de tarjetas)
  static TextStyle titleLarge = GoogleFonts.fredoka(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle titleMedium = GoogleFonts.fredoka(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle titleSmall = GoogleFonts.fredoka(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // Body Styles (Texto de cuerpo)
  static TextStyle bodyLarge = GoogleFonts.comicNeue(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle bodyMedium = GoogleFonts.comicNeue(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle bodySmall = GoogleFonts.comicNeue(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // Label Styles (Etiquetas y botones)
  static TextStyle labelLarge = GoogleFonts.fredoka(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
}

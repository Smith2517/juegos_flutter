library;

/// Catálogo de Partes de Avatar
///
/// Define todas las partes de avatar disponibles para desbloquear y comprar.
/// Precios en monedas del juego.
///
/// Autor: Sistema Educativo
/// Fecha: 2025

import '../../domain/models/avatar_model.dart';

class AvatarCatalog {
  // CARAS
  static const List<AvatarPartItem> faces = [
    AvatarPartItem(
      id: 'face_smile',
      category: 'face',
      emoji: '😊',
      name: 'Sonrisa',
      description: 'Cara sonriente básica',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'face_happy',
      category: 'face',
      emoji: '😃',
      name: 'Feliz',
      description: 'Muy feliz',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'face_grin',
      category: 'face',
      emoji: '😁',
      name: 'Sonrisa Grande',
      description: 'Súper contento',
      price: 20,
    ),
    AvatarPartItem(
      id: 'face_cool',
      category: 'face',
      emoji: '😎',
      name: 'Cool',
      description: 'Con estilo',
      price: 50,
    ),
    AvatarPartItem(
      id: 'face_star',
      category: 'face',
      emoji: '🤩',
      name: 'Estrella',
      description: 'Ojos de estrella',
      price: 60,
    ),
    AvatarPartItem(
      id: 'face_nerd',
      category: 'face',
      emoji: '🤓',
      name: 'Estudioso',
      description: 'Cara de inteligente',
      price: 40,
    ),
  ];

  // PELOS (CABELLO)
  static const List<AvatarPartItem> hairs = [
    // Masculino
    AvatarPartItem(
      id: 'hair_curly',
      category: 'hair',
      emoji: '🦱',
      name: 'Rizado',
      description: 'Cabello rizado',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'hair_short',
      category: 'hair',
      emoji: '👦',
      name: 'Corto',
      description: 'Cabello corto',
      price: 15,
    ),
    AvatarPartItem(
      id: 'hair_mohawk',
      category: 'hair',
      emoji: '🧒',
      name: 'Mohawk',
      description: 'Estilo moderno',
      price: 50,
    ),
    // Femenino
    AvatarPartItem(
      id: 'hair_long',
      category: 'hair',
      emoji: '👧',
      name: 'Largo',
      description: 'Cabello largo',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'hair_ponytail',
      category: 'hair',
      emoji: '👱‍♀️',
      name: 'Cola de Caballo',
      description: 'Peinado con cola',
      price: 20,
    ),
    AvatarPartItem(
      id: 'hair_braids',
      category: 'hair',
      emoji: '👩‍🦱',
      name: 'Trenzas',
      description: 'Peinado con trenzas',
      price: 40,
    ),
  ];

  // ROPA SUPERIOR
  static const List<AvatarPartItem> tops = [
    AvatarPartItem(
      id: 'top_tshirt',
      category: 'top',
      emoji: '👕',
      name: 'Camiseta',
      description: 'Camiseta básica',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'top_blouse',
      category: 'top',
      emoji: '👚',
      name: 'Blusa',
      description: 'Blusa básica',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'top_sweater',
      category: 'top',
      emoji: '🧥',
      name: 'Suéter',
      description: 'Abrigador',
      price: 30,
    ),
    AvatarPartItem(
      id: 'top_hoodie',
      category: 'top',
      emoji: '🦺',
      name: 'Chaqueta',
      description: 'Chaqueta deportiva',
      price: 50,
    ),
    AvatarPartItem(
      id: 'top_suit',
      category: 'top',
      emoji: '🤵',
      name: 'Traje',
      description: 'Formal y elegante',
      price: 80,
    ),
  ];

  // ROPA INFERIOR
  static const List<AvatarPartItem> bottoms = [
    AvatarPartItem(
      id: 'bottom_pants',
      category: 'bottom',
      emoji: '👖',
      name: 'Pantalón',
      description: 'Pantalón básico',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'bottom_dress',
      category: 'bottom',
      emoji: '👗',
      name: 'Vestido',
      description: 'Vestido básico',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'bottom_shorts',
      category: 'bottom',
      emoji: '🩳',
      name: 'Shorts',
      description: 'Pantalón corto',
      price: 20,
    ),
    AvatarPartItem(
      id: 'bottom_skirt',
      category: 'bottom',
      emoji: '🩱',
      name: 'Falda',
      description: 'Falda elegante',
      price: 35,
    ),
  ];

  // ZAPATOS
  static const List<AvatarPartItem> shoes = [
    AvatarPartItem(
      id: 'shoes_sneakers',
      category: 'shoes',
      emoji: '👟',
      name: 'Tenis',
      description: 'Tenis deportivos',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'shoes_boots',
      category: 'shoes',
      emoji: '👢',
      name: 'Botas',
      description: 'Botas resistentes',
      price: 40,
    ),
    AvatarPartItem(
      id: 'shoes_sandals',
      category: 'shoes',
      emoji: '🩴',
      name: 'Sandalias',
      description: 'Frescas y cómodas',
      price: 25,
    ),
    AvatarPartItem(
      id: 'shoes_dress',
      category: 'shoes',
      emoji: '👠',
      name: 'Elegantes',
      description: 'Para ocasiones especiales',
      price: 60,
    ),
  ];

  // ACCESORIOS
  static const List<AvatarPartItem> accessories = [
    AvatarPartItem(
      id: 'acc_none',
      category: 'accessory',
      emoji: 'none',
      name: 'Sin Accesorio',
      description: 'Ningún accesorio',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'acc_glasses',
      category: 'accessory',
      emoji: '👓',
      name: 'Gafas',
      description: 'Gafas de lectura',
      price: 30,
    ),
    AvatarPartItem(
      id: 'acc_sunglasses',
      category: 'accessory',
      emoji: '🕶️',
      name: 'Lentes de Sol',
      description: 'Súper cool',
      price: 50,
    ),
    AvatarPartItem(
      id: 'acc_cap',
      category: 'accessory',
      emoji: '🧢',
      name: 'Gorra',
      description: 'Gorra deportiva',
      price: 35,
    ),
    AvatarPartItem(
      id: 'acc_crown',
      category: 'accessory',
      emoji: '👑',
      name: 'Corona',
      description: '¡Eres un campeón!',
      price: 100,
    ),
    AvatarPartItem(
      id: 'acc_tophat',
      category: 'accessory',
      emoji: '🎩',
      name: 'Sombrero de Copa',
      description: 'Muy elegante',
      price: 70,
    ),
    AvatarPartItem(
      id: 'acc_partyhat',
      category: 'accessory',
      emoji: '🎉',
      name: 'Gorro de Fiesta',
      description: 'Para celebrar',
      price: 40,
    ),
  ];

  // FONDOS
  static const List<AvatarPartItem> backgrounds = [
    AvatarPartItem(
      id: 'bg_white',
      category: 'background',
      emoji: '⬜',
      name: 'Blanco',
      description: 'Fondo blanco simple',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'bg_blue',
      category: 'background',
      emoji: '🟦',
      name: 'Azul',
      description: 'Fondo azul',
      price: 20,
    ),
    AvatarPartItem(
      id: 'bg_green',
      category: 'background',
      emoji: '🟩',
      name: 'Verde',
      description: 'Fondo verde',
      price: 20,
    ),
    AvatarPartItem(
      id: 'bg_red',
      category: 'background',
      emoji: '🟥',
      name: 'Rojo',
      description: 'Fondo rojo',
      price: 20,
    ),
    AvatarPartItem(
      id: 'bg_purple',
      category: 'background',
      emoji: '🟪',
      name: 'Morado',
      description: 'Fondo morado',
      price: 20,
    ),
    AvatarPartItem(
      id: 'bg_orange',
      category: 'background',
      emoji: '🟧',
      name: 'Naranja',
      description: 'Fondo naranja',
      price: 20,
    ),
    AvatarPartItem(
      id: 'bg_stars',
      category: 'background',
      emoji: '✨',
      name: 'Estrellas',
      description: 'Fondo con estrellas',
      price: 50,
    ),
    AvatarPartItem(
      id: 'bg_rainbow',
      category: 'background',
      emoji: '🌈',
      name: 'Arcoíris',
      description: 'Fondo arcoíris',
      price: 80,
    ),
    AvatarPartItem(
      id: 'bg_fire',
      category: 'background',
      emoji: '🔥',
      name: 'Fuego',
      description: 'Fondo de fuego',
      price: 100,
    ),
  ];

  /// Obtiene todas las partes de una categoría
  static List<AvatarPartItem> getPartsByCategory(String category) {
    switch (category) {
      case 'face':
        return faces;
      case 'hair':
        return hairs;
      case 'top':
        return tops;
      case 'bottom':
        return bottoms;
      case 'shoes':
        return shoes;
      case 'accessory':
        return accessories;
      case 'background':
        return backgrounds;
      default:
        return [];
    }
  }

  /// Obtiene una parte por su ID
  static AvatarPartItem? getPartById(String id) {
    final allParts = [
      ...faces,
      ...hairs,
      ...tops,
      ...bottoms,
      ...shoes,
      ...accessories,
      ...backgrounds,
    ];
    try {
      return allParts.firstWhere((part) => part.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Obtiene una parte por emoji
  static AvatarPartItem? getPartByEmoji(String emoji, String category) {
    final parts = getPartsByCategory(category);
    try {
      return parts.firstWhere((part) => part.emoji == emoji);
    } catch (e) {
      return null;
    }
  }

  /// Obtiene todas las categorías disponibles
  static List<String> get categories => [
        'face',
        'hair',
        'top',
        'bottom',
        'shoes',
        'accessory',
        'background',
      ];

  /// Obtiene el nombre en español de una categoría
  static String getCategoryName(String category) {
    switch (category) {
      case 'face':
        return 'Caras';
      case 'hair':
        return 'Peinados';
      case 'top':
        return 'Ropa Superior';
      case 'bottom':
        return 'Ropa Inferior';
      case 'shoes':
        return 'Zapatos';
      case 'accessory':
        return 'Accesorios';
      case 'background':
        return 'Fondos';
      default:
        return category;
    }
  }

  /// Obtiene el icono de una categoría
  static String getCategoryIcon(String category) {
    switch (category) {
      case 'face':
        return '😊';
      case 'hair':
        return '💇';
      case 'top':
        return '👕';
      case 'bottom':
        return '👖';
      case 'shoes':
        return '👟';
      case 'accessory':
        return '👓';
      case 'background':
        return '🎨';
      default:
        return '❓';
    }
  }
}

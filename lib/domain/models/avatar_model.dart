library;

/// Modelo de Avatar
///
/// Representa un avatar personalizable hecho con emojis.
/// Cada parte del avatar puede ser desbloqueada y personalizada.
///
/// Autor: Sistema Educativo
/// Fecha: 2025

class AvatarModel {
  final String userId;
  final String gender; // 'male' o 'female'

  // Partes del avatar (emojis)
  final String face; // Cara base
  final String eyes; // Ojos
  final String mouth; // Boca
  final String hair; // Cabello
  final String top; // Ropa superior
  final String bottom; // Ropa inferior
  final String shoes; // Zapatos
  final String hands; // Manos/guantes
  final String accessory; // Accesorio (gafas, gorro, etc.)
  final String background; // Fondo del avatar

  // Expresiones/animaciones disponibles
  final String currentExpression; // 'neutral', 'happy', 'thinking', 'celebrating', 'jumping', etc.

  // Partes desbloqueadas por el usuario
  final List<String> unlockedFaces;
  final List<String> unlockedEyes;
  final List<String> unlockedMouths;
  final List<String> unlockedHairs;
  final List<String> unlockedTops;
  final List<String> unlockedBottoms;
  final List<String> unlockedShoes;
  final List<String> unlockedHands;
  final List<String> unlockedAccessories;
  final List<String> unlockedBackgrounds;

  const AvatarModel({
    required this.userId,
    required this.gender,
    required this.face,
    required this.eyes,
    required this.mouth,
    required this.hair,
    required this.top,
    required this.bottom,
    required this.shoes,
    required this.hands,
    required this.accessory,
    required this.background,
    this.currentExpression = 'neutral',
    this.unlockedFaces = const [],
    this.unlockedEyes = const [],
    this.unlockedMouths = const [],
    this.unlockedHairs = const [],
    this.unlockedTops = const [],
    this.unlockedBottoms = const [],
    this.unlockedShoes = const [],
    this.unlockedHands = const [],
    this.unlockedAccessories = const [],
    this.unlockedBackgrounds = const [],
  });

  /// Crea un avatar básico para un nuevo usuario
  factory AvatarModel.defaultMale(String userId) {
    return AvatarModel(
      userId: userId,
      gender: 'male',
      face: '😊',
      eyes: '👀',
      mouth: '😃',
      hair: '🦱', // Pelo rizado
      top: '👕', // Camiseta básica
      bottom: '👖', // Pantalón
      shoes: '👟', // Tenis
      hands: '👋', // Manos normales
      accessory: 'none',
      background: '⬜',
      unlockedFaces: ['😊', '😃', '🙂'],
      unlockedEyes: ['👀'],
      unlockedMouths: ['😃', '🙂'],
      unlockedHairs: ['🦱'],
      unlockedTops: ['👕'],
      unlockedBottoms: ['👖'],
      unlockedShoes: ['👟'],
      unlockedHands: ['👋'],
      unlockedAccessories: ['none'],
      unlockedBackgrounds: ['⬜'],
    );
  }

  factory AvatarModel.defaultFemale(String userId) {
    return AvatarModel(
      userId: userId,
      gender: 'female',
      face: '😊',
      eyes: '👀',
      mouth: '😃',
      hair: '👧', // Pelo largo
      top: '👚', // Blusa básica
      bottom: '👗', // Vestido/falda
      shoes: '👟', // Tenis
      hands: '👋', // Manos normales
      accessory: 'none',
      background: '⬜',
      unlockedFaces: ['😊', '😃', '🙂'],
      unlockedEyes: ['👀'],
      unlockedMouths: ['😃', '🙂'],
      unlockedHairs: ['👧'],
      unlockedTops: ['👚'],
      unlockedBottoms: ['👗'],
      unlockedShoes: ['👟'],
      unlockedHands: ['👋'],
      unlockedAccessories: ['none'],
      unlockedBackgrounds: ['⬜'],
    );
  }

  /// Convierte el modelo a Map para Firebase
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'gender': gender,
      'face': face,
      'eyes': eyes,
      'mouth': mouth,
      'hair': hair,
      'top': top,
      'bottom': bottom,
      'shoes': shoes,
      'hands': hands,
      'accessory': accessory,
      'background': background,
      'currentExpression': currentExpression,
      'unlockedFaces': unlockedFaces,
      'unlockedEyes': unlockedEyes,
      'unlockedMouths': unlockedMouths,
      'unlockedHairs': unlockedHairs,
      'unlockedTops': unlockedTops,
      'unlockedBottoms': unlockedBottoms,
      'unlockedShoes': unlockedShoes,
      'unlockedHands': unlockedHands,
      'unlockedAccessories': unlockedAccessories,
      'unlockedBackgrounds': unlockedBackgrounds,
    };
  }

  /// Crea un modelo desde Map de Firebase
  factory AvatarModel.fromMap(Map<String, dynamic> map) {
    return AvatarModel(
      userId: map['userId'] as String? ?? '',
      gender: map['gender'] as String? ?? 'male',
      face: map['face'] as String? ?? '😊',
      eyes: map['eyes'] as String? ?? '👀',
      mouth: map['mouth'] as String? ?? '😃',
      hair: map['hair'] as String? ?? '🦱',
      top: map['top'] as String? ?? '👕',
      bottom: map['bottom'] as String? ?? '👖',
      shoes: map['shoes'] as String? ?? '👟',
      hands: map['hands'] as String? ?? '👋',
      accessory: map['accessory'] as String? ?? 'none',
      background: map['background'] as String? ?? '⬜',
      currentExpression: map['currentExpression'] as String? ?? 'neutral',
      unlockedFaces: map['unlockedFaces'] != null
          ? List<String>.from(map['unlockedFaces'] as List)
          : ['😊', '😃', '🙂'],
      unlockedEyes: map['unlockedEyes'] != null
          ? List<String>.from(map['unlockedEyes'] as List)
          : ['👀'],
      unlockedMouths: map['unlockedMouths'] != null
          ? List<String>.from(map['unlockedMouths'] as List)
          : ['😃', '🙂'],
      unlockedHairs: map['unlockedHairs'] != null
          ? List<String>.from(map['unlockedHairs'] as List)
          : ['🦱'],
      unlockedTops: map['unlockedTops'] != null
          ? List<String>.from(map['unlockedTops'] as List)
          : ['👕'],
      unlockedBottoms: map['unlockedBottoms'] != null
          ? List<String>.from(map['unlockedBottoms'] as List)
          : ['👖'],
      unlockedShoes: map['unlockedShoes'] != null
          ? List<String>.from(map['unlockedShoes'] as List)
          : ['👟'],
      unlockedHands: map['unlockedHands'] != null
          ? List<String>.from(map['unlockedHands'] as List)
          : ['👋'],
      unlockedAccessories: map['unlockedAccessories'] != null
          ? List<String>.from(map['unlockedAccessories'] as List)
          : ['none'],
      unlockedBackgrounds: map['unlockedBackgrounds'] != null
          ? List<String>.from(map['unlockedBackgrounds'] as List)
          : ['⬜'],
    );
  }

  /// Copia el avatar con cambios
  AvatarModel copyWith({
    String? userId,
    String? gender,
    String? face,
    String? eyes,
    String? mouth,
    String? hair,
    String? top,
    String? bottom,
    String? shoes,
    String? hands,
    String? accessory,
    String? background,
    String? currentExpression,
    List<String>? unlockedFaces,
    List<String>? unlockedEyes,
    List<String>? unlockedMouths,
    List<String>? unlockedHairs,
    List<String>? unlockedTops,
    List<String>? unlockedBottoms,
    List<String>? unlockedShoes,
    List<String>? unlockedHands,
    List<String>? unlockedAccessories,
    List<String>? unlockedBackgrounds,
  }) {
    return AvatarModel(
      userId: userId ?? this.userId,
      gender: gender ?? this.gender,
      face: face ?? this.face,
      eyes: eyes ?? this.eyes,
      mouth: mouth ?? this.mouth,
      hair: hair ?? this.hair,
      top: top ?? this.top,
      bottom: bottom ?? this.bottom,
      shoes: shoes ?? this.shoes,
      hands: hands ?? this.hands,
      accessory: accessory ?? this.accessory,
      background: background ?? this.background,
      currentExpression: currentExpression ?? this.currentExpression,
      unlockedFaces: unlockedFaces ?? this.unlockedFaces,
      unlockedEyes: unlockedEyes ?? this.unlockedEyes,
      unlockedMouths: unlockedMouths ?? this.unlockedMouths,
      unlockedHairs: unlockedHairs ?? this.unlockedHairs,
      unlockedTops: unlockedTops ?? this.unlockedTops,
      unlockedBottoms: unlockedBottoms ?? this.unlockedBottoms,
      unlockedShoes: unlockedShoes ?? this.unlockedShoes,
      unlockedHands: unlockedHands ?? this.unlockedHands,
      unlockedAccessories: unlockedAccessories ?? this.unlockedAccessories,
      unlockedBackgrounds: unlockedBackgrounds ?? this.unlockedBackgrounds,
    );
  }
}

/// Catálogo de partes de avatar disponibles para comprar
class AvatarPartItem {
  final String id;
  final String category; // 'face', 'hair', 'top', 'bottom', 'shoes', 'accessory', 'background'
  final String emoji;
  final String name;
  final String description;
  final int price; // Precio en monedas
  final bool isDefault; // Si viene desbloqueado por defecto

  const AvatarPartItem({
    required this.id,
    required this.category,
    required this.emoji,
    required this.name,
    required this.description,
    required this.price,
    this.isDefault = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'emoji': emoji,
      'name': name,
      'description': description,
      'price': price,
      'isDefault': isDefault,
    };
  }

  factory AvatarPartItem.fromMap(Map<String, dynamic> map) {
    return AvatarPartItem(
      id: map['id'] as String,
      category: map['category'] as String,
      emoji: map['emoji'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      isDefault: map['isDefault'] as bool? ?? false,
    );
  }
}

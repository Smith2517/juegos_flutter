library;

/// Catálogo de Partes de Avatar
///
/// Define todas las piezas disponibles para personalizar el avatar. Cada
/// elemento apunta a un asset SVG que se renderiza en capas dentro del
/// widget de avatar.

import '../../domain/models/avatar_part_item.dart';

class AvatarCatalog {
  // BASES DE PIEL / CARA
  static const List<AvatarPartItem> faces = [
    AvatarPartItem(
      id: 'face_skin_light',
      category: 'face',
      assetPath: 'assets/avatar/face/skin_light.svg',
      emoji: '😊',
      name: 'Piel clara',
      description: 'Tono de piel claro neutro',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'face_skin_warm',
      category: 'face',
      assetPath: 'assets/avatar/face/skin_warm.svg',
      emoji: '🙂',
      name: 'Piel cálida',
      description: 'Tono de piel cálido',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'face_skin_dark',
      category: 'face',
      assetPath: 'assets/avatar/face/skin_dark.svg',
      emoji: '😌',
      name: 'Piel oscura',
      description: 'Tono de piel oscuro',
      price: 0,
      isDefault: true,
    ),
  ];

  // OJOS
  static const List<AvatarPartItem> eyes = [
    AvatarPartItem(
      id: 'eyes_round_brown',
      category: 'eyes',
      assetPath: 'assets/avatar/eyes/round_brown.svg',
      emoji: '👀',
      name: 'Ojos café',
      description: 'Ojos redondos color café',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'eyes_round_hazel',
      category: 'eyes',
      assetPath: 'assets/avatar/eyes/round_hazel.svg',
      emoji: '👁️',
      name: 'Ojos miel',
      description: 'Iris color miel',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'eyes_round_blue',
      category: 'eyes',
      assetPath: 'assets/avatar/eyes/round_blue.svg',
      emoji: '🌊',
      name: 'Ojos azules',
      description: 'Iris azul brillante',
      price: 50,
    ),
    AvatarPartItem(
      id: 'eyes_round_green',
      category: 'eyes',
      assetPath: 'assets/avatar/eyes/round_green.svg',
      emoji: '🟢',
      name: 'Ojos verdes',
      description: 'Mirada esmeralda',
      price: 50,
    ),
  ];

  // BOCAS
  static const List<AvatarPartItem> mouths = [
    AvatarPartItem(
      id: 'mouth_smile',
      category: 'mouth',
      assetPath: 'assets/avatar/mouth/smile.svg',
      emoji: '😃',
      name: 'Sonrisa alegre',
      description: 'Sonrisa amigable',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'mouth_grin',
      category: 'mouth',
      assetPath: 'assets/avatar/mouth/grin.svg',
      emoji: '😁',
      name: 'Sonrisa grande',
      description: 'Sonrisa con mucha energía',
      price: 40,
    ),
    AvatarPartItem(
      id: 'mouth_shy',
      category: 'mouth',
      assetPath: 'assets/avatar/mouth/shy.svg',
      emoji: '😊',
      name: 'Sonrisa tímida',
      description: 'Perfecta para momentos tranquilos',
      price: 35,
    ),
  ];

  // CABELLOS
  static const List<AvatarPartItem> hairs = [
    AvatarPartItem(
      id: 'hair_curly_dark',
      category: 'hair',
      assetPath: 'assets/avatar/hair/curly_dark.svg',
      emoji: '🦱',
      name: 'Rizado oscuro',
      description: 'Cabello rizado con volumen',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'hair_long_brown',
      category: 'hair',
      assetPath: 'assets/avatar/hair/long_brown.svg',
      emoji: '👧',
      name: 'Largo castaño',
      description: 'Cabello largo y sedoso',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'hair_short_blonde',
      category: 'hair',
      assetPath: 'assets/avatar/hair/short_blonde.svg',
      emoji: '👱',
      name: 'Corto rubio',
      description: 'Look moderno y fresco',
      price: 45,
    ),
    AvatarPartItem(
      id: 'hair_afro',
      category: 'hair',
      assetPath: 'assets/avatar/hair/afro.svg',
      emoji: '🧑🏾‍🦱',
      name: 'Afro',
      description: 'Estilo afro con personalidad',
      price: 60,
    ),
  ];

  // ROPA SUPERIOR
  static const List<AvatarPartItem> tops = [
    AvatarPartItem(
      id: 'top_tshirt_blue',
      category: 'top',
      assetPath: 'assets/avatar/top/tshirt_blue.svg',
      emoji: '👕',
      name: 'Camiseta azul',
      description: 'Camiseta deportiva azul',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'top_blouse_magenta',
      category: 'top',
      assetPath: 'assets/avatar/top/blouse_magenta.svg',
      emoji: '👚',
      name: 'Blusa magenta',
      description: 'Blusa elegante y cómoda',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'top_hoodie_green',
      category: 'top',
      assetPath: 'assets/avatar/top/hoodie_green.svg',
      emoji: '🧥',
      name: 'Sudadera verde',
      description: 'Perfecta para aventuras',
      price: 55,
    ),
    AvatarPartItem(
      id: 'top_jacket_orange',
      category: 'top',
      assetPath: 'assets/avatar/top/jacket_orange.svg',
      emoji: '🦺',
      name: 'Chaqueta naranja',
      description: 'Con detalles reflectantes',
      price: 70,
    ),
  ];

  // ROPA INFERIOR
  static const List<AvatarPartItem> bottoms = [
    AvatarPartItem(
      id: 'bottom_jeans_dark',
      category: 'bottom',
      assetPath: 'assets/avatar/bottom/jeans_dark.svg',
      emoji: '👖',
      name: 'Jeans oscuros',
      description: 'Pantalón de mezclilla',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'bottom_skirt_teal',
      category: 'bottom',
      assetPath: 'assets/avatar/bottom/skirt_teal.svg',
      emoji: '👗',
      name: 'Falda verde',
      description: 'Falda con vuelo',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'bottom_shorts_red',
      category: 'bottom',
      assetPath: 'assets/avatar/bottom/shorts_red.svg',
      emoji: '🩳',
      name: 'Shorts rojos',
      description: 'Para entrenar o jugar',
      price: 35,
    ),
  ];

  // ZAPATOS
  static const List<AvatarPartItem> shoes = [
    AvatarPartItem(
      id: 'shoes_sneakers_blue',
      category: 'shoes',
      assetPath: 'assets/avatar/shoes/sneakers_blue.svg',
      emoji: '👟',
      name: 'Tenis azules',
      description: 'Tenis deportivos',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'shoes_sneakers_pink',
      category: 'shoes',
      assetPath: 'assets/avatar/shoes/sneakers_pink.svg',
      emoji: '👟',
      name: 'Tenis rosa',
      description: 'Tenis para combinar con todo',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'shoes_boots_brown',
      category: 'shoes',
      assetPath: 'assets/avatar/shoes/boots_brown.svg',
      emoji: '👢',
      name: 'Botas cafés',
      description: 'Listas para explorar',
      price: 45,
    ),
  ];

  // MANOS / GUANTES
  static const List<AvatarPartItem> hands = [
    AvatarPartItem(
      id: 'hands_default_light',
      category: 'hands',
      assetPath: 'assets/avatar/hands/hands_light.svg',
      emoji: '👋',
      name: 'Manos claras',
      description: 'Manos tono claro',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'hands_default_warm',
      category: 'hands',
      assetPath: 'assets/avatar/hands/hands_warm.svg',
      emoji: '✋',
      name: 'Manos cálidas',
      description: 'Tono medio cálido',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'hands_default_dark',
      category: 'hands',
      assetPath: 'assets/avatar/hands/hands_dark.svg',
      emoji: '🤚🏾',
      name: 'Manos oscuras',
      description: 'Tono oscuro',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'hands_gloves_space',
      category: 'hands',
      assetPath: 'assets/avatar/hands/gloves_space.svg',
      emoji: '🧤',
      name: 'Guantes espaciales',
      description: 'Guantes para misiones espaciales',
      price: 60,
    ),
  ];

  // ACCESORIOS
  static const List<AvatarPartItem> accessories = [
    AvatarPartItem(
      id: 'acc_none',
      category: 'accessory',
      assetPath: 'assets/avatar/accessories/none.svg',
      emoji: 'none',
      name: 'Sin accesorio',
      description: 'Sin accesorios adicionales',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'acc_glasses_round',
      category: 'accessory',
      assetPath: 'assets/avatar/accessories/glasses_round.svg',
      emoji: '👓',
      name: 'Gafas redondas',
      description: 'Perfectas para estudiar',
      price: 45,
    ),
    AvatarPartItem(
      id: 'acc_headphones',
      category: 'accessory',
      assetPath: 'assets/avatar/accessories/headphones.svg',
      emoji: '🎧',
      name: 'Audífonos',
      description: 'Para escuchar música educativa',
      price: 65,
    ),
    AvatarPartItem(
      id: 'acc_cap_blue',
      category: 'accessory',
      assetPath: 'assets/avatar/accessories/cap_blue.svg',
      emoji: '🧢',
      name: 'Gorra azul',
      description: 'Estilo deportivo',
      price: 40,
    ),
  ];

  // FONDOS
  static const List<AvatarPartItem> backgrounds = [
    AvatarPartItem(
      id: 'bg_classroom',
      category: 'background',
      assetPath: 'assets/avatar/backgrounds/classroom.svg',
      emoji: '⬜',
      name: 'Salón de clases',
      description: 'Fondo neutro de aula',
      price: 0,
      isDefault: true,
    ),
    AvatarPartItem(
      id: 'bg_library',
      category: 'background',
      assetPath: 'assets/avatar/backgrounds/library.svg',
      emoji: '📚',
      name: 'Biblioteca',
      description: 'Fondo con libros y conocimiento',
      price: 40,
    ),
    AvatarPartItem(
      id: 'bg_science_lab',
      category: 'background',
      assetPath: 'assets/avatar/backgrounds/science_lab.svg',
      emoji: '🧪',
      name: 'Laboratorio',
      description: 'Ideal para experimentos',
      price: 60,
    ),
    AvatarPartItem(
      id: 'bg_space',
      category: 'background',
      assetPath: 'assets/avatar/backgrounds/space.svg',
      emoji: '🌌',
      name: 'Espacio',
      description: 'Aprende entre las estrellas',
      price: 80,
    ),
  ];

  /// Obtiene todas las partes de una categoría
  static List<AvatarPartItem> getPartsByCategory(String category) {
    switch (category) {
      case 'face':
        return faces;
      case 'eyes':
        return eyes;
      case 'mouth':
        return mouths;
      case 'hair':
        return hairs;
      case 'top':
        return tops;
      case 'bottom':
        return bottoms;
      case 'shoes':
        return shoes;
      case 'hands':
        return hands;
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
    for (final part in _allParts) {
      if (part.id == id) {
        return part;
      }
    }
    return null;
  }

  /// Obtiene una parte por emoji (compatibilidad con datos antiguos)
  static AvatarPartItem? getPartByEmoji(String? emoji, String category) {
    if (emoji == null) return null;
    for (final part in getPartsByCategory(category)) {
      if (part.emoji == emoji) {
        return part;
      }
    }
    return null;
  }

  /// Obtiene una parte por ruta de asset
  static AvatarPartItem? getPartByAsset(String? assetPath, String category) {
    if (assetPath == null) return null;
    for (final part in getPartsByCategory(category)) {
      if (part.assetPath == assetPath) {
        return part;
      }
    }
    return null;
  }

  /// Resuelve cualquier valor almacenado (emoji antiguo, id o ruta) a un ID válido
  static String resolvePartId(
    String? rawValue, {
    required String category,
    required String fallbackId,
  }) {
    if (rawValue == null || rawValue.isEmpty) {
      return fallbackId;
    }

    if (category == 'accessory' && rawValue == 'none') {
      return 'acc_none';
    }

    final byId = getPartById(rawValue);
    if (byId != null && byId.category == category) {
      return byId.id;
    }

    final byEmoji = getPartByEmoji(rawValue, category);
    if (byEmoji != null) {
      return byEmoji.id;
    }

    final byAsset = getPartByAsset(rawValue, category);
    if (byAsset != null) {
      return byAsset.id;
    }

    return fallbackId;
  }

  /// Retorna la lista de IDs desbloqueados por defecto para la categoría
  static List<String> getDefaultUnlockedIds(String category) {
    return getPartsByCategory(category)
        .where((part) => part.isDefault)
        .map((part) => part.id)
        .toList();
  }

  /// Obtiene todas las categorías disponibles
  static List<String> get categories => [
        'face',
        'eyes',
        'mouth',
        'hair',
        'top',
        'bottom',
        'shoes',
        'hands',
        'accessory',
        'background',
      ];

  /// Obtiene el nombre en español de una categoría
  static String getCategoryName(String category) {
    switch (category) {
      case 'face':
        return 'Piel';
      case 'eyes':
        return 'Ojos';
      case 'mouth':
        return 'Bocas';
      case 'hair':
        return 'Peinados';
      case 'top':
        return 'Ropa Superior';
      case 'bottom':
        return 'Ropa Inferior';
      case 'shoes':
        return 'Zapatos';
      case 'hands':
        return 'Manos';
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
      case 'eyes':
        return '👀';
      case 'mouth':
        return '😄';
      case 'hair':
        return '💇';
      case 'top':
        return '👕';
      case 'bottom':
        return '👖';
      case 'shoes':
        return '👟';
      case 'hands':
        return '🖐️';
      case 'accessory':
        return '🎩';
      case 'background':
        return '🎨';
      default:
        return '❓';
    }
  }

  static List<AvatarPartItem> get _allParts => [
        ...faces,
        ...eyes,
        ...mouths,
        ...hairs,
        ...tops,
        ...bottoms,
        ...shoes,
        ...hands,
        ...accessories,
        ...backgrounds,
      ];
}

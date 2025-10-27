/// Elemento del catálogo de avatares.
///
/// Define una pieza intercambiable que puede formar parte del avatar.
/// Cada pieza apunta a un recurso gráfico (SVG/PNG) para renderizar
/// texturas y estilos detallados. Se conserva un campo `emoji` opcional
/// únicamente para compatibilidad con datos antiguos almacenados en
/// Firebase.
class AvatarPartItem {
  final String id;
  final String category; // face, eyes, mouth, hair, top, bottom, shoes, hands, accessory, background
  final String assetPath; // Ruta del asset a renderizar
  final String name;
  final String description;
  final int price; // Precio en monedas dentro del juego
  final bool isDefault; // Indica si viene desbloqueado por defecto
  final String? emoji; // Compatibilidad hacia atrás

  const AvatarPartItem({
    required this.id,
    required this.category,
    required this.assetPath,
    required this.name,
    required this.description,
    required this.price,
    this.isDefault = false,
    this.emoji,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'assetPath': assetPath,
      'name': name,
      'description': description,
      'price': price,
      'isDefault': isDefault,
      if (emoji != null) 'emoji': emoji,
    };
  }

  factory AvatarPartItem.fromMap(Map<String, dynamic> map) {
    return AvatarPartItem(
      id: map['id'] as String,
      category: map['category'] as String,
      assetPath: map['assetPath'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      isDefault: map['isDefault'] as bool? ?? false,
      emoji: map['emoji'] as String?,
    );
  }
}

library;

/// Widget de Avatar Animado
///
/// Renderiza un avatar personalizado con emojis y animaciones.
/// Soporta múltiples expresiones y animaciones.
///
/// Autor: Sistema Educativo
/// Fecha: 2025

import 'package:flutter/material.dart';
import '../../domain/models/avatar_model.dart';

class AvatarWidget extends StatefulWidget {
  final AvatarModel avatar;
  final double size;
  final String? expression; // Sobrescribe la expresión del modelo si se proporciona
  final bool animate;

  const AvatarWidget({
    super.key,
    required this.avatar,
    this.size = 120,
    this.expression,
    this.animate = false,
  });

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _bounceAnimation = Tween<double>(begin: 0.0, end: -10.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    if (widget.animate) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Obtiene la expresión facial según el tipo de expresión
  String _getExpressionFace(String expression) {
    switch (expression) {
      case 'happy':
      case 'celebrating':
        return '😄';
      case 'thinking':
        return '🤔';
      case 'excited':
        return '🤩';
      case 'cool':
        return '😎';
      case 'surprised':
        return '😲';
      case 'confused':
        return '😕';
      case 'sad':
        return '😢';
      case 'tired':
        return '😴';
      case 'angry':
        return '😠';
      case 'jumping':
      case 'running':
        return '😃';
      case 'neutral':
      default:
        return widget.avatar.face;
    }
  }

  /// Obtiene el contenido extra según la expresión (efectos)
  Widget? _getExpressionEffect(String expression) {
    switch (expression) {
      case 'celebrating':
        return Positioned(
          top: -10,
          right: -10,
          child: Text(
            '🎉',
            style: TextStyle(fontSize: widget.size * 0.4),
          ),
        );
      case 'thinking':
        return Positioned(
          top: -5,
          right: -5,
          child: Text(
            '💭',
            style: TextStyle(fontSize: widget.size * 0.3),
          ),
        );
      case 'excited':
        return Positioned(
          top: -10,
          left: -10,
          child: Text(
            '✨',
            style: TextStyle(fontSize: widget.size * 0.3),
          ),
        );
      case 'jumping':
        return Positioned(
          bottom: -5,
          child: Text(
            '💨',
            style: TextStyle(fontSize: widget.size * 0.25),
          ),
        );
      case 'running':
        return Positioned(
          right: -10,
          bottom: widget.size * 0.3,
          child: Text(
            '💨💨',
            style: TextStyle(fontSize: widget.size * 0.2),
          ),
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final expression = widget.expression ?? widget.avatar.currentExpression;
    final face = _getExpressionFace(expression);
    final effect = _getExpressionEffect(expression);

    Widget avatarContent = _buildAvatarStack(face);

    // Aplicar animación de bouncing para expresiones de salto
    if (expression == 'jumping' || expression == 'celebrating') {
      avatarContent = AnimatedBuilder(
        animation: _bounceAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _bounceAnimation.value),
            child: child,
          );
        },
        child: avatarContent,
      );
    }

    // Aplicar animación de escala
    if (widget.animate) {
      avatarContent = ScaleTransition(
        scale: _scaleAnimation,
        child: avatarContent,
      );
    }

    // Aplicar efecto de expresión
    if (effect != null) {
      avatarContent = Stack(
        clipBehavior: Clip.none,
        children: [
          avatarContent,
          effect,
        ],
      );
    }

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: avatarContent,
    );
  }

  Widget _buildAvatarStack(String face) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SECCIÓN SUPERIOR: Cabello y Accesorio
          SizedBox(
            height: widget.size * 0.15,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Cabello
                if (widget.avatar.hair != 'none')
                  Text(
                    widget.avatar.hair,
                    style: TextStyle(fontSize: widget.size * 0.15),
                  ),
                // Accesorio encima del cabello
                if (widget.avatar.accessory != 'none')
                  Positioned(
                    top: 0,
                    child: Text(
                      widget.avatar.accessory,
                      style: TextStyle(fontSize: widget.size * 0.12),
                    ),
                  ),
              ],
            ),
          ),

          // SECCIÓN CABEZA: Cara
          SizedBox(
            height: widget.size * 0.25,
            child: Text(
              face,
              style: TextStyle(fontSize: widget.size * 0.22),
            ),
          ),

          // SECCIÓN TORSO: Ropa superior con brazos
          SizedBox(
            height: widget.size * 0.25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brazo izquierdo
                if (widget.avatar.hands != 'none')
                  Transform.rotate(
                    angle: -0.3,
                    child: Text(
                      widget.avatar.hands,
                      style: TextStyle(fontSize: widget.size * 0.10),
                    ),
                  ),

                const SizedBox(width: 4),

                // Torso (ropa superior)
                Text(
                  widget.avatar.top,
                  style: TextStyle(fontSize: widget.size * 0.20),
                ),

                const SizedBox(width: 4),

                // Brazo derecho
                if (widget.avatar.hands != 'none')
                  Transform.rotate(
                    angle: 0.3,
                    child: Text(
                      widget.avatar.hands,
                      style: TextStyle(fontSize: widget.size * 0.10),
                    ),
                  ),
              ],
            ),
          ),

          // SECCIÓN PIERNAS: Ropa inferior
          SizedBox(
            height: widget.size * 0.20,
            child: Text(
              widget.avatar.bottom,
              style: TextStyle(fontSize: widget.size * 0.18),
            ),
          ),

          // SECCIÓN PIES: Zapatos
          SizedBox(
            height: widget.size * 0.15,
            child: Text(
              widget.avatar.shoes,
              style: TextStyle(fontSize: widget.size * 0.14),
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    // Mapeo de emojis de fondo a colores
    switch (widget.avatar.background) {
      case '🟦':
        return Colors.blue.shade100;
      case '🟩':
        return Colors.green.shade100;
      case '🟥':
        return Colors.red.shade100;
      case '🟪':
        return Colors.purple.shade100;
      case '🟧':
        return Colors.orange.shade100;
      case '✨':
        return Colors.yellow.shade100;
      case '🌈':
        return Colors.pink.shade100;
      case '🔥':
        return Colors.deepOrange.shade100;
      case '⬜':
      default:
        return Colors.grey.shade100;
    }
  }
}

/// Widget de Avatar Simple (sin animaciones, para listas)
class SimpleAvatarWidget extends StatelessWidget {
  final AvatarModel avatar;
  final double size;

  const SimpleAvatarWidget({
    super.key,
    required this.avatar,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          avatar.face,
          style: TextStyle(fontSize: size * 0.5),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (avatar.background) {
      case '🟦':
        return Colors.blue.shade100;
      case '🟩':
        return Colors.green.shade100;
      case '🟥':
        return Colors.red.shade100;
      case '🟪':
        return Colors.purple.shade100;
      case '🟧':
        return Colors.orange.shade100;
      case '✨':
        return Colors.yellow.shade100;
      case '🌈':
        return Colors.pink.shade100;
      case '🔥':
        return Colors.deepOrange.shade100;
      case '⬜':
      default:
        return Colors.grey.shade100;
    }
  }
}

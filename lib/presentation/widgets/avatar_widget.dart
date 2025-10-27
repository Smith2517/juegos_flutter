library;

/// Widget de Avatar Animado
///
/// Renderiza un avatar personalizado con emojis y animaciones.
/// Soporta múltiples expresiones y animaciones.
///
/// Autor: Sistema Educativo
/// Fecha: 2025

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/config/avatar_catalog.dart';
import '../../domain/models/avatar_model.dart';
import '../../domain/models/avatar_part_item.dart';

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

  /// Determina si se debe usar una variación de ojos según la expresión.
  String _resolveEyesForExpression(String expression) {
    switch (expression) {
      case 'excited':
        return 'eyes_round_blue';
      case 'cool':
        return 'eyes_round_green';
      case 'thinking':
        return widget.avatar.eyes;
      case 'surprised':
        return 'eyes_round_green';
      default:
        return widget.avatar.eyes;
    }
  }

  /// Determina si se debe usar una variación de boca según la expresión.
  String _resolveMouthForExpression(String expression) {
    switch (expression) {
      case 'happy':
      case 'celebrating':
      case 'jumping':
      case 'running':
        return 'mouth_grin';
      case 'thinking':
      case 'confused':
        return 'mouth_shy';
      case 'sad':
      case 'tired':
        return 'mouth_shy';
      default:
        return widget.avatar.mouth;
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
    final effect = _getExpressionEffect(expression);

    Widget avatarContent = _buildAvatarStack(expression);

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
      height: widget.size * 1.4,
      child: avatarContent,
    );
  }

  Widget _buildAvatarStack(String expression) {
    final background = AvatarCatalog.getPartById(widget.avatar.background);
    final face = AvatarCatalog.getPartById(widget.avatar.face);
    final eyes = AvatarCatalog.getPartById(_resolveEyesForExpression(expression));
    final mouth = AvatarCatalog.getPartById(_resolveMouthForExpression(expression));
    final hair = AvatarCatalog.getPartById(widget.avatar.hair);
    final accessory = AvatarCatalog.getPartById(widget.avatar.accessory);
    final top = AvatarCatalog.getPartById(widget.avatar.top);
    final hands = AvatarCatalog.getPartById(widget.avatar.hands);
    final bottom = AvatarCatalog.getPartById(widget.avatar.bottom);
    final shoes = AvatarCatalog.getPartById(widget.avatar.shoes);

    final double width = widget.size;
    final double height = widget.size * 1.4;

    final children = <Widget>[
      if (background != null && background.assetPath.isNotEmpty)
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SvgPicture.asset(
              background.assetPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
    ];

    void addLayer(
      AvatarPartItem? part, {
      required double top,
      required double widthFactor,
    }) {
      if (part == null || part.assetPath.isEmpty) {
        return;
      }

      final double layerWidth = width * widthFactor;
      final double aspectRatio = _aspectRatioForPart(part);
      final double layerHeight =
          aspectRatio == 0 ? layerWidth : layerWidth / aspectRatio;

      children.add(
        Positioned(
          top: top,
          left: (width - layerWidth) / 2,
          width: layerWidth,
          height: layerHeight,
          child: _buildSvg(
            part,
            width: layerWidth,
            height: layerHeight,
          ),
        ),
      );
    }

    addLayer(hair, top: width * 0.05, widthFactor: 0.76);
    addLayer(bottom, top: width * 0.95, widthFactor: 0.44);
    addLayer(shoes, top: width * 1.12, widthFactor: 0.52);
    addLayer(top, top: width * 0.82, widthFactor: 0.52);
    addLayer(hands, top: width * 0.88, widthFactor: 0.7);
    addLayer(face, top: width * 0.3, widthFactor: 0.64);
    addLayer(mouth, top: width * 0.72, widthFactor: 0.36);
    addLayer(eyes, top: width * 0.52, widthFactor: 0.5);
    addLayer(accessory, top: width * 0.26, widthFactor: 0.6);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: _resolveBackgroundColor(background),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: children,
      ),
    );
  }

  Widget _buildSvg(
    AvatarPartItem? part, {
    double? width,
    double? height,
  }) {
    if (part == null || part.assetPath.isEmpty) {
      return const SizedBox.shrink();
    }

    return SvgPicture.asset(
      part.assetPath,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }

  double _aspectRatioForPart(AvatarPartItem? part) {
    if (part == null) {
      return 1.0;
    }

    switch (part.category) {
      case 'hair':
        return 220 / 160;
      case 'accessory':
        return 220 / 140;
      case 'eyes':
        return 200 / 120;
      case 'mouth':
        return 200 / 120;
      case 'top':
        return 240 / 210;
      case 'hands':
        return 240 / 160;
      case 'bottom':
        return 1.0;
      case 'shoes':
        return 240 / 120;
      case 'face':
      default:
        return 1.0;
    }
  }

  Color _resolveBackgroundColor(AvatarPartItem? background) {
    switch (background?.id) {
      case 'bg_library':
        return Colors.amber.shade100;
      case 'bg_science_lab':
        return Colors.lightBlue.shade100;
      case 'bg_space':
        return Colors.deepPurple.shade200;
      case 'bg_classroom':
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
    final background = AvatarCatalog.getPartById(avatar.background);
    final face = AvatarCatalog.getPartById(avatar.face);
    final eyes = AvatarCatalog.getPartById(avatar.eyes);
    final mouth = AvatarCatalog.getPartById(avatar.mouth);
    final hair = AvatarCatalog.getPartById(avatar.hair);
    final accessory = AvatarCatalog.getPartById(avatar.accessory);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _backgroundColor(background),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (background != null && background.assetPath.isNotEmpty)
              SvgPicture.asset(
                background.assetPath,
                fit: BoxFit.cover,
              ),
            Align(
              alignment: Alignment.topCenter,
              child: _buildCompactSvg(hair, size * 0.7),
            ),
            Align(
              alignment: Alignment.center,
              child: _buildCompactSvg(face, size * 0.75),
            ),
            Align(
              alignment: Alignment.center,
              child: _buildCompactSvg(eyes, size * 0.45),
            ),
            Align(
              alignment: Alignment(0, 0.4),
              child: _buildCompactSvg(mouth, size * 0.35),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: _buildCompactSvg(accessory, size * 0.6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactSvg(AvatarPartItem? part, double size) {
    if (part == null || part.assetPath.isEmpty) {
      return const SizedBox.shrink();
    }

    return SvgPicture.asset(
      part.assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }

  Color _backgroundColor(AvatarPartItem? background) {
    switch (background?.id) {
      case 'bg_library':
        return Colors.amber.shade100;
      case 'bg_science_lab':
        return Colors.lightBlue.shade100;
      case 'bg_space':
        return Colors.deepPurple.shade200;
      case 'bg_classroom':
      default:
        return Colors.grey.shade100;
    }
  }
}

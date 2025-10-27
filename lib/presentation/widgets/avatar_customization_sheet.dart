/// Sheet de Personalización de Avatar
///
/// Permite al usuario cambiar las partes de su avatar
/// usando solo las partes que ha desbloqueado.
///
/// Autor: Sistema Educativo
/// Fecha: 2025

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/config/avatar_catalog.dart';
import '../../app/theme/colors.dart';
import '../../domain/models/avatar_model.dart';
import '../../domain/models/avatar_part_item.dart';
import '../../domain/services/avatar_service.dart';
import 'avatar_widget.dart';

class AvatarCustomizationSheet extends StatefulWidget {
  final AvatarModel avatar;
  final String userId;

  const AvatarCustomizationSheet({
    super.key,
    required this.avatar,
    required this.userId,
  });

  @override
  State<AvatarCustomizationSheet> createState() => _AvatarCustomizationSheetState();
}

class _AvatarCustomizationSheetState extends State<AvatarCustomizationSheet> {
  late AvatarModel _currentAvatar;
  String _selectedCategory = 'face';
  final AvatarService _avatarService = AvatarService();
  bool _isUpdating = false;
  late final ScrollController _categoryController;

  @override
  void initState() {
    super.initState();
    _currentAvatar = widget.avatar;
    _categoryController = ScrollController();
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _updateAvatarPart(String category, String partId) async {
    setState(() => _isUpdating = true);

    try {
      await _avatarService.updateAvatarPart(
        userId: widget.userId,
        category: category,
        partId: partId,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '¡Avatar actualizado!',
              style: GoogleFonts.fredoka(),
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error al actualizar',
              style: GoogleFonts.fredoka(),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUpdating = false);
      }
    }
  }

  List<String> _getUnlockedList(String category) {
    switch (category) {
      case 'face':
        return _currentAvatar.unlockedFaces;
      case 'eyes':
        return _currentAvatar.unlockedEyes;
      case 'mouth':
        return _currentAvatar.unlockedMouths;
      case 'hair':
        return _currentAvatar.unlockedHairs;
      case 'top':
        return _currentAvatar.unlockedTops;
      case 'bottom':
        return _currentAvatar.unlockedBottoms;
      case 'shoes':
        return _currentAvatar.unlockedShoes;
      case 'hands':
        return _currentAvatar.unlockedHands;
      case 'accessory':
        return _currentAvatar.unlockedAccessories;
      case 'background':
        return _currentAvatar.unlockedBackgrounds;
      default:
        return [];
    }
  }

  String _getCurrentPart(String category) {
    switch (category) {
      case 'face':
        return _currentAvatar.face;
      case 'eyes':
        return _currentAvatar.eyes;
      case 'mouth':
        return _currentAvatar.mouth;
      case 'hair':
        return _currentAvatar.hair;
      case 'top':
        return _currentAvatar.top;
      case 'bottom':
        return _currentAvatar.bottom;
      case 'shoes':
        return _currentAvatar.shoes;
      case 'hands':
        return _currentAvatar.hands;
      case 'accessory':
        return _currentAvatar.accessory;
      case 'background':
        return _currentAvatar.background;
      default:
        return '';
    }
  }

  void _scrollCategories(double delta) {
    if (!_categoryController.hasClients) {
      return;
    }

    final ScrollPosition position = _categoryController.position;
    final double target = (_categoryController.offset + delta)
        .clamp(0.0, position.maxScrollExtent);

    if (target == _categoryController.offset) {
      return;
    }

    _categoryController.animateTo(
      target,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
  }

  void _handleCategoryPointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent) {
      return;
    }

    if (!_categoryController.hasClients) {
      return;
    }

    final ScrollPosition position = _categoryController.position;
    final double rawDelta = event.scrollDelta.dy.abs() > event.scrollDelta.dx.abs()
        ? event.scrollDelta.dy
        : event.scrollDelta.dx;
    if (rawDelta == 0) {
      return;
    }

    final double target = (_categoryController.offset + rawDelta)
        .clamp(0.0, position.maxScrollExtent);

    if (target != _categoryController.offset) {
      _categoryController.jumpTo(target);
    }
  }

  Widget _buildCategoryScrollButton({
    required IconData icon,
    required double delta,
  }) {
    return SizedBox(
      width: 36,
      child: AnimatedBuilder(
        animation: _categoryController,
        builder: (context, _) {
          final controller = _categoryController;
          final canScroll = controller.hasClients &&
              ((delta < 0 && controller.offset > 0) ||
                  (delta > 0 &&
                      controller.offset < controller.position.maxScrollExtent));

          return IconButton(
            icon: Icon(icon, size: 24),
            color: canScroll ? AppColors.primary : Colors.grey.shade400,
            tooltip: delta < 0 ? 'Ver anteriores' : 'Ver siguientes',
            onPressed: canScroll ? () => _scrollCategories(delta) : null,
          );
        },
      ),
    );
  }

  Widget _buildCategoryChip(String category, bool isSelected) {
    return Material(
      color: isSelected ? AppColors.primary : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          setState(() {
            _selectedCategory = category;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AvatarCatalog.getCategoryIcon(category),
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 4),
              Text(
                AvatarCatalog.getCategoryName(category),
                style: GoogleFonts.fredoka(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return SizedBox(
      height: 88,
      child: Row(
        children: [
          _buildCategoryScrollButton(icon: Icons.chevron_left, delta: -160),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: const {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                  PointerDeviceKind.stylus,
                },
              ),
              child: Listener(
                onPointerSignal: _handleCategoryPointerSignal,
                child: Scrollbar(
                  controller: _categoryController,
                  thumbVisibility: true,
                  interactive: true,
                  child: ListView.separated(
                    controller: _categoryController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: AvatarCatalog.categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final category = AvatarCatalog.categories[index];
                      final isSelected = _selectedCategory == category;
                      return _buildCategoryChip(category, isSelected);
                    },
                  ),
                ),
              ),
            ),
          ),
          _buildCategoryScrollButton(icon: Icons.chevron_right, delta: 160),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Text(
                    'Personalizar Avatar',
                    style: GoogleFonts.fredoka(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 48), // Balance con el botón de cerrar
              ],
            ),
          ),

          // Vista previa del avatar
          StreamBuilder<AvatarModel?>(
            stream: _avatarService.avatarStream(widget.userId),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                _currentAvatar = snapshot.data!;
              }

              return Container(
                padding: const EdgeInsets.all(16),
                child: AvatarWidget(
                  avatar: _currentAvatar,
                  size: 120,
                  animate: false,
                ),
              );
            },
          ),

          const SizedBox(height: 8),

          // Selector de categoría
          _buildCategorySelector(),

          const Divider(height: 24),

          // Lista de partes desbloqueadas
          Expanded(
            child: _isUpdating
                ? const Center(child: CircularProgressIndicator())
                : _buildPartsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPartsList() {
    final unlockedIds = _getUnlockedList(_selectedCategory);
    final currentPart = _getCurrentPart(_selectedCategory);
    final allParts = AvatarCatalog.getPartsByCategory(_selectedCategory);

    // Filtrar solo las partes desbloqueadas
    final availableParts =
        allParts.where((part) => unlockedIds.contains(part.id)).toList();

    if (availableParts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock_outline,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'No tienes partes desbloqueadas',
              style: GoogleFonts.fredoka(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Visita la tienda para comprar más',
              style: GoogleFonts.fredoka(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: availableParts.length,
      itemBuilder: (context, index) {
        final part = availableParts[index];
        final isSelected = currentPart == part.id;

        return GestureDetector(
          onTap: () {
            _updateAvatarPart(_selectedCategory, part.id);
          },
          child: Container(
            decoration: BoxDecoration(
              color:
                  isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.grey.shade300,
                width: isSelected ? 3 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _PartPreview(part: part),
                const SizedBox(height: 4),
                Text(
                  part.name,
                  style: GoogleFonts.fredoka(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (isSelected)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Equipado',
                      style: GoogleFonts.fredoka(
                        fontSize: 9,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PartPreview extends StatelessWidget {
  final AvatarPartItem part;

  const _PartPreview({required this.part});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fallback = Text(
      part.emoji == null || part.emoji!.isEmpty ? '🎨' : part.emoji!,
      style: theme.textTheme.displaySmall?.copyWith(fontSize: 40),
    );

    if (part.assetPath.isEmpty) {
      return fallback;
    }

    return Center(
      child: SvgPicture.asset(
        part.assetPath,
        width: 56,
        height: 56,
        fit: BoxFit.contain,
        placeholderBuilder: (_) => fallback,
      ),
    );
  }
}

library;

/// Sheet de Personalización de Avatar
///
/// Permite al usuario cambiar las partes de su avatar
/// usando solo las partes que ha desbloqueado.
///
/// Autor: Sistema Educativo
/// Fecha: 2025

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/avatar_model.dart';
import '../../domain/services/avatar_service.dart';
import '../../app/config/avatar_catalog.dart';
import '../../app/theme/colors.dart';
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

  @override
  void initState() {
    super.initState();
    _currentAvatar = widget.avatar;
  }

  Future<void> _updateAvatarPart(String category, String emoji) async {
    setState(() => _isUpdating = true);

    try {
      await _avatarService.updateAvatarPart(
        userId: widget.userId,
        category: category,
        emoji: emoji,
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
      case 'hair':
        return _currentAvatar.unlockedHairs;
      case 'top':
        return _currentAvatar.unlockedTops;
      case 'bottom':
        return _currentAvatar.unlockedBottoms;
      case 'shoes':
        return _currentAvatar.unlockedShoes;
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
      case 'hair':
        return _currentAvatar.hair;
      case 'top':
        return _currentAvatar.top;
      case 'bottom':
        return _currentAvatar.bottom;
      case 'shoes':
        return _currentAvatar.shoes;
      case 'accessory':
        return _currentAvatar.accessory;
      case 'background':
        return _currentAvatar.background;
      default:
        return '';
    }
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
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: AvatarCatalog.categories.length,
              itemBuilder: (context, index) {
                final category = AvatarCatalog.categories[index];
                final isSelected = _selectedCategory == category;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.grey.shade100,
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
                );
              },
            ),
          ),

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
    final unlockedEmojis = _getUnlockedList(_selectedCategory);
    final currentPart = _getCurrentPart(_selectedCategory);
    final allParts = AvatarCatalog.getPartsByCategory(_selectedCategory);

    // Filtrar solo las partes desbloqueadas
    final availableParts = allParts
        .where((part) => unlockedEmojis.contains(part.emoji))
        .toList();

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
        final isSelected = currentPart == part.emoji;

        return GestureDetector(
          onTap: () {
            _updateAvatarPart(_selectedCategory, part.emoji);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.grey.shade300,
                width: isSelected ? 3 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  part.emoji == 'none' ? '❌' : part.emoji,
                  style: const TextStyle(fontSize: 40),
                ),
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

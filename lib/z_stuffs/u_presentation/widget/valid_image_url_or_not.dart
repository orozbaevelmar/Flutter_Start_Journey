import 'package:flutter/material.dart';

class ValidImageUrlOrNot extends StatefulWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final double circular;
  final BoxFit fit;
  const ValidImageUrlOrNot({
    super.key,
    required this.imageUrl,
    this.height = 0,
    this.width = 0,
    this.circular = 8,
    this.fit = BoxFit.cover,
  });

  @override
  State<ValidImageUrlOrNot> createState() => _ValidImageUrlOrNotState();
}

class _ValidImageUrlOrNotState extends State<ValidImageUrlOrNot> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.circular),
      child: widget.imageUrl != null ? buildPhoto() : _noImageAvailable(),
    );
  }

  Widget buildPhoto() {
    return Image.network(
      widget.imageUrl ?? '',
      fit: BoxFit.fitHeight,
      height: widget.height,
      width: widget.width,
      errorBuilder: (context, error, stackTrace) {
        return _noImageAvailable();
      },
    );
  }

  Widget _noImageAvailable() {
    return Image(
      height: widget.height,
      fit: widget.fit,
      width: widget.width,
      image: const AssetImage('assets/delete/no_image.jpg'),
    );
  }
}

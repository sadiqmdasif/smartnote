import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:smartnote/utils/theme/theme.dart';

class CustomImage extends StatelessWidget {
  final Color emptyImageColor;
  final String imageUrl;
  final String imageFilePath;
  final Uint8List? imageBytes;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;

  CustomImage(
      this.imageUrl, {
        this.emptyImageColor = CustomColors.imageBackground,
        this.fit,
        this.width,
        this.height,
        this.borderRadius = const BorderRadius.all(Radius.zero),
        Key? key,
      })  : this.imageBytes = null,
        this.imageFilePath = '',
        super(key: key);

  CustomImage.asset(
      this.imageFilePath, {
        this.fit,
        this.width,
        this.height,
        this.borderRadius = const BorderRadius.all(Radius.zero),
        Key? key,
      })  : this.emptyImageColor = CustomColors.imageBackground,
        this.imageUrl = '',
        this.imageBytes = null,
        super(key: key);

  CustomImage.memory(
      this.imageBytes, {
        Key? key,
        this.fit,
        this.width,
        this.height,
        this.borderRadius = const BorderRadius.all(Radius.zero),
      })  : this.emptyImageColor = CustomColors.imageBackground,
        this.imageUrl = '',
        this.imageFilePath = '',
        super(key: key);

  Widget _buildImage() {
    if (imageUrl != '') {
      return Image.network(
        imageUrl,
        fit: fit,
        width: width,
        height: height,
      );
    }

    if (imageFilePath != '') {
      return Image.asset(
        imageFilePath,
        fit: fit,
        width: width,
        height: height,
      );
    }

    if (imageBytes != null) {
      return Image.memory(
        imageBytes!,
        fit: fit,
        width: width,
        height: height,
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: width,
        height: height,
        color: imageUrl.isEmpty ? emptyImageColor : Colors.transparent,
        child: Visibility(visible: imageUrl.isNotEmpty, child: _buildImage()),
      ),
    );
  }
}

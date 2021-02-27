import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:booster/domain/gallery/image_entity/image_entity.dart';

class ACachedNetworkImage extends StatelessWidget {
  final ImageEntity image;
  final double width;
  final double height;

  const ACachedNetworkImage({
    Key key,
    @required this.image,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      fadeInDuration: const Duration(),
      fadeOutDuration: const Duration(),
      imageUrl: image.constructDownloadUrl(
        width: width.toInt(),
        height: height.toInt(),
      ),
      placeholder: (context, __) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      errorWidget: (context, __, ___) {
        return Container(
          color: Colors.grey,
          child: const Icon(
            Icons.broken_image,
            size: 50,
            color: Colors.black38,
          ),
        );
      },
    );
  }
}

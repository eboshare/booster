import 'package:flutter/material.dart';

import 'package:booster/domain/gallery/image_entity/image_entity.dart';
import 'package:booster/presentation/core/design_system/design_system.dart';
import 'package:booster/presentation/core/components/a_cached_network_image.dart';

class DetailedImagePage extends StatelessWidget {
  final ImageEntity image;

  const DetailedImagePage({
    Key key,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(image.author),
      ),
      body: InteractiveViewer(
        maxScale: DesignSystem.of(context).dimensions.maxInteractiveViewerScale,
        child: Center(
          child: Hero(
            tag: image.id,
            child: ACachedNetworkImage(
              image: image,
              width: image.width.toDouble(),
              height: image.height.toDouble(),
            ),
          ),
        ),
      ),
    );
  }
}

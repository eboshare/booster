import 'package:flutter/material.dart';

import 'package:flutter_booster_kit/domain/gallery/gallery.dart';
import 'package:flutter_booster_kit/presentation/components/alternative/a_cached_network_image.dart';
import 'package:flutter_booster_kit/presentation/design_system/design_system.dart';

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

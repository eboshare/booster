import 'package:flutter/material.dart';

import 'package:booster/domain/gallery/image_entity/image_entity.dart';
import 'package:booster/presentation/core/components/a_cached_network_image.dart';
import 'package:booster/presentation/core/design_system/design_system.dart';

class GalleryTile extends StatelessWidget {
  final ImageEntity image;

  const GalleryTile({
    Key key,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final designSystem = DesignSystem.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(
          designSystem.dimensions.galleryTileInnerPadding,
        ),
        child: Row(
          children: [
            SizedBox(
              width: designSystem.dimensions.imageInListSize,
              height: designSystem.dimensions.imageInListSize,
              child: Hero(
                tag: image.id,
                child: ACachedNetworkImage(
                  image: image,
                  width: designSystem.dimensions.imageInListSize,
                  height: designSystem.dimensions.imageInListSize,
                ),
              ),
            ),
            SizedBox(width: designSystem.dimensions.galleryTileInnerPadding),
            Expanded(
              child: Text(
                image.author,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

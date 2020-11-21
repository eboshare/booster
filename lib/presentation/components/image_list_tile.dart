import 'package:flutter/material.dart';

import 'package:flutter_booster_kit/domain/entities/image/image.dart';
import 'package:flutter_booster_kit/presentation/components/alternative/a_cached_network_image.dart';
import 'package:flutter_booster_kit/presentation/design_system/design_system.dart';

class ImageListTile extends StatelessWidget {
  final ImageEntity image;

  const ImageListTile({
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
          designSystem.dimensions.imageListTileInnerPadding,
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
            SizedBox(width: designSystem.dimensions.imageListTileInnerPadding),
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

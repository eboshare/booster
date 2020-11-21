import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter_booster_kit/configuration/injection/injection.dart';
import 'package:flutter_booster_kit/configuration/localization/generated/l10n.dart';
import 'package:flutter_booster_kit/domain/stores/i_image_list_store.dart';
import 'package:flutter_booster_kit/presentation/components/error_placeholder.dart';
import 'package:flutter_booster_kit/presentation/components/image_list_tile.dart';
import 'package:flutter_booster_kit/presentation/design_system/design_system.dart';
import 'package:flutter_booster_kit/utils/extensions.dart';

class ImageListPage extends StatefulWidget {
  @override
  _ImageListPageState createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {
  final IImageListStore store = getIt();

  @override
  void initState() {
    super.initState();
    store.loadImages();
  }

  @override
  Widget build(BuildContext context) {
    final str = S.of(context);
    final designSystem = DesignSystem.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(str.imageListPageTitle),
      ),
      body: Observer(
        builder: (context) {
          return store.status.when(
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: () {
              return Center(
                child: ErrorPlaceholder(
                  message: str.errorImageListLoading,
                ),
              );
            },
            success: () {
              return ListView.separated(
                padding: EdgeInsets.all(designSystem.dimensions.listViewPadding),
                itemCount: store.images.length,
                separatorBuilder: (_, __) {
                  return SizedBox(height: designSystem.dimensions.listViewPadding);
                },
                itemBuilder: (context, index) {
                  final image = store.images[index];
                  return GestureDetector(
                    onTap: () {
                      ExtendedNavigator.of(context).pushDetailedImagePage(image: image);
                    },
                    child: ImageListTile(image: image),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

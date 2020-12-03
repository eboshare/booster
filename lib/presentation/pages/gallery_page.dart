import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_booster_kit/config/injection/injection.dart';
import 'package:flutter_booster_kit/config/localization/generated/l10n.dart';
import 'package:flutter_booster_kit/utils/extensions/extensions.dart';
import 'package:flutter_booster_kit/domain/gallery/gallery.dart';
import 'package:flutter_booster_kit/presentation/components/error_placeholder.dart';
import 'package:flutter_booster_kit/presentation/components/gallery_tile.dart';
import 'package:flutter_booster_kit/presentation/design_system/design_system.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final IGalleryBloc bloc = getIt();

  @override
  void initState() {
    super.initState();
    bloc.add(const GalleryEvent.loadImages());
  }

  @override
  Widget build(BuildContext context) {
    final str = S.of(context);
    final designSystem = DesignSystem.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(str.galleryPageTitle),
      ),
      body: BlocBuilder<IGalleryBloc, GalleryStateEntity>(
        cubit: bloc,
        builder: (context, state) {
          return state.when(
            initial: _buildProgressIndicator,
            loading: _buildProgressIndicator,
            error: () {
              return Center(
                child: ErrorPlaceholder(
                  message: str.errorGalleryLoading,
                ),
              );
            },
            success: (images) {
              return ListView.separated(
                padding: EdgeInsets.all(designSystem.dimensions.listViewPadding),
                itemCount: images.length,
                separatorBuilder: (_, __) {
                  return SizedBox(
                    height: designSystem.dimensions.listViewPadding,
                  );
                },
                itemBuilder: (context, index) {
                  final image = images[index];
                  return GestureDetector(
                    onTap: () {
                      ExtendedNavigator.of(context).pushDetailedImagePage(image: image);
                    },
                    child: GalleryTile(image: image),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:booster/presentation/core/design_system/design_system.dart';
import 'package:booster/config/injection.dart';
import 'package:booster/config/localization/generated/l10n.dart';
import 'package:booster/utils/extensions/extensions.dart';
import 'package:booster/presentation/core/components/error_placeholder.dart';
import 'package:booster/presentation/gallery/gallery_tile.dart';
import 'package:booster/domain/gallery/gallery_event/gallery_event.dart';
import 'package:booster/domain/gallery/gallery_state_entity/gallery_state_entity.dart';
import 'package:booster/domain/gallery/i_gallery_bloc.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  IGalleryBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt();
    _bloc.add(const GalleryEvent.loadImages());
  }

  @override
  void dispose() {
    super.dispose();
    getIt.dispose(_bloc);
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
        cubit: _bloc,
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
                separatorBuilder: (context, __) {
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

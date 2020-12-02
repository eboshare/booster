import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_booster_kit/application/image_list/image_list_bloc.dart';
import 'package:flutter_booster_kit/config/injection/injection.dart';
import 'package:flutter_booster_kit/config/localization/generated/l10n.dart';
import 'package:flutter_booster_kit/utils/extensions/extensions.dart';
import 'package:flutter_booster_kit/presentation/components/error_placeholder.dart';
import 'package:flutter_booster_kit/presentation/components/image_list_tile.dart';
import 'package:flutter_booster_kit/presentation/design_system/design_system.dart';

class ImageListPage extends StatefulWidget {
  @override
  _ImageListPageState createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {
  final ImageListBloc bloc = getIt();

  @override
  void initState() {
    super.initState();
    bloc.add(const ImageListEvent.loadImages());
  }

  @override
  Widget build(BuildContext context) {
    final str = S.of(context);
    final designSystem = DesignSystem.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(str.imageListPageTitle),
      ),
      body: BlocBuilder<ImageListBloc, ImageListState>(
        cubit: bloc,
        builder: (context, state) {
          return state.when(
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
            success: (images) {
              return ListView.separated(
                padding: EdgeInsets.all(designSystem.dimensions.listViewPadding),
                itemCount: images.length,
                separatorBuilder: (_, __) {
                  return SizedBox(height: designSystem.dimensions.listViewPadding);
                },
                itemBuilder: (context, index) {
                  final image = images[index];
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

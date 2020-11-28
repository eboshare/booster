import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_booster_kit/config/injection/injection.dart';
import 'package:flutter_booster_kit/config/localization/generated/l10n.dart';
import 'package:flutter_booster_kit/domain/image_list/i_image_repository.dart';
import 'package:flutter_booster_kit/presentation/app_widget.dart';
import 'package:flutter_booster_kit/presentation/pages/image_list_page.dart';
import 'package:flutter_booster_kit/domain/image_list/image_entity/image_entity.dart';
import 'package:flutter_booster_kit/domain/image_list/image_list_failure/image_list_failure.dart';

void main() {
  group('Loading', () {
    const mockImages = [
      ImageEntity(
        id: '0',
        author: 'Alejandro Escamilla',
        width: 5616,
        height: 3744,
        url: 'https://unsplash.com/photos/yC-Yzbqy7PY',
        downloadUrl: 'https://picsum.photos/id/0/5616/3744',
      ),
      ImageEntity(
        id: '10',
        author: 'Paul Jarvis',
        width: 2500,
        height: 1667,
        url: 'https://unsplash.com/photos/6J--NXulQCs',
        downloadUrl: 'https://picsum.photos/id/10/2500/1667',
      ),
    ];

    IImageRepository mockImageRepository;
    Widget imageListPage;

    setUp(() {
      getIt.reset();
      configureDependencies(Environment.test);
      mockImageRepository = getIt();
      imageListPage = initializeAppWithPage(page: ImageListPage());
    });

    testWidgets('The correct message should be displayed on loading error', (tester) async {
      // arrange
      when(mockImageRepository.getImageList()).thenAnswer(
        (_) async => Left(ImageListFailure.unknown()),
      );

      // act
      await tester.pumpWidget(imageListPage);
      await tester.pumpAndSettle();

      // assert
      expect(find.text(S.current.imageListPageTitle), findsOneWidget);
      expect(find.text(S.current.errorImageListLoading), findsOneWidget);
    });

    testWidgets('The images should be displayed on success loading', (tester) async {
      // arrange
      when(mockImageRepository.getImageList()).thenAnswer(
        (_) async => const Right(mockImages),
      );

      // act
      await tester.pumpFrames(imageListPage, const Duration(milliseconds: 1000));

      // assert
      expect(find.text(S.current.imageListPageTitle), findsOneWidget);
      expect(find.text(mockImages.first.author), findsOneWidget);
      expect(find.text(mockImages.last.author), findsOneWidget);
    });
  });
}

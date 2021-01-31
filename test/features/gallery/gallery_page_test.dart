import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:booster/config/injection/injection.dart';
import 'package:booster/config/localization/generated/l10n.dart';
import 'package:booster/presentation/app_widget.dart';
import 'package:booster/presentation/gallery/gallery_page.dart';
import 'package:booster/domain/gallery/gallery_failure/gallery_failure.dart';
import 'package:booster/domain/gallery/i_image_repository.dart';
import 'package:booster/domain/gallery/image_entity/image_entity.dart';
import 'package:booster/utils/extensions/extensions.dart';

void main() {
  group('Loading', () {
    final mockImages = KtList.from(
      const [
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
      ],
    );

    IImageRepository mockImageRepository;
    Widget galleryPage;

    setUp(() {
      getIt.reset();
      configureDependencies(Environment.test);
      mockImageRepository = getIt();
      galleryPage = initializeAppWithPage(page: GalleryPage());
    });

    testWidgets('The correct message should be displayed on loading error', (tester) async {
      // arrange
      when(mockImageRepository.getImages()).thenAnswer(
        (_) async => Left(GalleryFailure.unknown()),
      );

      // act
      await tester.pumpWidget(galleryPage);
      await tester.pumpAndSettle();

      // assert
      expect(find.text(S.current.galleryPageTitle), findsOneWidget);
      expect(find.text(S.current.errorGalleryLoading), findsOneWidget);
    });

    testWidgets('The images should be displayed on success loading', (tester) async {
      // arrange
      when(mockImageRepository.getImages()).thenAnswer(
        (_) async => Right(mockImages),
      );

      // act
      await tester.pumpFrames(galleryPage, const Duration(milliseconds: 1000));

      // assert
      expect(find.text(S.current.galleryPageTitle), findsOneWidget);
      expect(find.text(mockImages.firstElement.author), findsOneWidget);
      expect(find.text(mockImages.lastElement.author), findsOneWidget);
    });
  });
}

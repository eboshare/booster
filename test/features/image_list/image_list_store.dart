import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:injectable/injectable.dart' hide test;
import 'package:mobx/mobx.dart' hide when;
import 'package:dartz/dartz.dart';

import 'package:flutter_booster_kit/injection/injection.dart';
import 'package:flutter_booster_kit/utils/sealed_classes.dart';
import 'package:flutter_booster_kit/layers/domain/repositories/i_image_repository.dart';
import 'package:flutter_booster_kit/layers/domain/failures/image_repository/image_list_failure.dart';
import 'package:flutter_booster_kit/layers/domain/stores/i_image_list_store.dart';
import 'package:flutter_booster_kit/layers/domain/entities/image/image.dart';

void main() {
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
      id: '1',
      author: 'Alejandro Escamilla',
      width: 5616,
      height: 3744,
      url: 'https://unsplash.com/photos/LNRyGwIJr5c',
      downloadUrl: 'https://picsum.photos/id/1/5616/3744',
    ),
  ];

  IImageListStore store;
  IImageRepository mockImageRepository;

  setUp(() {
    getIt.reset();
    configureDependencies(Environment.test);
    store = getIt();
    mockImageRepository = getIt();
  });

  group('Image list field', () {
    test('By default images should be empty or null', () {
      // assert
      expect(
        store.images,
        anyOf([
          equals(null),
          equals([]),
        ]),
      );
    });

    test('Images should not be empty or null during reloading', () async {
      // arrange
      final imagesValues = <List<ImageEntity>>[];
      reaction((_) => store.images, imagesValues.add);
      when(mockImageRepository.getImagesList()).thenAnswer((_) async => const Right(mockImages));
      // act
      await store.loadImages();
      await store.loadImages(); // reloading
      // assert
      expect(
        store.images,
        allOf([
          isNot(contains(null)),
          isNot(contains([])),
        ]),
      );
    });
  });

  group('Status field', () {
    test('There should be a correct status order during loading', () async {
      // arrange
      final statuses = <LoadingStatus>[];
      reaction((_) => store.status, statuses.add);
      when(mockImageRepository.getImagesList()).thenAnswer((_) async => Left(ImageListFailure.unknown()));
      // act
      await store.loadImages();
      // assert
      expect(statuses.length, equals(2));
      expect(statuses.first, equals(LoadingStatus.loading()));
      expect(
        statuses.last,
        anyOf([
          LoadingStatus.error(),
          LoadingStatus.success(),
        ]),
      );
    });

    test('Store should set the error status on a failure', () async {
      // arrange
      when(mockImageRepository.getImagesList()).thenAnswer(
        (_) async => Left(ImageListFailure.unknown()),
      );
      // act
      await store.loadImages();
      // assert
      expect(store.status, equals(LoadingStatus.error()));
    });

    test('Store should set the success status when data fetched', () async {
      // arrange
      when(mockImageRepository.getImagesList()).thenAnswer(
        (_) async => const Right(mockImages),
      );

      // act
      await store.loadImages();
      // assert
      expect(store.status, equals(LoadingStatus.success()));
    });
  });
}

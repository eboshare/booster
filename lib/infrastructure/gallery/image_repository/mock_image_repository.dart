import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

import 'package:booster/domain/gallery/i_image_repository.dart';

@LazySingleton(as: IImageRepository, env: [Environment.test])
class MockImageRepository extends Mock implements IImageRepository {}

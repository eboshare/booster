import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_booster_kit/domain/repository_interfaces/i_image_repository.dart';

@Singleton(as: IImageRepository, env: [Environment.test])
class MockImageRepository extends Mock implements IImageRepository {}

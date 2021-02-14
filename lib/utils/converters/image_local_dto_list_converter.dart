import 'package:booster/infrastructure/gallery/image_local_dto/image_local_dto.dart';
import 'package:booster/utils/converters/kt/kt_list_converter.dart';

ImageLocalDto _objectFromJson(Object json) => ImageLocalDto.fromJson(json);
Map<String, dynamic> _objectToJson(ImageLocalDto dto) => dto.toJson();

class ImageLocalDtoListConverter extends KtListConverter<ImageLocalDto, Object> {
  const ImageLocalDtoListConverter() : super(_objectFromJson, _objectToJson);
}

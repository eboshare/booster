import 'package:booster/app_initializers.dart';
import 'package:booster/utils/sealed_classes/environment.dart';

Future<void> main() => initAndRunApp(const Environment.prod());

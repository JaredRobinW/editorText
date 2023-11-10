import 'package:path_provider/path_provider.dart';

Future<String?> getExternalStoragePath() async {
  final directory = await getExternalStorageDirectory();
  return directory?.path;
}


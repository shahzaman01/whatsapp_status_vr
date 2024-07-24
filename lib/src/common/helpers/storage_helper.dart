import 'dart:io';

import 'package:status_saver/src/home/models/whatsapp_type_enum.dart';

String getStatusesPath(WhatsAppType whatsAppType, bool isAndroid11OrLater) {
  final String baseDir = isAndroid11OrLater ? "Android/media" : "/storage/emulated/0/Android/media";

  if (whatsAppType == WhatsAppType.whatsApp) {
    return "$baseDir/com.whatsapp/WhatsApp/Media/.Statuses";
  } else if (whatsAppType == WhatsAppType.w4b) {
    return "$baseDir/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses";
  } else {
    throw Exception(
        "Please provide statuses dir path for whatsapp type: '$whatsAppType'");
  }
}


bool isItStatusFile(String filePath) {
  return filePath.endsWith(".mp4") || filePath.endsWith(".jpg");
}

List<String> getDirectoryFilePaths(
  String dirPath, {
  bool Function(String)? whereCallback,
}) {
  whereCallback ??= (_) => true;

  try {
    Directory dir = Directory(dirPath);
    if (!dir.existsSync()) {
      return [];
    }

    return dir
        .listSync()
        .map((fileSystemEntity) => fileSystemEntity.path)
        .where(whereCallback)
        .toList();
  } catch (e) {
    return List.empty();
  }
}

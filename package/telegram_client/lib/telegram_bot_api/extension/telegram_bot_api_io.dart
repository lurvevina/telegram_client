// ignore_for_file: depend_on_referenced_packages

import 'package:telegram_client/telegram_bot_api/telegram_bot_api.dart';
import 'package:telegram_client/util/util.dart';

import 'package:universal_io/io.dart';
// import 'package:path/path.dart' as p;

/// extension tdlib for make
extension TelegramBotApiTypeFileMethodExtensions on TelegramBotApi {
  /// test method
  Map typeFile(dynamic content) {
    Map data = {};
    if (content is String) {
      if (RegExp(r"^http", caseSensitive: false).hasMatch(content)) {
        data = {"@type": 'inputFileRemote', "data": content};
      } else if (RegExp(r"^(\/|\.\.?\/|~\/)", caseSensitive: false).hasMatch(content)) {
        File file = File(content);
        // file.uri.;
        data = {
          "@type": 'inputFileLocal',
          "data": TgUtils.telegram_bot_api_file(file: file)
        };
      } else if (content is int) {
        data = {"@type": 'inputFileId', "data": content};
      } else {
        data = {"@type": 'inputFileRemote', "data": content};
      }
    } else {
      data = {"@type": 'inputFileRemote', "data": content};
    }
    return data;
  }
}

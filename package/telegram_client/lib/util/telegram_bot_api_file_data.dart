// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';

class TelegramBotApiFileData {
  String name;
  Uint8List buffer_data;

  TelegramBotApiFileData({
    required this.name,
    required this.buffer_data,
  });
}

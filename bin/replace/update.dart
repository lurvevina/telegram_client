/* <!-- START LICENSE -->


Program Ini Di buat Oleh DEVELOPER Dari PERUSAHAAN GLOBAL CORPORATION 
Social Media: 

- Youtube: https://youtube.com/@Global_Corporation 
- Github: https://github.com/globalcorporation
- TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

Seluruh kode disini di buat 100% murni tanpa jiplak / mencuri kode lain jika ada akan ada link komment di baris code

Jika anda mau mengedit pastikan kredit ini tidak di hapus / di ganti!

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!


<!-- END LICENSE --> */
 
// ignore_for_file: non_constant_identifier_names

import "dart:io";

import "package:general_lib/general_lib.dart";
import 'package:universal_io/io.dart';
import "package:path/path.dart" as path;
import "package:yaml/yaml.dart" as yaml;
import "package:yaml_writer/yaml_writer.dart";

Future<void> pubspecUpdate({
  required File filePubspec,
}) async {
  if (filePubspec.existsSync()) {
    Map yaml_code = (yaml.loadYaml(filePubspec.readAsStringSync(), recover: true) as Map);
    Map yaml_code_clone = yaml_code.clone();
    yaml_code_clone.printPretty();
// homepage: https://youtube.com/@azkadev
//
// repository: https://github.com/azkadev/telegram_client
// issue_tracker: https://github.com/azkadev/telegram_client/issues
// documentation: https://telegram-client.vercel.app/
// funding:
    // - https://github.com/sponsors/azkadev
    // - https://github.com/sponsors/generalfoss
    yaml_code_clone.addAll({
      "description": "Telegram Client Lightweight, blazing and Highly customizable for make application telegram based tdlib, mtproto, or bot api and support server side.",
      "version": "0.8.0",
      "repository": "https://github.com/azkadev/telegram_client",
      "homepage": "https://github.com/azkadev/telegram_client",
      "issue_tracker": "https://github.com/azkadev/telegram_client/issues",
      "documentation": "https://github.com/azkadev/telegram_client/tree/main/docs",
      "funding": [
        "https://github.com/sponsors/azkadev",
        "https://github.com/sponsors/generalfoss",
      ],
      "platforms": {
        "android": null,
        "ios": null,
        "linux": null,
        "macos": null,
        "web": null,
        "windows": null,
      },
      "topics": [
        "telegram",
        "tdlib",
        "mtproto",
        "userbot",
        "bot", 
      ],
    });
    yaml_code_clone.removeByKeys([
      "publish_to",
    ]);
    var yamlDoc = YamlWriter().write(yaml_code_clone);
    await filePubspec.writeAsString(yamlDoc);
  }
}

void main(List<String> args) async {
  Directory directory = Directory.current;
  Directory directory_home = Directory(path.join(directory.path));

  File file_pubspec_home = File(path.join(directory_home.path, "pubspec.yaml"));
  await pubspecUpdate(filePubspec: file_pubspec_home);
  Directory directory_packages = Directory(path.join(directory.path, "package"));

  if (!directory_packages.existsSync()) {
    print("Directory Packages Not Found: ${directory_packages.path}");
    exit(1);
  }

  List<FileSystemEntity> file_system_entity_packages = directory_packages.listSync();

  for (var i = 0; i < file_system_entity_packages.length; i++) {
    FileSystemEntity fileSystemEntity = file_system_entity_packages[i];
    if (fileSystemEntity is Directory) {
      File file_pubspec = File(path.join(fileSystemEntity.path, "pubspec.yaml"));

      await pubspecUpdate(filePubspec: file_pubspec);
    }
  }

  print("Finished");
}

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
// ignore_for_file: non_constant_identifier_names, camel_case_extensions

import 'dart:async';
import 'package:telegram_client/telegram_client/call_api_invoke.dart';
import 'package:general_lib/extension/regexp.dart';

import 'package:telegram_client/telegram_client/telegram_client.dart';
import 'package:telegram_client/util/util.dart';

/// method SendChatAction
extension SendChatActionDataOn on TelegramClient {
  /// method SendChatAction
  FutureOr<Map> sendChatAction({
    required Map parameters,
    required TelegramClientCallApiInvoke callApiInvoke,
  }) async {
    dynamic target_chat_id = TgUtils.parse_all_chat_id(parameters: parameters);
    if (target_chat_id is String &&
        RegExp(r"^((@)[a-z0-9_]+)$", caseSensitive: false)
            .hashData(target_chat_id)) {
      var search_public_chat = await callApiInvoke(
        parameters: {
          "@type": "searchPublicChat",
          "username": (target_chat_id)
              .replaceAll(RegExp(r"@", caseSensitive: false), ""),
        },
        is_invoke_no_relevance: true,
      );
      if (search_public_chat["@type"] == "chat") {
        parameters["chat_id"] = search_public_chat["id"];
      } else {
        return search_public_chat;
      }
    }
    Map request_parameters = {
      "@type": "sendChatAction",
      "chat_id": parameters["chat_id"],
      "action": {
        "@type": "chatActionTyping",
      }
    };
    if (parameters["action"] is String == false) {
      parameters["action"] = "";
    }
    String action_type = (parameters["action"]).toString();
    if (action_type == "typing") {
      request_parameters["action"]["@type"] = "chatActionTyping";
    }
    if (action_type == "play_game") {
      request_parameters["action"]["@type"] = "chatActionStartPlayingGame";
    }
    if (action_type == "choose_contact") {
      request_parameters["action"]["@type"] = "chatActionChoosingContact";
    }
    if (action_type == "record_voice") {
      request_parameters["action"]["@type"] = "chatActionRecordingVoiceNote";
    }
    if (action_type == "choose_location") {
      request_parameters["action"]["@type"] = "chatActionChoosingLocation";
    }
    if (action_type == "watch_animation") {
      request_parameters["action"]["@type"] = "chatActionWatchingAnimations";
    }
    if (action_type == "choose_sticker") {
      request_parameters["action"]["@type"] = "chatActionChoosingSticker";
    }
    if (action_type == "cancel") {
      request_parameters["action"]["@type"] = "chatActionCancel";
    }
    if (parameters["progress"] is int) {
      request_parameters["progress"] = parameters["progress"];
    }
    if (parameters["emoji"] is String) {
      request_parameters["emoji"] = parameters["emoji"];
    }
    if (parameters["message_thread_id"] is int) {
      request_parameters["message_thread_id"] =
          (parameters["message_thread_id"]);
    }
    Map message_send = await callApiInvoke(
      parameters: request_parameters,
    );

    return message_send;
  }
}

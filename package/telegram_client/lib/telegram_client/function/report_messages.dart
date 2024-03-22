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
import 'package:general_lib/extension/extension.dart';

import 'package:telegram_client/telegram_client/telegram_client.dart';

import 'package:telegram_client/util/util.dart';

/// method ReportMessages
extension ReportMessagesDataOn on TelegramClient {
  /// method ReportMessages
  FutureOr<Map> reportMessages({
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
      "@type": "reportChat",
      "chat_id": parameters["chat_id"],
      "message_ids": (parameters["message_ids"] as List)
          .map((e) => TgUtils().messageApiToTdlib(e))
          .toList(),
      "reason": {
        "@type": "reportReasonCustom",
      },
    };
    String reason_report = () {
      if (parameters["reason"] is String) {
        return (parameters["reason"] as String).toLowerCase();
      }
      return "";
    }();

    if (reason_report == "child_abuse") {
      request_parameters["reason"]["@type"] = "reportReasonChildAbuse";
    }

    if (reason_report == "copyright") {
      request_parameters["reason"]["@type"] = "reportReasonCopyright";
    }

    if (reason_report == "custom") {
      request_parameters["reason"]["@type"] = "reportReasonCustom";
    }

    if (reason_report == "fake") {
      request_parameters["reason"]["@type"] = "reportReasonFake";
    }

    if (reason_report == "illegal_drugs") {
      request_parameters["reason"]["@type"] = "reportReasonIllegalDrugs";
    }
    if (reason_report == "personal_details") {
      request_parameters["reason"]["@type"] = "reportReasonPersonalDetails";
    }
    if (reason_report == "porn") {
      request_parameters["reason"]["@type"] = "reportReasonPornography";
    }
    if (reason_report == "spam") {
      request_parameters["reason"]["@type"] = "reportReasonSpam";
    }
    if (reason_report == "unrelated_location") {
      request_parameters["reason"]["@type"] = "reportReasonUnrelatedLocation";
    }
    if (reason_report == "violence") {
      request_parameters["reason"]["@type"] = "reportReasonViolence";
    }
    if (parameters["text"] is String) {
      request_parameters["text"] = parameters["text"];
    }
    Map request_result = await callApiInvoke(
      parameters: request_parameters,
    );
    return request_result;
  }
}

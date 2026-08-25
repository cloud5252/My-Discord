import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app_enums.dart';

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.success,
    config: SnackbarConfig(
      backgroundColor: Colors.green.shade600,
      textColor: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(15),
      messageTextAlign: TextAlign.start,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.error,
    config: SnackbarConfig(
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(15),
      messageTextAlign: TextAlign.start,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.warning,
    config: SnackbarConfig(
      backgroundColor: Colors.orange.shade800,
      textColor: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(15),
      messageTextAlign: TextAlign.start,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.info,
    config: SnackbarConfig(
      backgroundColor: Colors.blue.shade700,
      textColor: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(15),
      messageTextAlign: TextAlign.start,
    ),
  );
}

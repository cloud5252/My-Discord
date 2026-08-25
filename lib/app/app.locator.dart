// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_services/src/snackbar/snackbar_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../service/FB_Auth/registration_auth.dart';
import '../service/chat_service/chat_service.dart';
import '../service/chat_service/user_service.dart';
import '../service/viewService.dart';
import '../ui/dialogs/unpin_message/unpin_message_dialog_model.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => registrationAuth());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => ViewService());
  locator.registerLazySingleton(() => ChatService());
  locator.registerLazySingleton(() => UnpinMessageDialogModel());
}

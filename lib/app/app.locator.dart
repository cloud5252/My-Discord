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

import '../service/FB_Auth/Authentication.dart';
import '../service/chat_service/add_or_fetch_friends_svc.dart';
import '../service/chat_service/chat_service.dart';
import '../service/chat_service/chatting_friend_svc.dart';
import '../service/chat_service/user_service.dart';
import '../service/chat_service/viewService.dart';
import '../service/hive_service/hive_service.dart';
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
  locator.registerLazySingleton(() => Authentication());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => ViewService());
  locator.registerLazySingleton(() => ChatService());
  locator.registerLazySingleton(() => HiveService());
  locator.registerLazySingleton(() => ChattingFriendService());
  locator.registerLazySingleton(() => AddOrFetchFriendsService());
  locator.registerLazySingleton(() => UnpinMessageDialogModel());
}

import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:my_discord/service/chat_service/add_or_fetch_friends_svc.dart';
import 'package:my_discord/service/chat_service/chat_service.dart';
import 'package:my_discord/service/chat_service/chatting_friend_svc.dart';
import 'package:my_discord/service/chat_service/user_service.dart';
import 'package:my_discord/service/chat_service/viewService.dart';
import 'package:my_discord/service/hive_service/hive_service.dart';
import 'package:my_discord/ui/dialogs/bottom_sheets/notice/notice_sheet.dart';
import 'package:my_discord/ui/dialogs/add_user/add_user_dialog.dart';
import 'package:my_discord/ui/dialogs/confirm_action/add_user_dialog.dart';
import 'package:my_discord/ui/dialogs/pin_messages/pin_messag_dialog.dart';
import 'package:my_discord/ui/dialogs/unpin_message/unpin_message_dialog.dart';
import 'package:my_discord/ui/dialogs/unpin_message/unpin_message_dialog_model.dart';
import 'package:my_discord/ui/views/auth_view/auth_view.dart';
import 'package:my_discord/ui/views/home/home_view.dart';
import 'package:my_discord/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: AuthView),

    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: Authentication),
    LazySingleton(classType: UserService),
    LazySingleton(classType: ViewService),
    LazySingleton(classType: ChatService),
    LazySingleton(classType: HiveService),
    LazySingleton(classType: ChattingFriendService),
    LazySingleton(classType: AddOrFetchFriendsService),
    LazySingleton(classType: UnpinMessageDialogModel),

    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: AddUserDialog),
    StackedDialog(classType: PinMessageDialog),
    StackedDialog(classType: UnpinMessageDialog),

    // @stacked-dialog
  ],
)
class App {}

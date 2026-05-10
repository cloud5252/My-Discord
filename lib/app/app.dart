import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:my_discord/service/chat_service/chat_service.dart';
import 'package:my_discord/service/chat_service/user_service.dart';
import 'package:my_discord/service/chat_service/viewService.dart';
import 'package:my_discord/ui/dialogs/bottom_sheets/notice/notice_sheet.dart';
import 'package:my_discord/ui/dialogs/add_user/add_user_dialog.dart';
import 'package:my_discord/ui/dialogs/confirm_action/add_user_dialog.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view.dart';
 import 'package:my_discord/ui/views/home/home_view.dart';
import 'package:my_discord/ui/views/log_in/log_in_view.dart';
import 'package:my_discord/ui/views/sign_in/sign_in_view.dart';
import 'package:my_discord/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: ChatView),
    MaterialRoute(page: SignInView),
    MaterialRoute(page: LogInView),

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

    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: AddUserDialog),

    // @stacked-dialog
  ],
)
class App {}

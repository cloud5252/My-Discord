import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app.router.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:my_discord/service/chat_service/viewService.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ServerSidebarViewmodel extends BaseViewModel {
  final _auth = locator<Authentication>();
  final _viewService = locator<ViewService>();
  Future<void> logoutTesting() async {
    setBusy(true);
    try {
      await _auth.logOut();

      _viewService.currentId = null;

      locator<NavigationService>().clearStackAndShow(Routes.logInView);

      print("Logout Successful!");
    } catch (e) {
      print("Logout Error: $e");
    } finally {
      setBusy(false);
    }
  }
}

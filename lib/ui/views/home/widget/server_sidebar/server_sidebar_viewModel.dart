import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app.router.dart';
import 'package:my_discord/service/FB_Auth/registration_auth.dart';
import 'package:my_discord/service/viewService.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ServerSidebarViewmodel extends BaseViewModel {
  final _auth = locator<registrationAuth>();
  final _viewService = locator<ViewService>();

  Future<void> logoutTesting() async {
    setBusy(true);
    try {
      await _auth.logOut();
      _viewService.resetToDefault();
      _viewService.currentId = null;

      locator<NavigationService>().clearStackAndShow(Routes.authView);

      print("Logout Successful!");
    } catch (e) {
      print("Logout Error: $e");
    } finally {
      setBusy(false);
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app.router.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  Future<void> runStartupLogic() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final user = FirebaseAuth.instance.currentUser;
    print('STARTUP: user = ${user?.email}');

    if (user != null) {
      _navigationService.replaceWithHomeView();
    } else {
      _navigationService.replaceWithLogInView();
    }
  }
}

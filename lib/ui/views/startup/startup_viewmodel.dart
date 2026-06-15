import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_ce/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app.router.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future<void> runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 2));
    await Hive.box('prefs_box').clear();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _navigationService.replaceWithHomeView();
    } else {
      _navigationService.replaceWithAuthView();
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app.router.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  String loadingText = 'Connecting...';

  Future<void> runStartupLogic() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      _navigationService.replaceWithAuthView();
      return;
    }

    loadingText = 'Almost there...';
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));

    _navigationService.replaceWithHomeView();
  }
}

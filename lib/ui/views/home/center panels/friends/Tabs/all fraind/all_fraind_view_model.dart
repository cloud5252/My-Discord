import 'package:my_discord/models/user_model.dart';
import 'package:stacked/stacked.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_discord/app/app.dialogs.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app_enums.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:stacked_services/stacked_services.dart';

class AllFraindViewModel extends BaseViewModel {
  List<UserModel> filteredContacts = [];
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final _snackbarService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<Authentication>();

  // List<UserModel> _allFriends = [];
  void showDialog() async {
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.addUser,
      title: 'Add User!',
      description: 'Please enter Email to add contact',
      mainButtonTitle: 'Add',
    );

    if (response != null && response.confirmed && response.data != null) {
      String email = response.data['email'];

      final currentUser = auth.getCurrentuser();

      if (currentUser == null) {
        return;
      }

      final results = await Future.wait([
        FirebaseFirestore.instance
            .collection('Users')
            .where('email', isEqualTo: email)
            .get(),
        FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.uid)
            .get()
      ]);

      final userQuery = results[0] as QuerySnapshot<Map<String, dynamic>>;
      final myProfile = results[1] as DocumentSnapshot<Map<String, dynamic>>;

      String myActualName = myProfile.data()?['username'] ?? "0";

      if (userQuery.docs.isNotEmpty) {
        var otherUserData = userQuery.docs.first.data();

        UserModel otherUser = UserModel(
          uid: otherUserData['uid'],
          username: otherUserData['username'],
          displayName: otherUserData['displayname'],
          email: otherUserData['email'],
          createdAt: DateTime.now(),
        );

        print('fraind Detail ================ ');
        print("fraind uid: ${otherUser.uid}");
        print("fraind name: ${otherUser.username}");
        print("fraind email: ${otherUser.email}");
        print('Your Detail ================ ');
        print("myId: ${currentUser.uid}");
        print("myName: $myActualName");
        print("myEmail: ${currentUser.email}");

        showUserAddedMessage();
      } else {
        _snackbarService.showSnackbar(message: "User not found on this email!");
      }
    } else {}
  }

  void showUserAddedMessage() {
    _snackbarService.showCustomSnackBar(
      variant: SnackbarType.success,
      title: 'Success',
      message: 'User has been ad successfully! ✅',
      duration: const Duration(seconds: 3),
      onTap: (result) {},
    );
  }
}

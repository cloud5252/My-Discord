import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app.router.dart';
import 'package:my_discord/models/contect_model.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum FriendFilter { online, all, pending, blocked, addfraind }

class FraindHubViewModel extends BaseViewModel {
  final _auth = locator<Authentication>();
  final _navigationService = locator<NavigationService>();
  FriendFilter _selectedFilter = FriendFilter.online;
  FriendFilter get selectedFilter => _selectedFilter;

  String _searchQuery = '';

  final List<ContactModel> _allContacts = [];

  List<ContactModel> get filteredContacts {
    List<ContactModel> result = switch (_selectedFilter) {
      FriendFilter.online => _allContacts
          .where((c) => c.status == 'online' || c.status == 'idle')
          .toList(),
      FriendFilter.all => _allContacts,
      FriendFilter.pending =>
        _allContacts.where((c) => c.status == 'pending').toList(),
      FriendFilter.blocked =>
        _allContacts.where((c) => c.status == 'blocked').toList(),
      FriendFilter.addfraind =>
        _allContacts.where((c) => c.status == 'addfraind').toList(),
    };

    if (_searchQuery.isNotEmpty) {
      result = result
          .where((c) =>
              c.displayName.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    return result;
  }

  List<ContactModel> get onlineContacts => filteredContacts
      .where((c) => c.status == 'online' || c.status == 'idle')
      .toList();

  List<ContactModel> get offlineContacts =>
      filteredContacts.where((c) => c.status == 'offline').toList();

  @override
  // ignore: override_on_non_overriding_member
  void initialise() {
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    setBusy(true);
    // apna contacts fetch logic yahan
    // _allContacts = await _contactService.getContacts();
    setBusy(false);
    notifyListeners();
  }

  void setFilter(FriendFilter filter) {
    _selectedFilter = filter;

    notifyListeners();
  }

  void onSearchChanged(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void onAddFriendTap() {}

  void navigateToChat(ContactModel contact) {}
  Future<void> logout() async {
    await _auth.logOut();
    _navigationService.replaceWithSignInView();
  }
}

import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app.router.dart';
import 'package:my_discord/models/contect_model.dart';
import 'package:my_discord/service/FB_Auth/registration_auth.dart';
import 'package:my_discord/service/viewService.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum FriendFilter { online, all, pending, blocked, addfraind }

class FraindHubViewModel extends BaseViewModel implements Initialisable {
  final _auth = locator<registrationAuth>();
  final _navigationService = locator<NavigationService>();
  final _viewService = locator<ViewService>();

  FriendFilter _selectedFilter = FriendFilter.online;
  FriendFilter get selectedFilter => _selectedFilter;

  String _searchQuery = '';

  ViewService get viewService => _viewService;
  String? get currentId => _viewService.currentId;

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
  void initialise() {
    _loadContacts();
    _viewService.addListener(_onViewChanged);
  }

  void _onViewChanged() => notifyListeners();

  @override
  void dispose() {
    _viewService.removeListener(_onViewChanged);
    super.dispose();
  }

  Future<void> _loadContacts() async {
    setBusy(true);
    // Firebase se data load karo yahan
    setBusy(false);
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
    _navigationService.replaceWithAuthView();
  }
}

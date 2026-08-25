// viewService.dart

import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view.dart';
import 'package:stacked/stacked.dart';

class ViewService with ListenableServiceMixin {
  final _isCompact = ReactiveValue<bool>(false);
  bool get isCompact => _isCompact.value;
  set isCompact(bool value) => _isCompact.value = value;

  final _currentView = ReactiveValue<Widget>(const FraindHubView());
  final _currentTitle = ReactiveValue<String>("Friends");
  set currentId(String? value) => _currentId = value;
  String? _currentId;
  String? get currentId => _currentId;
  Widget get currentView => _currentView.value;
  String get currentTitle => _currentTitle.value;

  final ValueNotifier<bool> showProfileNotifier = ValueNotifier(true);
  bool get showProfile => showProfileNotifier.value;

  bool _userWantsProfile = true;

  void toggleProfile() {
    showProfileNotifier.value = !showProfileNotifier.value;
    _userWantsProfile = showProfileNotifier.value;
  }

  void setProfileVisibility(bool isVisible,
      {bool isResponsiveTrigger = false}) {
    if (isResponsiveTrigger) {
      if (!isVisible) {
        showProfileNotifier.value = false;
      } else {
        showProfileNotifier.value = _userWantsProfile;
      }
    } else {
      showProfileNotifier.value = isVisible;
    }
  }

  ViewService() {
    listenToReactiveValues([_currentView, _currentTitle]);
  }

  void resetToDefault() {
    _currentId = null;
    _currentView.value = const FraindHubView();
    _currentTitle.value = "Friends";
  }

  void setView(Widget view, {String title = "Friends", String? id}) {
    if (_currentId == id && _currentTitle.value == title) return;

    _currentId = id;
    _currentView.value = view;
    _currentTitle.value = title;
  }
}

import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view.dart';
import 'package:stacked/stacked.dart';

enum RightPanel { none, profile, activeNow }

class ViewService with ListenableServiceMixin {
  final _currentView = ReactiveValue<Widget>(const FraindHubView());
  final _currentTitle = ReactiveValue<String>("Friends");
  final _rightPanel = ReactiveValue<RightPanel>(RightPanel.activeNow);

  String? _currentId;
  String? get currentId => _currentId;
  set currentId(String? value) => _currentId = value;

  Widget get currentView => _currentView.value;
  String get currentTitle => _currentTitle.value;
  RightPanel get rightPanel => _rightPanel.value;
  ViewService() {
    _rightPanel.value =
        RightPanel.activeNow;  
    listenToReactiveValues([_currentView, _currentTitle, _rightPanel]);
  }

  void setView(Widget view, {String title = "Friends", String? id}) {
    if (_currentId == id && _currentTitle.value == title) return;

    _currentId = id;
    _currentView.value = view;
    _currentTitle.value = title;

    _rightPanel.value = id != null
        ? RightPanel.profile
        : RightPanel.activeNow;  
    notifyListeners();
  }
}

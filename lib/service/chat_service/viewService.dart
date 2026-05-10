import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view.dart';
import 'package:stacked/stacked.dart';

class ViewService with ListenableServiceMixin {
  final _currentView = ReactiveValue<Widget>(const FraindHubView());
  final _currentTitle = ReactiveValue<String>("Friends");

  // Getters
  Widget get currentView => _currentView.value;
  String get currentTitle => _currentTitle.value;

  ViewService() {
    listenToReactiveValues([_currentView, _currentTitle]);
  }

  void setView(Widget view, {String title = "Friends"}) {
    _currentView.value = view;
    _currentTitle.value = title;
    notifyListeners();
  }
}

// lib/services/view_service.dart
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_discord/ui/views/home/homeHub/fraindHub/fraind_hub_view.dart';

class ViewService with ListenableServiceMixin {
  // Shuru mein FraindHubView dikhao
  Widget _currentView = const FraindHubView();
  Widget get currentView => _currentView;

  ViewService() {
    listenToReactiveValues([_currentView]);
  }

  void setView(Widget view) {
    _currentView = view;
    notifyListeners();
  }
}

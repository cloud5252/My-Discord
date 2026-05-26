import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HoverViewModel extends BaseViewModel {
  bool _isHovered = false;
  bool get isHovered => _isHovered;

  void setHover(bool value) {
    _isHovered = value;
    notifyListeners();
  }
}

class HoverBuilder extends StatelessWidget {
  final Widget Function(bool isHovered) builder;

  const HoverBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HoverViewModel>.reactive(
      viewModelBuilder: () => HoverViewModel(),
      builder: (context, model, child) => MouseRegion(
        onEnter: (_) => model.setHover(true),
        onExit: (_) => model.setHover(false),
        child: builder(model.isHovered),
      ),
    );
  }
}

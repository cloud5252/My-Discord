import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/dmSide/widget/hover_builder.dart';
import 'package:stacked/stacked.dart';

class PressBuilder extends StatelessWidget {
  final Widget Function(bool isPressed) builder;
  final VoidCallback onTap;

  const PressBuilder({
    Key? key,
    required this.builder,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HoverViewModel>.reactive(
      viewModelBuilder: () => HoverViewModel(),
      builder: (context, model, child) => GestureDetector(
        onTap: onTap,
        onTapDown: (_) => model.setHover(true),
        onTapUp: (_) => model.setHover(false),
        onTapCancel: () => model.setHover(false),
        child: builder(model.isHovered),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/nitro_tab/nitro_view_model.dart';
import 'package:stacked/stacked.dart';

class NitroView extends StackedView<NitroViewModel> {
  const NitroView({super.key});

  @override
  Widget builder(
      BuildContext context, NitroViewModel viewmodel, Widget? child) {
    return const Center(
      child: Text('NitroView Tab'),
    );
  }

  @override
  NitroViewModel viewModelBuilder(BuildContext context) => NitroViewModel();
}

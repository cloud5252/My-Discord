import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/quests_tab/quests_view_model.dart';
import 'package:stacked/stacked.dart';

class QuestsView extends StackedView<QuestsViewModel> {
  const QuestsView({super.key});

  @override
  Widget builder(
      BuildContext context, QuestsViewModel viewmodel, Widget? child) {
    return const Center(
      child: Text('QuestsView Tab'),
    );
  }

  @override
  QuestsViewModel viewModelBuilder(BuildContext context) => QuestsViewModel();
}

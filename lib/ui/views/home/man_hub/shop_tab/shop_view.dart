import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/shop_tab/shop_view_model.dart';
import 'package:stacked/stacked.dart';

class ShopView extends StackedView<ShopViewModel> {
  const ShopView({super.key});

  @override
  Widget builder(BuildContext context, ShopViewModel viewmodel, Widget? child) {
    return const Center(
      child: Text('shop Tab'),
    );
  }

  @override
  ShopViewModel viewModelBuilder(BuildContext context) => ShopViewModel();
}

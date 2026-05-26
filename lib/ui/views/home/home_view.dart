import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/dmSide/dm_side_view.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view.dart';
import 'package:my_discord/ui/views/home/home_viewmodel.dart';
import 'package:my_discord/ui/views/home/widget/server_sidebar/server_sidebar_view.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF121214),
        toolbarHeight: 30,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: _tabtag(
          title: viewModel.appBarTitle,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: const Color(0xFF1E1F22),
            height: 1.5,
          ),
        ),
      ),
      backgroundColor: const Color(0xFF121214),
      body: Row(
        children: [
          const SizedBox(
            width: 50,
            child: ServerSidebar(),
          ),
          const SizedBox(
            width: 270,
            child: DmSideView(),
          ),
          Expanded(
            child: viewModel.currentView is SizedBox
                ? const FraindHubView()
                : viewModel.currentView,
          ),
          // const SizedBox(
          //   width: 270,
          //   child: ActiveNowPanel(),
          // ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

class _tabtag extends StatelessWidget {
  final String title;

  const _tabtag({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIconForTitle(title),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildIconForTitle(String title) {
    if (title == "Friends") {
      return const Icon(Icons.people_alt, color: Color(0xFF80848E), size: 20);
    } else if (title == "Nitro") {
      return const Icon(Icons.bolt, color: Color(0xFF80848E), size: 20);
    } else if (title == "Shop") {
      return const Icon(Icons.shopping_bag, color: Color(0xFF80848E), size: 20);
    } else {
      return const Text(
        '@',
        style: TextStyle(
          color: Color(0xFF80848E),
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
      );
    }
  }
}

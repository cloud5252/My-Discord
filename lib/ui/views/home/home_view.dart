import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/coversationHub/dmSide/dm_side_view.dart';
import 'package:my_discord/ui/views/home/homeHub/fraindHub/fraind_hub_view.dart';
import 'package:my_discord/ui/views/home/home_viewmodel.dart';
import 'package:my_discord/ui/views/home/homeHub/server_sidebar/server_sidebar_view.dart';
import 'package:my_discord/ui/views/home/widget/My_active_now_panel.dart';
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
        title: const _tabtag(),
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
          // 1. Server icons — 72px
          const SizedBox(
            width: 50,
            child: ServerSidebar(),
          ),

          // 2. DM Sidebar — 240px
          const SizedBox(
            width: 240,
            child: DmSideView(),
          ),

          // 3. Main Friends Panel — baaki sab
          Expanded(
            child: viewModel.currentView is SizedBox
                ? const FraindHubView() // ← default view
                : viewModel.currentView, // ← chat open hone pe yahan aayega
          ),

          // 4. Active Now Panel — 240px
          const SizedBox(
            width: 240,
            child: ActiveNowPanel(),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

class _tabtag extends StatelessWidget {
  const _tabtag();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.people_alt, color: Color(0xFFabacb2), size: 18),
        SizedBox(width: 8),
        Text(
          'Friends',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

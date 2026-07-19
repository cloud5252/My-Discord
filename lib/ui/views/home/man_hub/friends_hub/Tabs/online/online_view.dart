import 'package:flutter/material.dart';
import 'package:my_discord/models/user_model.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/Tabs/online/online_view_model.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/Tabs/online/user_online_Tile.dart';
import 'package:stacked/stacked.dart';

class OnlineView extends StackedView<OnlineViewModel> {
  const OnlineView({super.key});

  @override
  Widget builder(
      BuildContext context, OnlineViewModel viewModel, Widget? child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: StreamBuilder<List<UserModel>>(
            stream: viewModel.getUsersStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.white));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("No Users Found",
                      style: TextStyle(color: Colors.white)),
                );
              }

              final users = snapshot.data!;

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) =>
                    builduserlistitem(users[index], context, viewModel),
              );
            },
          ),
        )
      ],
    );
  }

  Widget builduserlistitem(
      UserModel user, BuildContext context, OnlineViewModel viewmodel) {
    return Material(
      child: UserOnlineTile(
        text: user.displayName.isNotEmpty ? user.displayName : user.username,
        status: user.status,
        ontap: () {
          print("Clicked on: ${user.displayName}");
        },
      ),
    );
  }

  @override
  OnlineViewModel viewModelBuilder(BuildContext context) => OnlineViewModel();
}

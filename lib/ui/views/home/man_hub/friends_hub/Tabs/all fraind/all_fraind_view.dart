import 'package:flutter/material.dart';
import 'package:my_discord/models/user_model.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/Tabs/all%20fraind/all_fraind_view_model.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/Tabs/all%20fraind/widget/userTile.dart';
import 'package:stacked/stacked.dart';

class AllFraindView extends StackedView<AllFraindViewModel> {
  const AllFraindView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, AllFraindViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
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
      ),
    );
  }

  Widget builduserlistitem(
      UserModel user, BuildContext context, AllFraindViewModel viewmodel) {
    return Material(
      child: Usertile(
        text: user.displayName.isNotEmpty ? user.displayName : user.username,
        ontap: () {
          print("Clicked on: ${user.displayName}");
        },
      ),
    );
  }

  @override
  AllFraindViewModel viewModelBuilder(BuildContext context) =>
      AllFraindViewModel();
}

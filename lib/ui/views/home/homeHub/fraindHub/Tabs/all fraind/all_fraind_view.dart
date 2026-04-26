import 'package:flutter/material.dart';
import 'package:my_discord/models/user_model.dart';
import 'package:my_discord/ui/views/home/homeHub/fraindHub/Tabs/all%20fraind/all_fraind_view_model.dart';
import 'package:my_discord/ui/views/home/homeHub/fraindHub/Tabs/all%20fraind/widget/userTile.dart';
import 'package:stacked/stacked.dart';

class AllFraindView extends StackedView<AllFraindViewModel> {
  const AllFraindView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, AllFraindViewModel viewModel, Widget? child) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              // onTap: () => viewModel.onSearchTap(),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF242C32),
                  borderRadius: BorderRadius.circular(25),
                ),
                // child: TextField(
                //   // focusNode: viewModel.searchFocusNode,
                //   autofocus: false,
                //   cursorColor: Colors.white,
                //   style: const TextStyle(color: Colors.white),
                //   decoration: const InputDecoration(
                //     hintText: 'Ask Meta AI or Search',
                //     hintStyle: TextStyle(color: whiteColor, fontSize: 16),
                //     prefixIcon: Icon(Icons.search, color: whiteColor),
                //     border: InputBorder.none,
                //     contentPadding: EdgeInsets.symmetric(vertical: 12),
                //   ),
                //   // onChanged: (value) => viewModel.onSearchChanged(value),
                // ),
              ),
            ),
          ),
          Expanded(child: geruserbuilder(viewModel))
        ],
      ),
    );
  }

  Widget geruserbuilder(AllFraindViewModel viewModel) {
    if (viewModel.isBusy) {
      return const Center(child: CircularProgressIndicator());
    }

    final contacts = viewModel.filteredContacts;

    if (contacts.isEmpty) return const Center(child: Text("No Contacts Found"));

    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) =>
          builduserlistitem(contacts[index], context, viewModel),
    );
  }

  Widget builduserlistitem(
      UserModel contact, BuildContext context, AllFraindViewModel viewmodel) {
    return Usertile(text: '', ontap: () {});
  }

  @override
  AllFraindViewModel viewModelBuilder(BuildContext context) =>
      AllFraindViewModel();
}

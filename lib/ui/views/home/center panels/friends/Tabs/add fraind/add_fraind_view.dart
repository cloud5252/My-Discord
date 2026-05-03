import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/center%20panels/friends/Tabs/add%20fraind/add_fraind_view_model.dart';
import 'package:stacked/stacked.dart';

class AddFraindView extends StackedView<AddFraindViewModel> {
  const AddFraindView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, AddFraindViewModel viewModel, Widget? child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Add Friend',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'You can add friends with their Discord usernames.',
            style: TextStyle(color: Color(0xFFB5BAC1), fontSize: 13),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                onChanged: viewModel.onInputChanged,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                cursorColor: Colors.white,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hoverColor: Colors.transparent,
                  fillColor: const Color(0xFF1E1F22),
                  filled: true,
                  hintText: 'You can add friends with their Discord usernames.',
                  hintStyle:
                      const TextStyle(color: Color(0xFF72767D), fontSize: 14),
                  contentPadding: const EdgeInsets.only(
                      left: 12, right: 100, top: 20, bottom: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Color(0xFF00A8FC), width: 1.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: (viewModel.inputValue.isEmpty)
                        ? null
                        : viewModel.sendFriendRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5865F2),
                      disabledBackgroundColor:
                          const Color(0xFF5a68ed).withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Send Friend Request',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        if (viewModel.feedbackMessage != null) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                viewModel.isSuccess
                    ? Icons.check_circle_outline
                    : Icons.error_outline,
                size: 16,
                color: viewModel.isSuccess
                    ? const Color(0xFF3BA55C)
                    : const Color(0xFFED4245),
              ),
              const SizedBox(width: 8),
              Text(
                viewModel.feedbackMessage!,
                style: TextStyle(
                  color: viewModel.isSuccess
                      ? const Color(0xFF3BA55C)
                      : const Color(0xFFED4245),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 10),
        Divider(
          color: Colors.grey.shade700,
          thickness: 0.5,
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Other Places to Make Friends',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Dont have a username on hand? Check out list of public servers that includes everything from gaming to cooking,music and more.',
            style: TextStyle(color: Color(0xFFB5BAC1), fontSize: 13),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  AddFraindViewModel viewModelBuilder(BuildContext context) =>
      AddFraindViewModel();
}

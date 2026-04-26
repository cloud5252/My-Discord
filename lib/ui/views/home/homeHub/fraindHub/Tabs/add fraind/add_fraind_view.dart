import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/homeHub/fraindHub/Tabs/add%20fraind/add_fraind_view_model.dart';
import 'package:stacked/stacked.dart';

class AddFraindView extends StackedView<AddFraindViewModel> {
  const AddFraindView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, AddFraindViewModel viewModel, Widget? child) {
    return Container(
      color: const Color(0xFF36393F),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Header ───────────────────────────────────
          const Text(
            'Add Friend',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'You can add friends with their username or email.',
            style: TextStyle(
              color: Color(0xFF80848E),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),

          // ─── Input + Button ───────────────────────────
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2B2D31),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'User Name',
                  style: TextStyle(
                    color: Color(0xFF80848E),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Input field
                    Expanded(
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1F22),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: TextField(
                          onChanged: viewModel.onInputChanged,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          cursorColor: const Color(0xFF5865F2),
                          decoration: const InputDecoration(
                            hintText: 'Enter Username ',
                            hintStyle: TextStyle(
                                color: Color(0xFF80848E), fontSize: 14),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Send button
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: viewModel.inputValue.trim().isEmpty ||
                                viewModel.isBusy
                            ? null
                            : () => viewModel.sendFriendRequest(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5865F2),
                          disabledBackgroundColor: const Color(0xFF4752C4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: viewModel.isBusy
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Send Friend Request',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              ),
                      ),
                    ),
                  ],
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
                      const SizedBox(width: 6),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  AddFraindViewModel viewModelBuilder(BuildContext context) =>
      AddFraindViewModel();
}

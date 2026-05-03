import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/sidebar/dmSide/dm_side_view_model.dart';
import 'package:stacked/stacked.dart';

class DmSideFraindWidget extends ViewModelWidget<DmSideViewModel> {
  const DmSideFraindWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DmSideViewModel viewModel) {
    if (viewModel.isBusy) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
        ),
      );
    }

    if (viewModel.data == null || viewModel.data!.isEmpty) {
      return const Center(
        child: Text(
          'No friends yet.',
          style: TextStyle(color: Color(0xFFB5BAC1)),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.data!.length,
      itemBuilder: (context, index) {
        final friend = viewModel.data![index];
        return _buildFriendTile(friend, viewModel);
      },
    );
  }

  Widget _buildFriendTile(
      Map<String, dynamic> friend, DmSideViewModel viewModel) {
    bool isOnline = friend['status'] == 'online';

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ListTile(
          onTap: () => viewModel.navigateToChat(friend),
          mouseCursor: SystemMouseCursors.click,
          hoverColor: const Color(0xFF35373C),
          splashColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          visualDensity: const VisualDensity(vertical: -3),
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          leading: Stack(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF5865F2),
                child: Icon(Icons.person, color: Colors.white, size: 18),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isOnline ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFF2B2D31), width: 2),
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            friend['contactName'] ?? 'Unknown',
            style: const TextStyle(
                color: Color(0xFFDBDEE1),
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

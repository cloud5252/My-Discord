import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/center%20panels/friends/Tabs/pending/pending_view_model.dart';
import 'package:my_discord/ui/views/home/center%20panels/friends/Tabs/pending/widget/pending_request_tile.dart';
import 'package:stacked/stacked.dart';

class PendingView extends StackedView<PendingViewModel> {
  const PendingView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, PendingViewModel viewModel, Widget? child) {
    if (viewModel.isBusy) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF5865F2)),
      );
    }

    final hasNothing = viewModel.incomingRequests.isEmpty &&
        viewModel.outgoingRequests.isEmpty;

    if (hasNothing) {
      return const Center(
        child: Text('No pending requests',
            style: TextStyle(color: Color(0xFF80848E), fontSize: 15)),
      );
    }

    return ListView(
      children: [
        // Incoming section
        if (viewModel.incomingRequests.isNotEmpty) ...[
          _SectionLabel('Incoming — ${viewModel.incomingRequests.length}'),
          ...viewModel.incomingRequests.map(
            (r) => PendingRequestTile(
              request: r,
              isIncoming: true,
              onAccept: viewModel.acceptRequest,
              onReject: viewModel.rejectRequest,
            ),
          ),
        ],

        // Outgoing section
        if (viewModel.outgoingRequests.isNotEmpty) ...[
          _SectionLabel('Outgoing — ${viewModel.outgoingRequests.length}'),
          ...viewModel.outgoingRequests.map(
            (r) => PendingRequestTile(
              request: r,
              isIncoming: false,
              onCancel: viewModel.cancelRequest,
            ),
          ),
        ],
      ],
    );
  }

  @override
  PendingViewModel viewModelBuilder(BuildContext context) => PendingViewModel();
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFF80848E),
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

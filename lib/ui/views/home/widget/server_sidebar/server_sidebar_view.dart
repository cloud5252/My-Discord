import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/widget/server_sidebar/server_sidebar_viewModel.dart';
import 'package:stacked/stacked.dart';

class ServerSidebar extends StatelessWidget {
  const ServerSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ServerSidebarViewmodel>.reactive(
      viewModelBuilder: () => ServerSidebarViewmodel(),
      builder: (context, viewModel, child) {
        return Container(
          child: Column(
            children: [
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  await viewModel.logoutTesting();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF121214),
                    shape: BoxShape.circle,
                  ),
                  child: viewModel.isBusy
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        )
                      : const Icon(Icons.discord,
                          color: Colors.white, size: 30),
                ),
              ),
              const SizedBox(height: 12),

              // Placeholder for Servers (Circle Icons)
              Expanded(
                child: ListView.separated(
                  itemCount: 3,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF36373D),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

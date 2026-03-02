import 'package:flutter/material.dart';

import '../../../providers/theme_color_provider.dart';
import '../../../theme/theme.dart';
import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final status = controller.status;
        final progress = controller.progress;
        final resource = controller.ressource;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // File icon
              Icon(Icons.insert_drive_file, color: AppColors.neutral, size: 36),
              const SizedBox(width: 12),

              // Name + size + progress bar
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resource.name,
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.text,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${resource.size} MB',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.textLight,
                        fontSize: 14,
                      ),
                    ),
                    if (status == DownloadStatus.downloading) ...
                      [
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: progress,
                          backgroundColor: AppColors.greyLight,
                          color: themeColorService.color,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${(progress * 100).toInt()}%',
                          style: AppTextStyles.label.copyWith(
                            fontSize: 12,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Action button
              _buildActionButton(status),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButton(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.notDownloaded:
        return IconButton(
          icon: Icon(Icons.download, color: themeColorService.color, size: 28),
          onPressed: controller.startDownload,
        );
      case DownloadStatus.downloading:
        return SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(
            value: controller.progress,
            strokeWidth: 3,
            color: themeColorService.color,
          ),
        );
      case DownloadStatus.downloaded:
        return Icon(Icons.check_circle, color: Colors.green, size: 28);
    }
  }
}

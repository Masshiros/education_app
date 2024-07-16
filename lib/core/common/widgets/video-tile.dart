
import 'dart:io';

import 'package:education_app/core/common/widgets/time-tile.dart';
import 'package:education_app/core/extensions/string.extension.dart';
import 'package:education_app/core/global/colours.dart';
import 'package:education_app/core/global/media.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.entities.dart';
import 'package:education_app/src/course/features/videos/presentation/utils/video-utils.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  const VideoTile(
    this.video, {
    super.key,
    this.tappable = false,
    this.uploadTimePrefix = 'Uploaded',
    this.isFile = false,
  });

  final Video video;
  final bool tappable;
  final bool isFile;
  final String uploadTimePrefix;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 108,
      child: Row(
        children: [
          GestureDetector(
            onTap: tappable
                ? () => VideoUtils.playVideo(context, video.videoURL)
                : null,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: 108,
                  width: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: video.thumbnail == null
                          ? const AssetImage(MediaRes.thumbnailPlaceholder)
                          : isFile
                              ? FileImage(File(video.thumbnail!))
                              : NetworkImage(video.thumbnail!) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                if (tappable)
                  Container(
                    height: 108,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.black.withOpacity(.3),
                    ),
                    child: Center(
                      child: video.videoURL.isYoutubeVideo
                          ? Image.asset(MediaRes.youtube, height: 40)
                          : const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    video.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'By ${video.tutor}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colours.neutralTextColour,
                    ),
                  ),
                ),
                Flexible(
                  child: TimeTile(
                    video.uploadDate,
                    prefixText: uploadTimePrefix,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
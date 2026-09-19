import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/web.dart' as web;
import 'package:portfolio/core/constants/app_color.dart';

/// Matches youtube.com/watch?v=, youtu.be/, youtube.com/embed/ and
/// youtube.com/v/ links, ignoring any trailing playlist/tracking params —
/// the only part that matters is the 11-char video id.
final _youtubeIdPattern = RegExp(
  r'(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
);

String? extractYoutubeId(String url) => _youtubeIdPattern.firstMatch(url)?.group(1);

/// A project's demo video, shown as a clickable thumbnail that swaps itself
/// for a real embedded, autoplaying player on tap — so watching the demo
/// never has to leave the page. Falls back to opening the link in a new tab
/// for anything that isn't a recognizable YouTube URL.
class VideoPreviewCard extends StatefulWidget {
  final String videoUrl;

  const VideoPreviewCard({super.key, required this.videoUrl});

  @override
  State<VideoPreviewCard> createState() => _VideoPreviewCardState();
}

class _VideoPreviewCardState extends State<VideoPreviewCard> {
  // Keyed by video id so navigating away and back to the same project
  // doesn't try to register the same platform view twice.
  static final Set<String> _registeredViewTypes = {};

  bool _playing = false;
  bool _hovering = false;
  String? _viewType;

  String? get _youtubeId => extractYoutubeId(widget.videoUrl);

  void _play() {
    final id = _youtubeId;
    if (id == null) {
      launchUrl(Uri.parse(widget.videoUrl), mode: LaunchMode.externalApplication);
      return;
    }
    final viewType = 'youtube-embed-$id';
    if (_registeredViewTypes.add(viewType)) {
      ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
        final iframe = web.HTMLIFrameElement()
          ..src = 'https://www.youtube.com/embed/$id?autoplay=1&rel=0'
          ..allow = 'autoplay; encrypted-media; picture-in-picture; fullscreen'
          ..allowFullscreen = true;
        iframe.style
          ..border = 'none'
          ..width = '100%'
          ..height = '100%';
        return iframe;
      });
    }
    setState(() {
      _viewType = viewType;
      _playing = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: _playing && _viewType != null
            ? HtmlElementView(viewType: _viewType!)
            : _buildThumbnail(),
      ),
    );
  }

  Widget _buildThumbnail() {
    final id = _youtubeId;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: _play,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (id != null)
              // hqdefault is guaranteed to exist for every video; maxres
              // isn't (only videos uploaded in HD get one), and a broken
              // thumbnail here would look worse than a slightly softer one.
              Image.network(
                'https://img.youtube.com/vi/$id/hqdefault.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.section, AppColors.bgSecondary],
                    ),
                  ),
                ),
              )
            else
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.section, AppColors.bgSecondary],
                  ),
                ),
              ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              color: Colors.black.withValues(alpha: _hovering ? 0.25 : 0.4),
            ),
            Center(
              child: AnimatedScale(
                scale: _hovering ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(
                          alpha: _hovering ? 0.55 : 0.35,
                        ),
                        blurRadius: _hovering ? 30 : 18,
                        spreadRadius: _hovering ? 2 : 0,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.black,
                    size: 38,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 18,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.smart_display_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    id != null ? 'Watch demo video' : 'Open demo video',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

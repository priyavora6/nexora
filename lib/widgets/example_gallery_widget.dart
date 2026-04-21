import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ExampleGalleryWidget extends StatefulWidget {
  final List<String> exampleUrls;
  final double height;
  final bool showIndicator;
  final BorderRadius? borderRadius;

  const ExampleGalleryWidget({
    Key? key,
    required this.exampleUrls,
    this.height = 300,
    this.showIndicator = true,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<ExampleGalleryWidget> createState() => _ExampleGalleryWidgetState();
}

class _ExampleGalleryWidgetState extends State<ExampleGalleryWidget> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.exampleUrls.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        // Gallery
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.exampleUrls.length,
            itemBuilder: (context, index) {
              final url = widget.exampleUrls[index];
              return _buildGalleryItem(url, index);
            },
          ),
        ),

        // Page Indicators
        if (widget.showIndicator && widget.exampleUrls.length > 1)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: _buildPageIndicator(),
          ),
      ],
    );
  }

  Widget _buildGalleryItem(String url, int index) {
    return GestureDetector(
      onTap: () => _openFullscreen(index),
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (context, url) => _buildLoadingPlaceholder(),
          errorWidget: (context, url, error) => _buildErrorWidget(),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.exampleUrls.length,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? Theme.of(context).primaryColor
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      color: Colors.grey.shade100,
      child: const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image_outlined, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 8),
          Text(
            'Failed to load image',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported_outlined, size: 48, color: Colors.grey.shade300),
          const SizedBox(height: 8),
          Text(
            'No preview available',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _openFullscreen(int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _FullscreenGallery(
          exampleUrls: widget.exampleUrls,
          initialIndex: initialIndex,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// FULLSCREEN GALLERY VIEW (IMAGE ONLY)
// ═══════════════════════════════════════════════

class _FullscreenGallery extends StatefulWidget {
  final List<String> exampleUrls;
  final int initialIndex;

  const _FullscreenGallery({
    Key? key,
    required this.exampleUrls,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<_FullscreenGallery> createState() => _FullscreenGalleryState();
}

class _FullscreenGalleryState extends State<_FullscreenGallery> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          '${_currentIndex + 1} / ${widget.exampleUrls.length}',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: PhotoViewGallery.builder(
        pageController: _pageController,
        itemCount: widget.exampleUrls.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        builder: (context, index) {
          final url = widget.exampleUrls[index];

          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(url),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2.5,
            heroAttributes: PhotoViewHeroAttributes(tag: 'example_$index'),
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        loadingBuilder: (context, event) => const Center(
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
        ),
      ),
    );
  }
}
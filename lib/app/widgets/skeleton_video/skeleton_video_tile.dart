import 'package:flutter/material.dart';
import 'package:naprimer_app_v2/app/styling/app_colors.dart';

final _startColor = HexColor.fromHex('#222222');
final _endColor = HexColor.fromHex('#333333');

class SkeletonVideoTile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SkeletonVideTileState();
  }
}

class _SkeletonVideTileState extends State<SkeletonVideoTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    final curved =
        CurvedAnimation(curve: Curves.easeInQuad, parent: _animController);
    _colorAnimation =
        ColorTween(begin: _startColor, end: _endColor).animate(curved);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (mounted) {
        _animController.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _animController.stop();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        return Container(
          width: 164,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildPlaceholderCircle(),
                  const SizedBox(width: 8),
                  _buildPlaceholderLabelShort()
                ],
              ),
              const SizedBox(height: 12),
              _buildPlaceholderVideoContainer(),
              const SizedBox(height: 12),
              _buildPlaceholderLabelLong(),
              const SizedBox(
                height: 4,
              ),
              _buildPlaceholderLabelShort()
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlaceholderVideoContainer() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: _colorAnimation.value,
      ),
    );
  }

  Widget _buildPlaceholderCircle() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: _colorAnimation.value,
      ),
    );
  }

  Widget _buildPlaceholderLabelLong() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: _colorAnimation.value,
      ),
      height: 16,
      width: 133,
    );
  }

  Widget _buildPlaceholderLabelShort() {
    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _colorAnimation.value,
        ),
        height: 16,
        width: 93,
      ),
    );
  }
}

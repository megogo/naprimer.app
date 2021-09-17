import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naprimer_app_v2/app/config/video_tiles_config.dart';
import 'package:naprimer_app_v2/app/widgets/skeleton_video/skeleton_video_tile.dart';

class SkeletonVideoTileGrid {
  static Widget sliverGrid({int elementsCount = 10}) {
    return _SkeletonVideoTileGridSliver(elementsCount: elementsCount);
  }

  static Widget defaultGrid({
    int elementsCount = 10,
    EdgeInsetsGeometry? padding,
  }) {
    return _SkeletonVideoTileGrid(
        elementsCount: elementsCount, padding: padding);
  }
}

class _SkeletonVideoTileGridSliver extends StatelessWidget {
  final int elementsCount;

  _SkeletonVideoTileGridSliver({this.elementsCount = 10});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: videoTilesGridCellsCount,
        crossAxisSpacing: videoTilesGridHorizontalSpacing,
        childAspectRatio: getVideoTilesGridChildAspectRatio(
            MediaQuery.of(context).size.width),
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Center(
            child: SkeletonVideoTile(),
          );
        },
        childCount: elementsCount,
      ),
    );
  }
}

class _SkeletonVideoTileGrid extends StatelessWidget {
  final int elementsCount;
  final EdgeInsetsGeometry? padding;

  _SkeletonVideoTileGrid({this.elementsCount = 10, this.padding});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: videoTilesGridCellsCount,
        crossAxisSpacing: videoTilesGridHorizontalSpacing,
        childAspectRatio: getVideoTilesGridChildAspectRatio(
            MediaQuery.of(context).size.width),
        semanticChildCount: elementsCount,
        children: List.generate(
            elementsCount,
            (index) => Padding(
                  padding: padding ?? EdgeInsets.zero,
                  child: Center(child: SkeletonVideoTile()),
                )));
  }
}

const videoTilesGridCellsCount = 2;
const videoTilesGridCellHeight = 387;
const videoTilesGridHorizontalSpacing = 16.0;
const videoTilesGridVerticalSpacing = 16.0;


double getVideoTilesGridChildAspectRatio(double width) {
  return width <= 0
      ? 1
      : ((width - videoTilesGridHorizontalSpacing) /
      videoTilesGridCellsCount /
      videoTilesGridCellHeight);
}
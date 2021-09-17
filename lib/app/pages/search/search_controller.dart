import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/app_controller.dart';
import 'package:naprimer_app_v2/app/pages/profile/general/general_profile_controller.dart';
import 'package:naprimer_app_v2/app/routing/pages.dart';
import 'package:naprimer_app_v2/data/video/search_videos_response.dart';
import 'package:naprimer_app_v2/data/video/video_item.dart';
import 'package:naprimer_app_v2/services/video/video_controller.dart';

enum SearchState { INITIAL, LOADING, NOTHING_FOUND, FOUND }

class SearchController extends GetxController {
  late AppController _appController;
  late VideoController _videoController;
  late SearchState _stateOfView;
  late List<VideoItem> _videosList;
  late bool _isLoading;
  late TextEditingController _searchTextController;
  late FocusNode _searchFocusNode;
  late bool _isShowCancelButton;
  late bool _isShowClearButton;
  late bool _isSearchReachedEnd;
  String? _searchNextCursor;

  Timer? _debounceTimer;

  VideoController get videoController => _videoController;

  bool get isUserAuth => _appController.user != null;

  bool get isLoading => _isLoading;

  bool get isShowClearButton => _isShowClearButton;

  bool get isShowCancelButton => _isShowCancelButton;

  SearchState get stateOfView => _stateOfView;

  List<VideoItem> get videosList => _videosList;

  TextEditingController get searchTextController => _searchTextController;

  FocusNode get searchFocusNode => _searchFocusNode;

  String? get userId => _appController.user?.id;

  @override
  void onInit() {
    _appController = Get.find<AppController>();
    _videoController = Get.find<VideoController>();
    _stateOfView = SearchState.INITIAL;
    _videosList = [];
    _isLoading = false;
    _searchTextController = TextEditingController();
    _searchTextController.addListener(_onTextChangeListener);
    _searchFocusNode = FocusNode();
    _searchFocusNode.addListener(_searchFocusListener);
    _isShowCancelButton = false;
    _isShowClearButton = false;
    _isSearchReachedEnd = false;
    super.onInit();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onTextChangeListener() {
    _isShowClearButton = _searchTextController.text.isNotEmpty;
    update();
    if (_searchTextController.text.isNotEmpty) {
      _stateOfView = SearchState.LOADING;
      update();
      if (_debounceTimer?.isActive ?? false) {
        _debounceTimer!.cancel();
      }
      _debounceTimer = Timer(Duration(seconds: 1), () async {
        await _searchVideos(text: _searchTextController.text);
        changeState();
        update();
      });
    } else {
      _stateOfView = SearchState.INITIAL;
      dropTimerAndClearSearchResult();
    }
  }

  Future<void> _searchVideos({required String text, String? next}) async {
    if (next == null) _videosList = [];

    SearchVideosResponse response = await _videoController.searchVideos(
        text: _searchTextController.text, next: _searchNextCursor);
    _searchNextCursor = response.next;
    print(_searchNextCursor);
    _isSearchReachedEnd = _searchNextCursor == null;

    if (_searchNextCursor == null) {
      _videosList = response.videos;
    } else {
      _videosList.addAll(response.videos);
    }
  }

  Future<void> searchMore() async {
    if (!_isSearchReachedEnd) {
      await _searchVideos(
          text: _searchTextController.text, next: _searchNextCursor);
      update();
    }
  }

  void _searchFocusListener() {
    _isShowCancelButton = _searchFocusNode.hasFocus;
  }

  void changeState() {
    if (_videosList.isEmpty) {
      _stateOfView = SearchState.NOTHING_FOUND;
    } else {
      _stateOfView = SearchState.FOUND;
    }
  }

  void onClearPressed() {
    _searchTextController.clear();
    dropTimerAndClearSearchResult();
  }

  void onCancelPressed() {
    _searchTextController.clear();
    _searchFocusNode.unfocus();
    dropTimerAndClearSearchResult();
  }

  void dropTimerAndClearSearchResult() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }
    _searchNextCursor = null;
    _isSearchReachedEnd = false;
    _videosList.clear();
    update();
  }

  void onProfilePressed(String authorId){
    if(_appController.user == null){
      Get.toNamed(Routes.GENERAL_PROFILE, id: SearchPages.navigatorKeyId,
          arguments: GeneralProfileArguments(authorId));
    }else{
      if(_appController.user!.id != authorId){
        Get.toNamed(Routes.GENERAL_PROFILE, id: SearchPages.navigatorKeyId,
            arguments: GeneralProfileArguments(authorId));
      }
    }
  }
}

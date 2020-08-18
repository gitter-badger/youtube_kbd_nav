import 'dart:html' show AnchorElement, document, Element;

import 'package:meta/meta.dart' show required;

class Ui {
  List<Element> _elements;
  int _currentIndex;

  Ui({@required String tags}) : _elements = document.querySelectorAll(tags);

  void addBorder({@required int currentIndex}) {
    _currentIndex = currentIndex;
    _deleteNeighborsStyles();
    _changeCurrentThumbnailStyle();
  }

  Element get _currentThumbnail => _elements[_currentIndex];

  String get thumbnailLink {
    final AnchorElement anchorElement = _currentThumbnail?.querySelector('a');
    return anchorElement?.href;
  }

  void resetCurrent() {
    _currentThumbnail?.attributes?.remove('style');
    _currentIndex = null;
  }

  void _changeCurrentThumbnailStyle() {
    if (_currentIndex >= 0) {
      _currentThumbnail.style.outline = 'red solid';
      _currentThumbnail.style.outlineOffset = '-1px';
    }
  }

  void _deleteNeighborsStyles() {
    final List<int> neighborsIndices = [_currentIndex - 1, _currentIndex + 1];

    neighborsIndices.forEach((int neighborIndex) {
      _neighborIndexInValidRange(neighborIndex)
          ? _elements[neighborIndex].attributes.remove('style')
          : null;
    });
  }

  bool _neighborIndexInValidRange(int neighborIndex) =>
      neighborIndex >= 0 && neighborIndex < _elements.length;

  /// The [query] parameter is here for 2 reasons:
  ///
  /// 1. The HTML hierarchy changes when you're signed or not apparently.
  /// 1. With a parameter, we can inject a simpler tag when testing.
  void subscribe(
      {String query = '#subscribe-button.style-scope > '
          'ytd-subscribe-button-renderer > '
          'paper-button'}) {
    final Element subscribeButton = document.querySelector(query);

    subscribeButton?.click();
  }

  /// Check out the [subscribe] method for more info.
  void like(
      {String query =
          'ytd-menu-renderer > ' 'div > ' 'ytd-toggle-button-renderer'}) {
    final Element likeButton = document.querySelectorAll(query)[0];

    likeButton?.click();
  }

  /// Check out the [subscribe] method for more info.
  void dislike(
      {String query =
          'ytd-menu-renderer > ' 'div > ' 'ytd-toggle-button-renderer'}) {
    final Element dislikeButton = document.querySelectorAll(query)[1];

    dislikeButton?.click();
  }
}

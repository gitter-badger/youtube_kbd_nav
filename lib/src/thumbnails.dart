import 'dart:html' show AnchorElement, Document, document, Element;

import 'package:meta/meta.dart' show required;

class Thumbnails {
  List<Element> _thumbnails;
  int _currentIndex;

  /// [doc] is a parameter mainly for injecting a [Document] during tests.
  Thumbnails({@required String tags, Document doc})
      : _thumbnails = (doc ?? document).querySelectorAll(tags);

  void addBorder({@required int index}) {
    _currentIndex = index;
    _deleteNeighborsStyles();
    _changeCurrentThumbnailStyle();
    _currentThumbnail?.scrollIntoView();
  }

  void _deleteNeighborsStyles() {
    final List<int> neighborsIndices = [_currentIndex - 1, _currentIndex + 1];

    neighborsIndices.forEach((int neighborIndex) {
      if (_neighborIndexInValidRange(neighborIndex))
        _thumbnails[neighborIndex].attributes.remove('style');
    });
  }

  bool _neighborIndexInValidRange(int neighborIndex) =>
      neighborIndex >= 0 && neighborIndex < _thumbnails.length;

  void _changeCurrentThumbnailStyle() {
    if (_currentIndex >= 0) {
      _currentThumbnail.style.outline = 'red solid';
      _currentThumbnail.style.outlineOffset = '-1px';
    }
  }

  Element get _currentThumbnail => (_currentIndex != null && _currentIndex >= 0)
      ? _thumbnails[_currentIndex]
      : null;

  void resetCurrentThumbnail() {
    _currentThumbnail?.attributes?.remove('style');
    _currentIndex = null;
  }

  String get thumbnailLink {
    final AnchorElement anchorElement = _currentThumbnail?.querySelector('a');
    return anchorElement?.href;
  }
}

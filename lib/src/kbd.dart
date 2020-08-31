import 'dart:html' show document, Element, KeyboardEvent, window;

import 'cycler.dart' show Cycler;
import 'ui.dart' show Ui;
import 'url_handler.dart' show UrlHandler;

class Kbd {
  Cycler _cycler;
  String _url = '';
  Ui _ui = Ui(tags: 'watch');
  KeyboardEvent _keyboardEvent;

  /// The [Cycler] is a parameter just so we can inject it during testing and
  /// check if everything happened as expected.
  Kbd({Cycler cycler}) : _cycler = cycler ?? Cycler() {
    window.addEventListener('yt-navigate-start', (_) => resetStylesAndCycler());
    document.onKeyDown.listen((KeyboardEvent keyboardEvent) {
      _keyboardEvent = keyboardEvent;
      _onKeyDown(newUrl: document.baseUri);
    });
  }

  void resetStylesAndCycler() {
    _ui?.resetCurrentThumbnail();
    _cycler = Cycler();
  }

  Future<void> _onKeyDown({String newUrl = ''}) async {
    _resetCyclerIfUrlChange(newUrl);
    await _keySwitch();
  }

  void _resetCyclerIfUrlChange(String newUrl) {
    if (newUrl != _url) {
      _url = newUrl;
      _cycler = Cycler();
    }
  }

  Element get _searchBar => document.querySelector('input#search');
  Element get _commentBox => document.querySelectorAll(_commentBoxQuery)[0];
  Element get _editCommentBox => document.querySelectorAll(_commentBoxQuery)[1];
  String get _commentBoxQuery => 'yt-formatted-string.ytd-commentbox > div';

  bool get _noInputFocus => !(_searchBar == document.activeElement ||
      _commentBox == document.activeElement ||
      _editCommentBox == document.activeElement);

  Future<void> _keySwitch() async {
    if (_noInputFocus) {
      switch (_keyboardEvent.key) {
        case 'z':
          _cycler.forwards();
          _addBorder();
          break;
        case 'x':
          _cycler.backwards();
          _addBorder();
          break;
        case 'q':
          _navigate(UrlHandler.youtubeHome);
          break;
        case 'Enter':
          if (_cycler.total >= 0) {
            _navigate(_ui?.thumbnailLink);
          }
          break;
        case 'h':
          _navigate(UrlHandler.history);
          break;
        case 'e':
          if (_isVideo) _ui?.subscribe();
          break;
        case 'v':
          if (_isVideo) _ui?.like();
          break;
        case 'n':
          if (_isVideo) _ui?.dislike();
          break;
        case 'b':
          if (_isVideo)
            await window.navigator.clipboard
                .writeText(UrlHandler.shortenLink(_url));
          break;
        case 'y':
          _ui?.notiticationPopUp();
          break;
        default:
      }
    }
  }

  bool get _isVideo => _url.contains('watch');

  void _addBorder() {
    if (_url != null) {
      final String tags = UrlHandler.tags(_url);
      _ui = Ui(tags: tags);
      _ui.addBorder(currentIndex: _cycler.total);
    }
  }

  void _navigate(String url) {
    final bool key = window.navigator.appVersion.contains('Mac')
        ? _keyboardEvent.metaKey
        : _keyboardEvent.ctrlKey;

    key ? window.open(url, '_blank', 'noreferrer') : window.location.href = url;
  }
}

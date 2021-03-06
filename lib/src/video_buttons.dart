import 'dart:html' show Document, document, Element;

class VideoButtons {
  final Document _document;

  /// [doc] is a parameter mainly for injecting a [Document] during tests.
  VideoButtons({Document doc}) : _document = doc ?? document;

  void subscribe() {
    const String subscribeQuery = '#subscribe-button.style-scope > '
        'ytd-subscribe-button-renderer > paper-button';
    final Element subscribeButton = _document.querySelector(subscribeQuery);
    subscribeButton?.click();
  }

  void like() {
    final Element likeButton =
        _document.querySelectorAll(_likeDislikeButtonsQuery).first;
    likeButton?.click();
  }

  static const String _likeDislikeButtonsQuery = 'ytd-menu-renderer > div > '
      'ytd-toggle-button-renderer > a > yt-icon-button > button';

  void dislike() {
    final Element dislikeButton =
        _document.querySelectorAll(_likeDislikeButtonsQuery).last;
    dislikeButton?.click();
  }

  void notiticationPopUp() {
    const String notificationPopUpButtonQuery =
        'ytd-notification-topbar-button-renderer > '
        'div > a > yt-icon-button > button';
    final Element notificationPopUpButton =
        _document.querySelector(notificationPopUpButtonQuery);
    notificationPopUpButton?.click();
  }

  /// This has not been incorporated via TDD.
  void commentBoxFocus() {
    final Element commentBox =
        _document.getElementById('simplebox-placeholder');
    commentBox?.focus();
  }
}

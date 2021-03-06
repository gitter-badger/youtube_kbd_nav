import 'dart:html' show Document, DomParser, Element;

import 'package:test/test.dart' show expect, setUp, test;

import 'package:youtube_kbd_nav/src/video_buttons.dart' show VideoButtons;

void main() {
  final Document document =
      DomParser().parseFromString(buttonsHtmlAsString, 'text/html');

  VideoButtons videoButtons;

  setUp(() => videoButtons = VideoButtons(doc: document));

  test('Subscribe', () {
    ChangesOnClick changesOnSubscribe;

    final Element subscribeButton = document.querySelector('paper-button');

    subscribeButton.onClick
        .listen((_) => changesOnSubscribe = ChangesOnClick.subscribed);

    videoButtons.subscribe();

    expect(changesOnSubscribe, ChangesOnClick.subscribed);
  });

  test('Like', () {
    ChangesOnClick changesOnLike;

    final Element likeButton = document.querySelectorAll('button')[0];

    likeButton.onClick.listen((_) => changesOnLike = ChangesOnClick.like);

    videoButtons.like();

    expect(changesOnLike, ChangesOnClick.like);
  });

  test('Dislike', () {
    ChangesOnClick changesOnDislike;

    final Element dislikeButton = document.querySelectorAll('button')[1];

    dislikeButton.onClick
        .listen((_) => changesOnDislike = ChangesOnClick.dislike);

    videoButtons.dislike();

    expect(changesOnDislike, ChangesOnClick.dislike);
  });

  test('Notification Pop Up', () {
    ChangesOnClick changesOnNotificationPopUp;

    final Element notificationButton = document.querySelectorAll('button')[2];

    notificationButton.onClick.listen(
        (_) => changesOnNotificationPopUp = ChangesOnClick.notificationPopUp);

    videoButtons.notiticationPopUp();

    expect(changesOnNotificationPopUp, ChangesOnClick.notificationPopUp);
  });
}

enum ChangesOnClick {
  subscribed,
  like,
  dislike,
  notificationPopUp,
}

const String buttonsHtmlAsString = '''
  <div id="subscribe-button" class="style-scope">
    <ytd-subscribe-button-renderer>
      <paper-button>
    </ytd-subscribe-button-renderer>
  </div>

  <ytd-menu-renderer>
    <div>
      <ytd-toggle-button-renderer>
        <a>
          <yt-icon-button>
            <button></button>
          </yt-icon-button>
        </a>
      </ytd-toggle-button-renderer>
      <ytd-toggle-button-renderer>
        <a>
          <yt-icon-button>
            <button></button>
          </yt-icon-button>
        </a>
      </ytd-toggle-button-renderer>
    </div>
  </ytd-menu-renderer>

  <ytd-notification-topbar-button-renderer>
    <div>
      <a>
        <yt-icon-button>
          <button></button>
        </yt-icon-button>
      </a>
    </div>
  </ytd-notification-topbar-button-renderer>
''';

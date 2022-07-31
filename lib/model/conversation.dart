import 'package:event_bus/event_bus.dart';
import 'chat_base.dart';
import 'contacts.dart';
import 'events.dart';

enum Device { mac, win }

enum ConversationType { user, group, account }

class Conversation<T extends ChatBase> {
  const Conversation(
    this.entity, {
    this.type = ConversationType.user,
    this.lastMessage,
    required this.updateAt,
    this.isMute = false,
    this.unreadMsgCount = 0,
    this.displayDot = false,
  });

  final String? lastMessage;
  final String updateAt;
  final bool isMute;
  final int unreadMsgCount;
  final bool displayDot;
  final ConversationType type;
  final T entity;

  bool isAvatarFromNet() {
    if (entity.avatar.indexOf('http') == 0 ||
        entity.avatar.indexOf('https') == 0) {
      return true;
    }
    return false;
  }
}

class ConversationPageData extends EventBus {
  Device device;
  List<Conversation> conversations = [];

  ConversationPageData({
    required this.device,
    required this.conversations,
  });

  mockData() async {
    ContactsPageData contacts = ContactsPageData.mock();
    contacts.on<DataChangeEvent>().listen(generateConversation);
    generateConversation(DataChangeEvent(contacts.contacts));
  }

  generateConversation(DataChangeEvent event) {}

  static mock() {
    if (mocked == null) {
      mocked = ConversationPageData(device: Device.mac, conversations: []);
      mocked!.mockData();
    }
    return mocked;
  }

  static ConversationPageData? mocked;
}

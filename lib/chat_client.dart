import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:event_bus/event_bus.dart';

import 'constants.dart';
import 'service/logger.dart';

abstract class Event {
  Map<String, dynamic> toJson();

  @override
  String toString() => jsonEncode(toJson());
}

class ConnectStateEvent extends Event {
  int status;
  ConnectStateEvent(this.status);

  @override
  Map<String, dynamic> toJson() => {'status': status};
}

class LoginStateEvent extends Event {
  int status;
  LoginStateEvent(this.status);

  @override
  Map<String, dynamic> toJson() => {'status': status};
}

class MessageEvent extends Event {
  int type;
  String from;
  String message;
  MessageEvent({this.type = 1, this.from = '', required this.message});

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'from': from,
        'message': message,
      };
}

class ChatClient extends EventBus {
  WebSocket? socket;
  String server;
  int status = WebSocket.closed;

  ChatClient(this.server);

  connect() async {
    LogUtil.i('try connecting..');
    status = WebSocket.connecting;
    try {
      socket = await WebSocket.connect(server);
      status = WebSocket.open;
      fire(ConnectStateEvent(status));
      socket!.listen(
        (data) {
          LogUtil.i(data);
          fire(MessageEvent(message: data.toString()));
        },
        onError: () {
          LogUtil.i('socket error');
        },
        onDone: () {
          LogUtil.i('socket done');
        },
        cancelOnError: false,
      );
    } on SocketException catch (e) {
      LogUtil.i(e);
      Timer(const Duration(seconds: 3), () {
        connect();
      });
    } on WebSocketException catch (e) {
      LogUtil.i(e);
      fire(LoginStateEvent(0));
    } catch (e) {
      LogUtil.i(e);
    } finally {
      status = WebSocket.closed;
      fire(ConnectStateEvent(status));
    }
  }

  dispose() {
    if (socket != null) {
      status = WebSocket.closing;
      socket!.close().then((v) {
        status = WebSocket.closed;
        fire(ConnectStateEvent(status));
      });
    }
  }

  sendMessage(String to, String message) {}

  static ChatClient? _client;
  static ChatClient getInstance() {
    if (_client == null) {
      _client = ChatClient(Constants.chatServer);
      _client!.connect();
    }
    return _client!;
  }
}

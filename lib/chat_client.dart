import 'dart:async';
import 'dart:io';

import 'package:event_bus/event_bus.dart';

import 'constants.dart';
import 'service/logger.dart';

class ConnectStateEvent {
  int status;
  ConnectStateEvent(this.status);
}

class LoginStateEvent {
  int status;
  LoginStateEvent(this.status);
}

class MessageEvent {
  int type;
  String from;
  String message;
  MessageEvent({this.type = 1, this.from = '', required this.message});
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
      socket!.listen((event) {
        LogUtil.i(event);
        fire(MessageEvent(message: event.toString()));
      }, onError: () {
        LogUtil.i('error');
      }, onDone: () {
        LogUtil.i('done');
      }, cancelOnError: false);
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

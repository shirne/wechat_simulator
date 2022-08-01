import 'dart:async';

import 'package:shelf/shelf.dart';

import '../core/controller.dart';
import '../core/result.dart';

class AuthController extends Controller {
  AuthController(Request request) : super(request);

  FutureOr<Response> handler() async {
    return Response.ok(index().toString());
  }

  Result<String> index() {
    return Result(data: 'auth index');
  }
}

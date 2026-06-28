import 'dart:async';
import 'dart:io';

import 'package:employee_support_system/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;

AppException handleException(Object e) {
  /// Supabase Auth
  if (e is AuthException) {
    return AuthException(e.message);
  }

  // /// Database / Postgrest
  if (e is PostgrestException) {
    return ServerException(e.message);
  }

  if (e is SocketException) {
    return const NetworkException("No internet connection");
  }

  /// Timeout
  if (e is TimeoutException) {
    return const NetworkException("Connection timeout");
  }

  return const UnknownException("Something went wrong");
}

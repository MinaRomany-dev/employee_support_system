import 'dart:async';
import 'dart:io';

import 'package:employee_support_system/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;

AppException handleException(Object e) {
  /// Supabase Auth
  if (e is AuthApiException) {
    return AuthException(e.message);
  }
 
  if (e is PostgrestException) {
    return ServerException(e.message);
  }
  if (e is StorageException) {
    return ServerException(e.message);
  }
  if (e is SocketException) {
    return NetworkException(e.message);
  }

  /// Timeout
  if (e is TimeoutException) {
    return NetworkException(e.message ?? "Request timed out");
  }

  return const UnknownException("Something went wrong");
}

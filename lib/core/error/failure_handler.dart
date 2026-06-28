import 'package:employee_support_system/core/error/exception.dart';
import 'package:employee_support_system/core/error/failure.dart';
AppFailure mapExceptionToFailure(AppException e) {
  switch (e) {
    case CacheException():
      return CacheFailure(e.message);

    case NetworkException():
      return NetworkFailure(e.message);

    case AuthException():
      return AuthFailure(e.message);

    case ValidationException():
      return ValidationFailure(e.message);

    case ServerException():
      return ServerFailure(e.message);

    default:
      return UnknownFailure(e.message);
  }
}

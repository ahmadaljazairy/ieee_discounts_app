/// Custom Exception for API related errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() {
    return 'ApiException: $message${statusCode != null ? ' (Status Code: $statusCode)' : ''}';
  }
}

/// Custom Exception for when a partner is not found
class PartnerNotFoundException extends ApiException {
  PartnerNotFoundException(super.message, [super.statusCode]);

  @override
  String toString() {
    return 'PartnerNotFoundException: $message${statusCode != null ? ' (Status Code: $statusCode)' : ''}';
  }
}

/// Custom Exception for when a member is not found
class MemberNotFoundException extends ApiException {
  MemberNotFoundException(super.message, [super.statusCode]);

  @override
  String toString() {
    return 'MemberNotFoundException: $message${statusCode != null ? ' (Status Code: $statusCode)' : ''}';
  }
}

/// Custom Exception for request timeout
class RequestTimeoutException extends ApiException {
  RequestTimeoutException(super.message);

  @override
  String toString() {
    return 'RequestTimeoutException: $message';
  }
}

/// Custom Exception for no internet connection
class NoInternetConnectionException extends ApiException {
  NoInternetConnectionException(super.message);

  @override
  String toString() {
    return 'NoInternetConnectionException: $message';
  }
}

/// A class containing constants and helper methods for API URLs and timeouts.
class ApiConstants {
  /// Base URL for the API
  static const String baseUrl = 'https://ieee-cs-discounts.runasp.net';

  /// Default timeout duration for API requests
  static const Duration timeoutDuration = Duration(seconds: 15);

  // Endpoint paths

  /// Endpoint path for member details
  static const String member = "/Members/:id";

  /// Endpoint path for partners list
  static const String partners = "/Partners/";

  /// Endpoint path for partner details
  static const String partner = "/Partners/:id";

  /// Endpoint path for partners categories
  static const String partnersCategories = "/Partners/categories";

  /// Endpoint path for categorized partners
  static const String partnersCategorized = "/Partners/by-category";

  // Methods to format URLs safely

  /// Formats the URL for getting member details based on the member ID
  ///
  /// [memberId] The ID of the member
  /// Returns the formatted URL as [Uri]
  static Uri getMemberUri(String memberId) => Uri.parse('$baseUrl${member.replaceAll(":id", memberId)}');

  /// Formats the URL for getting partner details based on the partner ID
  ///
  /// [partnerId] The ID of the partner
  /// Returns the formatted URL as [Uri]
  static Uri getPartnerUri(String partnerId) => Uri.parse('$baseUrl${partner.replaceAll(":id", partnerId)}');

  /// Returns the URL for getting the list of partners
  ///
  /// Returns the formatted URL as [Uri]
  static Uri getPartnersUri() => Uri.parse('$baseUrl$partners');

  /// Returns the URL for getting the categorized partners
  ///
  /// Returns the formatted URL as [Uri]
  static Uri getPartnersCategorizedUri() => Uri.parse('$baseUrl$partnersCategorized');

  /// Returns the URL for getting the partners categories
  ///
  /// Returns the formatted URL as [Uri]
  static Uri getPartnersCategoriesUri() => Uri.parse('$baseUrl$partnersCategories');
}

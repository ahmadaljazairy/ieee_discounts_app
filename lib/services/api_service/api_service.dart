import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../models/category.dart';
import '../../models/member.dart';
import '../../models/partner.dart';
import 'api_constants.dart';
import 'exceptions.dart';

/// A service class to handle API requests related to members, partners, and categories.
class ApiService {
  final http.Client _client;

  /// Constructor for [ApiService]
  ///
  /// Accepts an optional [http.Client] parameter for dependency injection.
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Fetches categorized partners from the API.
  ///
  /// Returns a [Future] that resolves to a map containing category names as keys
  /// and lists of [Partner] objects as values.
  Future<Map<String, List<Partner>>?> fetchPartnersCategorized() async {
    return _fetchData<Map<String, List<Partner>>>(
      uri: ApiConstants.getPartnersCategorizedUri(),
      onSuccess: (data) {
        Map<String, List<Partner>> categorizedPartners = {};
        for (var category in data) {
          String categoryName = category["name"];
          List<dynamic> partnersJson = category["partners"];
          List<Partner> partnersList = partnersJson.map((p) => Partner.fromJson(p)).toList();
          categorizedPartners[categoryName] = partnersList;
        }
        return categorizedPartners;
      },
    );
  }

  /// Fetches the list of partners from the API.
  ///
  /// Returns a [Future] that resolves to a list of [Partner] objects.
  Future<List<Partner>?> fetchPartners() async {
    return _fetchData<List<Partner>>(
      uri: ApiConstants.getPartnersUri(),
      onSuccess: (data) => data.map<Partner>((p) => Partner.fromJson(p)).toList(),
    );
  }

  /// Fetches a member by their ID from the API.
  ///
  /// [memberId] The ID of the member to fetch.
  /// Returns a [Future] that resolves to a [Member] object.
  /// Throws [MemberNotFoundException] if the member is not found.
  Future<Member?> fetchMember(String memberId) async {
    return _fetchData<Member>(
      uri: ApiConstants.getMemberUri(memberId),
      onSuccess: (data) => Member.fromJson(data),
      onNotFound: () => throw MemberNotFoundException('Member with ID $memberId not found.'),
    );
  }

  /// Fetches a partner by their ID from the API.
  ///
  /// [partnerId] The ID of the partner to fetch.
  /// Returns a [Future] that resolves to a [Partner] object.
  /// Throws [PartnerNotFoundException] if the partner is not found.
  Future<Partner?> fetchPartner(String partnerId) async {
    return _fetchData<Partner>(
      uri: ApiConstants.getPartnerUri(partnerId),
      onSuccess: (data) => Partner.fromJson(data),
      onNotFound: () => throw PartnerNotFoundException('Partner with ID $partnerId not found.'),
    );
  }

  /// Fetches the list of categories from the API.
  ///
  /// Returns a [Future] that resolves to a list of [Category] objects.
  Future<List<Category>?> fetchCategories() async {
    return _fetchData<List<Category>>(
      uri: ApiConstants.getPartnersCategoriesUri(),
      onSuccess: (data) => data.map<Category>((c) => Category.fromJson(c)).toList(),
    );
  }

  /// Helper method to perform the API request and handle responses.
  ///
  /// [uri] The [Uri] of the API endpoint.
  /// [onSuccess] A callback function to handle successful responses.
  /// [onNotFound] An optional callback function to handle 404 responses.
  /// Returns a [Future] that resolves to the data type specified by [T].
  Future<T?> _fetchData<T>({
    required Uri uri,
    required T Function(dynamic data) onSuccess,
    Function()? onNotFound,
  }) async {
    try {
      final response = await _client.get(uri).timeout(ApiConstants.timeoutDuration);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return onSuccess(data);
      } else if (response.statusCode == 404 && onNotFound != null) {
        onNotFound();
      } else {
        throw ApiException('Failed to load data. Status code: ${response.statusCode}', response.statusCode);
      }
    } on SocketException {
      throw NoInternetConnectionException('No Internet connection.');
    } on RequestTimeoutException {
      throw RequestTimeoutException('The connection has timed out, please try again.');
    } catch (e) {
      throw ApiException('Failed to connect to the server or an unexpected error occurred: $e');
    }
    return null;
  }
}

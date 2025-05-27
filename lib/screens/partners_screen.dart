import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../models/partner.dart';
import '../services/api_service/api_service.dart';
import '../utilities/constants.dart';
import '../utilities/helpers/navigation_helpers.dart';
import '../utilities/hero_box_slogans.dart';
import '../widgets/helper_widgets/error_widget.dart';
import '../widgets/helper_widgets/loading_widget.dart';
import '../widgets/hero_box.dart';
import '../widgets/partner_widgets/partner_card.dart';

// Simple data class to hold the combined initial data
class _InitialData {
  final List<Category> categories;
  final List<Partner> partners;

  _InitialData({required this.categories, required this.partners});
}

class PartnersScreen extends StatefulWidget {
  const PartnersScreen({super.key});

  @override
  State<PartnersScreen> createState() => _PartnersScreenState();
}

class _PartnersScreenState extends State<PartnersScreen> {
  final TextEditingController _searchController = TextEditingController();
  Category? _selectedCategory;

  List<Category> _categories = []; // Includes "All" category
  List<Partner> _allPartners = [];
  List<Partner> _filteredPartners = [];

  // Store gradients per partner for consistency during rebuilds
  final Map<String, Gradient> _partnerGradients = {};

  // Future to load both categories and partners initially
  Future<_InitialData>? _initialDataFuture;

  // Cache the HeroBox widget to prevent slogan regeneration on rebuild
  Widget? _heroBox;

  @override
  void initState() {
    super.initState();
    // Start loading initial data
    _initialDataFuture = _loadInitialData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Combined function to load initial categories and partners
  Future<_InitialData> _loadInitialData() async {
    final apiService = context.read<ApiService>();
    try {
      // Fetch categories and partners concurrently
      final results = await Future.wait([
        apiService.fetchCategories(),
        apiService.fetchPartners(),
      ]);

      final categoriesData = results[0] as List<Category>? ?? [];
      final partnersData = results[1] as List<Partner>? ?? [];

      // Prepare categories list including "All"
      const allCategory = Category(id: 'all_categories_id', name: 'All'); // Use a unique ID
      final List<Category> categoriesWithAll = [allCategory, ...categoriesData];

      // Generate gradients for partners
      for (final partner in partnersData) {
        _partnerGradients.putIfAbsent(partner.id, () => AppColors.getRandomGradient());
      }

      // Set initial state values *after* data is fetched
      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          _categories = categoriesWithAll;
          _selectedCategory = categoriesWithAll.isNotEmpty ? categoriesWithAll.first : null;
          _allPartners = partnersData;
          _filterPartners(); // Apply initial filtering
        });
      }

      return _InitialData(categories: categoriesWithAll, partners: partnersData);
    } catch (e) {
      // Handle or rethrow error if needed
      // print("Error loading initial data: $e"); // For debugging
      throw Exception("Failed to load initial data: $e");
    }
  }

  // Central filtering logic
  void _filterPartners() {
    final searchTerm = _searchController.text.toLowerCase();
    final categoryId = _selectedCategory?.id;

    _filteredPartners = _allPartners.where((partner) {
      final searchMatch = searchTerm.isEmpty || partner.name.toLowerCase().contains(searchTerm);
      final categoryMatch = categoryId == null || categoryId == 'all_categories_id' || partner.categoryId == categoryId;
      return searchMatch && categoryMatch;
    }).toList();
  }

  // Handler for search input changes
  void _onSearchChanged(String value) {
    setState(() {
      _filterPartners();
    });
  }

  // Handler for category dropdown changes
  void _onCategoryChanged(Category? newValue) {
    if (newValue == null || newValue == _selectedCategory) return; // No change

    setState(() {
      _selectedCategory = newValue;
      _filterPartners(); // Re-filter based on the new category
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FutureBuilder<_InitialData>(
      future: _initialDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }
        if (snapshot.hasError || !snapshot.hasData) {
          // print("FutureBuilder Error: ${snapshot.error}");
          return CustomErrorWidget(snapshot.error ?? 'Failed to load data.');
        }

        // Success State - Build the main content
        // Lazily initialize _heroBox here if it hasn't been already
        _heroBox ??= _createHeroBox(size); // Initialize using null-aware assignment

        return _buildMainContent(size);
      },
    );
  }

  // Helper method to create the HeroBox widget (called only once)
  Widget _createHeroBox(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: HeroBox(
        width: size.width * 0.95,
        height: size.height * 0.15,
        slogan: HeroBoxSlogans.getHomeScreenSlogan(),
      ),
    );
  }

  // Builds the main content list after data is successfully loaded
  Widget _buildMainContent(Size size) {
    // Build the filter section (it's relatively cheap to rebuild)
    final filterSection = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: _buildSearchWidget()),
          const SizedBox(width: 45.0),
          Expanded(child: _buildCategoryDropdown()),
        ],
      ),
    );

    return Column(
      children: [
        _heroBox!,
        filterSection,
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            itemCount: _filteredPartners.length,
            itemBuilder: (context, index) {
              final partner = _filteredPartners[index];
              final gradient = _partnerGradients[partner.id] ?? AppColors.getRandomGradient();

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: PartnerCard.create(
                  cardType: CardType.partnersScreen,
                  partner: partner,
                  width: double.infinity,
                  height: size.height * 0.12,
                  gradient: gradient,
                  onTap: () => NavigationHelper.openPartnerDetails(context, partner),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget for the search input field
  Widget _buildSearchWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(60), // Softer shadow
            offset: const Offset(0, 1),
            blurRadius: 4,
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          isDense: true,
        ),
        onChanged: _onSearchChanged,
      ),
    );
  }

  // Widget for the category selection dropdown
  Widget _buildCategoryDropdown() {
    if (_categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(60),
            offset: const Offset(0, 1),
            blurRadius: 4,
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Category>(
          value: _selectedCategory,
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.kPrimaryCrimsonDepth),
          iconSize: 24.0,
          isExpanded: true,
          elevation: 16,
          style: TextStyle(
            color: AppColors.kPrimaryCrimsonDepth,
            fontSize: 14,
          ),
          onChanged: _onCategoryChanged,
          items: _categories.map<DropdownMenuItem<Category>>((Category category) {
            return DropdownMenuItem<Category>(
              value: category,
              child: Text(
                category.name,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          dropdownColor: Colors.white,
        ),
      ),
    );
  }
}

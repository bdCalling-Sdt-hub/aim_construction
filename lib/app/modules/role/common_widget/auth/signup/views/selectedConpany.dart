import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompanySearchDropdown extends StatefulWidget {
  const CompanySearchDropdown({super.key});

  @override
  _CompanySearchDropdownState createState() => _CompanySearchDropdownState();
}

class _CompanySearchDropdownState extends State<CompanySearchDropdown> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // Local state to store the selected company name
  final RxString _selectedCompany = ''.obs;

  // Sample company data (ideally, this could come from a provider or API)
  final List<Map<String, String>> _companies = [
    {'id': '1', 'name': 'Company 1'},
    {'id': '2', 'name': 'Company 2'},
    {'id': '3', 'name': 'Company 3'},
  ];

  // Variable to store the matched company or null if no match
  Map<String, String>? _matchedCompany;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_checkForMatch);
  }

  void _checkForMatch() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      // Check for partial match (case-insensitive)
      _matchedCompany = _companies.firstWhereOrNull(
            (company) => company['name']!.toLowerCase().contains(query),
      );
    });
  }

  void _addNewCompany(String companyName) {
    if (companyName.isNotEmpty) {
      setState(() {
        // Generate a new ID
        final newId = (_companies.length + 1).toString();
        _companies.add({'id': newId, 'name': companyName});
        _searchController.text = companyName;
        _selectedCompany.value = companyName;
        _matchedCompany = {'id': newId, 'name': companyName};
        _focusNode.unfocus();
      });
    }
  }

  void _selectCompany(Map<String, String> company) {
    setState(() {
      _searchController.text = company['name'] ?? '';
      _selectedCompany.value = company['name'] ?? '';
      _matchedCompany = company;
      _focusNode.unfocus();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_checkForMatch);
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _searchController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: _selectedCompany.value.isEmpty
                  ? "Select or type Company Name"
                  : _selectedCompany.value,
              hintStyle: AppStyles.fontSize16(color: AppColors.primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
            ),
            style: AppStyles.fontSize16(color: AppColors.blackColor),
            onChanged: (value) => _checkForMatch(),
          ),
          // Show suggestion based on search
          if (_searchController.text.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: _matchedCompany != null
                  ? GestureDetector(
                onTap: () => _selectCompany(_matchedCompany!),
                child: Text(
                  'Select "${_matchedCompany!['name']}"',
                  style: AppStyles.fontSize16(color: AppColors.primaryColor),
                ),
              )
                  : GestureDetector(
                onTap: () => _addNewCompany(_searchController.text),
                child: Text(
                  'Add "${_searchController.text}" as new company',
                  style: AppStyles.fontSize16(color: AppColors.primaryColor),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Extension to use firstWhereOrNull
extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
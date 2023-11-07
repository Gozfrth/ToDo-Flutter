import 'package:flutter/material.dart';

class SearchSort extends StatelessWidget {
  final TextEditingController searchController;
  dynamic Function(String) onSearch;
  dynamic onSort;

  SearchSort({
    super.key,
    required this.searchController,
    required this.onSearch,
    required this.onSort,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 15),
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffd1d1d1), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xffd9d9d9)),
          const SizedBox(
            width: 4,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: TextField(
              controller: searchController,
              onChanged: (searchTerm) => onSearch(searchTerm),
              style: const TextStyle(
                color: Colors.white, // Set text color to white
              ),
              decoration: const InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Color(0xffd1d1d1),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onSort,
            child: const Icon(
              Icons.sort,
              color: Color(0xffd9d9d9),
            ),
          ),
        ],
      ),
    );
  }
}

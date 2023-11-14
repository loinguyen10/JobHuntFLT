import 'package:flutter/material.dart';
import 'package:jobhunt_ftl/model/job.dart';
import 'package:jobhunt_ftl/repository/repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/component/card.dart';
import 'package:jobhunt_ftl/screen/job/job_detail.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<JobDetail> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tìm Kiếm"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: onSearchTextChanged,
              decoration: InputDecoration(
                hintText: "Nhập từ khóa...",
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchController.text.isNotEmpty ? _searchJobs : null,
              child: Text("Tìm Kiếm"),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  void onSearchTextChanged(String text) {
    setState(() {
      _searchResults.clear();
    });
  }

  Future<void> _searchJobs() async {
    try {
      InsideService repository = InsideService();

      String searchTerm = _searchController.text;

      List<JobDetail> results =
          (await repository.searchJobs(searchTerm)).cast<JobDetail>();

      setState(() {
        _searchResults = results
            .where((job) =>
                job.name?.toLowerCase().contains(searchTerm.toLowerCase()) ??
                false)
            .toList();
      });
    } catch (e) {
      _showErrorSnackBar("Error searching jobs: $e");
    }
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    JobDetailScreen(jobDetail: _searchResults[index]),
              ),
            );
          },
          child: AppJobCard(
            avatar: _searchResults[index].company?.avatarUrl ?? '',
            name: _searchResults[index].name ?? '',
            companyName: _searchResults[index].company?.fullname ?? '',
            province: _searchResults[index]
                .address!
                .substring(_searchResults[index].address!.lastIndexOf(',') + 1),
            money:
                "${_searchResults[index].maxSalary ?? ""}${_searchResults[index].currency ?? ""}",
            deadline: " ${_searchResults[index].deadline ?? ""}",
          ),
        );
      },
    );
  }

  void _showErrorSnackBar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 3),
      ),
    );
  }
}

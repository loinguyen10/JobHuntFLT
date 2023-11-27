import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/model/job.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/component/card.dart';
import 'package:jobhunt_ftl/screen/job/job_view_screen.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import 'package:jobhunt_ftl/value/style.dart';
import 'package:provider/provider.dart';

import '../../blocs/app_riverpod_void.dart';

class SearchResultNotifier extends StateNotifier<List<JobDetail>> {
  SearchResultNotifier() : super([]);

  void updateSearchResult(List<JobDetail> newSearchResult) {
    state = [...newSearchResult];
  }
}

final searchResultProvider =
    StateNotifierProvider<SearchResultNotifier, List<JobDetail>>(
  (ref) => SearchResultNotifier(),
);

class SearchScreen extends ConsumerWidget {
  const SearchScreen({
    Key? key,
    this.itemCount,
  }) : super(key: key);

  final int? itemCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listActiveJobProvider);
    final TextEditingController _searchController = TextEditingController();

    String removeDiacritics(String input) {
      return input
          .replaceAll(RegExp(r'[àáâãäåảạấẩẫậăắằẳẵặ]'), 'a')
          .replaceAll(RegExp(r'[èéêëẻẽẹêếểễệ]'), 'e')
          .replaceAll(RegExp(r'[ìíîïĩị]'), 'i')
          .replaceAll(RegExp(r'[òóôõöộốỗọỏổơớờởỡợ]'), 'o')
          .replaceAll(RegExp(r'[ùúûüụủũưứửự]'), 'u')
          .replaceAll(RegExp(r'[ýÿỷỹỵ]'), 'y')
          .replaceAll(RegExp(r'[ÀÁÂÃÄÅẢÃẠẤẦẪẨẬĂẮẰẲẴẶ]'), 'A')
          .replaceAll(RegExp(r'[ÈÉÊËEẺẼẸẾỀỄỂỆ]'), 'E')
          .replaceAll(RegExp(r'[ÌÍÎÏỈĨỊ]'), 'I')
          .replaceAll(RegExp(r'[ÒÓÔÕÖỎÕỌỐỒỔỖỘƠỚỜỞỠỢ]'), 'O')
          .replaceAll(RegExp(r'[ÙÚÛÜỦŨỤỦƯỨỬỮỰ]'), 'U')
          .replaceAll(RegExp(r'[ÝŸỲỶỸỴ]'), 'Y');
    }

    void performSearch(
        String searchTerm, List<JobDetail> allJobs, WidgetRef ref) {
      print('Thực hiện tìm kiếm với từ khóa: $searchTerm');

      if (searchTerm.isEmpty) {
        ref.read(searchResultProvider.notifier).updateSearchResult([]);
        return;
      }

      final normalizedSearchTerm = removeDiacritics(searchTerm.toLowerCase());

      final List<JobDetail> searchResult = allJobs.where((job) {
        final normalizedJobName =
            removeDiacritics(job.name?.toLowerCase() ?? '');

        return normalizedJobName.contains(normalizedSearchTerm);
      }).toList();

      print('Kết quả tìm kiếm: ${searchResult.map((job) => job.name)}');

      ref.read(searchResultProvider.notifier).updateSearchResult(searchResult);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SearchScreen()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appPrimaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _searchController.clear();
            ref.read(searchResultProvider.notifier).updateSearchResult([]);

            // Sử dụng Navigator để quay lại màn hình trước đó
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Tìm kiếm công việc',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            ref
                                .read(searchResultProvider.notifier)
                                .updateSearchResult([]);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchScreen()),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      final searchTerm = _searchController.text;

                      _data.when(
                        data: (data) {
                          performSearch(searchTerm, data, ref);
                          // Trigger a rebuild of the widget tree
                        },
                        loading: () {},
                        error: (error, stackTrace) {
                          return Text('Error: $error');
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appPrimaryColor,
                    ),
                    child: Text('Tìm kiếm'),
                  ),
                  _data.when(
                    data: (data) {
                      final searchResults =
                          ref.read(searchResultProvider.notifier).state;

                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          String avatar =
                              searchResults[index].company?.avatarUrl ?? '';
                          String name = searchResults[index].name ?? '';
                          String companyName =
                              searchResults[index].company?.fullname ?? '';
                          String province = getProvinceName(
                              searchResults[index].address!.substring(
                                  searchResults[index]
                                          .address!
                                          .lastIndexOf(',') +
                                      1),
                              ref);
                          String money = searchResults[index].maxSalary != -1
                              ? '${searchResults[index].maxSalary} ${searchResults[index].currency}'
                              : Keystring.ARGEEMENT.tr;
                          String deadline = searchResults[index].deadline ?? '';

                          return GestureDetector(
                            onTap: () {
                              ref.read(jobDetailProvider.notifier).state =
                                  searchResults[index];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JobViewScreen()),
                              );
                            },
                            child: AppJobCard(
                              avatar: avatar,
                              name: name,
                              companyName: companyName,
                              province: province,
                              money: money,
                              deadline: deadline,
                            ),
                          );
                        },
                        itemCount: itemCount ?? searchResults.length,
                      );
                    },
                    error: (error, stackTrace) => SizedBox(
                      height: 160,
                      child: Center(
                        child: Text(Keystring.NO_DATA.tr),
                      ),
                    ),
                    loading: () => const SizedBox(
                      height: 160,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';

import '../value/keystring.dart';

class BlankTestScreen extends ConsumerWidget {
  const BlankTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listEducationProvider);

    return _data.when(
      data: (_data) {
        return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (_, index) {
            String id = _data[index].id ?? '';
            String name = _data[index].title ?? '';

            return Card(
              shadowColor: Colors.grey,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              elevation: 2,
              child: ListTile(
                onTap: () {
                  //
                },
                title: Column(children: [
                  Text(
                    id.toString(),
                    overflow: TextOverflow.fade,
                    maxLines: 3,
                  ),
                  Text(
                    name,
                    overflow: TextOverflow.fade,
                    maxLines: 3,
                  ),
                ]),
              ),
            );
          },
          itemCount: _data.length,
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
    );
  }
}

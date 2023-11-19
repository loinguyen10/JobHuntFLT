import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../blocs/app_riverpod_object.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   runApp(ProviderScope(
//       child: MaterialApp(
//         home: FollowScreen(),
//       )));
// }
// class FollowScreen extends ConsumerWidget{
//   const FollowScreen({
//     super.key,
//     this.itemCount
// });
//
//   final int? itemCount;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final _data = ref.watch(listActiveJobProvider);
//
//     return _data.when(
//       data: (data) {
//         return ListView.builder(
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemBuilder: (_, index) {
//             String avatar = data[index].company?.avatarUrl ?? '';
//             String name = data[index].name ?? '';
//             String companyName = data[index].company?.fullname ?? '';
//             String province = getProvinceName(
//                 data[index]
//                     .address!
//                     .substring(data[index].address!.lastIndexOf(',') + 1),
//                 ref);
//             String money = data[index].maxSalary != -1
//                 ? '${data[index].maxSalary} ${data[index].currency}'
//                 : Keystring.ARGEEMENT.tr;
//             String deadline = data[index].deadline ?? '';
//
//             return GestureDetector(
//               onTap: () {
//                 ref.read(jobDetailProvider.notifier).state = data[index];
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => JobViewScreen()),
//                 );
//               },
//               child: AppJobCard(
//                 avatar: avatar,
//                 name: name,
//                 companyName: companyName,
//                 province: province,
//                 money: money,
//                 deadline: deadline,
//               ),
//             );
//           },
//           itemCount: itemCount ?? (data.length < 3 ? data.length : 3),
//         );
//       },
//       error: (error, stackTrace) => SizedBox(
//         height: 160,
//         child: Center(
//           child: Text(Keystring.NO_DATA.tr),
//         ),
//       ),
//       loading: () => const SizedBox(
//         height: 160,
//         child: Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_controller.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:jobhunt_ftl/model/user.dart';
import 'package:jobhunt_ftl/value/style.dart';

import '../../blocs/app_riverpod_object.dart';
import 'package:intl/intl.dart';

import '../../model/conversation.dart';
import '../../model/userprofile.dart';
import '../../value/keystring.dart';

class MessageScreen extends ConsumerWidget {
  MessageScreen({required this.Uid, Key? key}) : super(key: key);
  final Uid;
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final TextEditingController _messageController = TextEditingController();
  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + '...';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isShowTime = ref.watch(isShowTimeProvider);
    final user = ref.watch(userLoginProvider);
    String avatar = '';
    String name = '';
    String? uid = user?.uid;
    String? role = user?.role;
    String? receiverUid = Uid;
    List<CompanyDetail> listCompany = [];
    List<UserProfileDetail> listUser = [];
    print('sendUid' + Uid);
    if (role == 'candidate') {
      final listCompanyData = ref.watch(listCompanyProvider);
      listCompanyData.when(
        data: (_data) {
          listCompany.addAll(_data);
        },
        error: (error, stackTrace) => null,
        loading: () => const CircularProgressIndicator(),
      );
      for (var c in listCompany) {
        if (Uid == c.uid) {
          print('idid: ${Uid} & ${c.uid}');
          avatar = c.avatarUrl ?? '';
          name = c.fullname ?? '';
        }
      }
    } else if (role == 'recruiter') {
      final listProfileData = ref.watch(listUserProfilevider);

      listProfileData.when(
        data: (_data) {
          listUser.addAll(_data);
        },
        error: (error, stackTrace) => null,
        loading: () => const CircularProgressIndicator(),
      );
      for (var c in listUser) {
        if (Uid == c.uid) {
          print('idid: ${Uid} & ${c.uid}');
          avatar = c.avatarUrl ?? '';
          name = c.displayName ?? '';
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            // margin:
            // const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        backgroundColor: appPrimaryColor,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox.fromSize(
                size: Size.fromRadius(16),
                child: avatar.isNotEmpty
                    ? Image.network(avatar, fit: BoxFit.cover)
                    : Icon(
                        Icons.apartment,
                        size: 32,
                      ),
              ),
            ),
            SizedBox(width: 10), // Để tạo khoảng cách giữa avatar và tiêu đề
            Text(
              truncateText(name, 18),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: Container(
        //     margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
        //     decoration: const BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: Colors.white,
        //     ),
        //     child: const Icon(
        //       Icons.arrow_back,
        //       color: Colors.black,
        //       size: 18,
        //     ),
        //   ),
        // ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              flex: 7,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 10,
                        height: MediaQuery.of(context).size.width / 10,
                        child: CircularProgressIndicator(
                          color: appPrimaryColor,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Đã xảy ra lỗi: ${snapshot.error}');
                  } else {
                    List<Map<String, dynamic>> messages = snapshot.data!.docs
                        .map((DocumentSnapshot<Map<String, dynamic>> doc) {
                      return doc.data()!;
                    }).toList();
                    List<Map<String, dynamic>> filteredMessages =
                        messages.where((message) {
                      if (role == 'candidate') {
                        return (message['userUid'] == uid &&
                            message['companyUid'] == receiverUid);
                      } else {
                        return (message['companyUid'] == uid &&
                            message['userUid'] == receiverUid);
                      }
                    }).toList();

                    return ListView.builder(
                      reverse: true,
                      itemCount: filteredMessages.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.all(0),
                          tileColor: Colors.transparent,
                          title: GestureDetector(
                            onTap: () {
                              ref.read(isShowTimeProvider.notifier).state =
                                  !isShowTime;
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment:
                                  filteredMessages[index]['send'] == role
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  decoration: BoxDecoration(
                                    color:
                                        filteredMessages[index]['send'] == role
                                            ? appPrimaryColor
                                            : Colors.grey,
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      filteredMessages[index]['content'],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: isShowTime
                              ? Text(
                                  textAlign: TextAlign.center,
                                  formattedTimestamp(
                                      filteredMessages[index]['timestamp']),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                )
                              : null,
                        );
                      },
                    );
                  }
                },
              )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Ô nhập tin nhắn
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              hintText: 'Nhập tin nhắn...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          String message = _messageController.text;
                          if (!message.isEmpty) {
                            if (role == 'candidate') {
                              sendMessage(message, uid ?? '',
                                  receiverUid.toString(), role ?? '', ref);
                            } else if (role == 'recruiter') {
                              sendMessage(message, receiverUid.toString(),
                                  uid ?? '', role ?? '', ref);
                            }
                            _messageController.clear();
                          }
                        },
                        icon: Icon(Icons.send, color: appPrimaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage(String content, String senderUid, String receiverUid,
      String role, WidgetRef ref) async {
    try {
      Timestamp timestamp = Timestamp.now();
      // if (role == 'candidate') {
      Map<String, dynamic> messageData = {
        'content': content,
        'userUid': senderUid,
        'companyUid': receiverUid,
        'send': role,
        'timestamp': timestamp,
      };
      await FirebaseFirestore.instance.collection('chats').add(messageData);

      print('Đã gửi tin nhắn thành công' + senderUid + '&&' + receiverUid);
      ref
          .watch(LoginControllerProvider.notifier)
          .addMessage(senderUid, receiverUid, content, role);
      AddConversation(senderUid, receiverUid, content, timestamp, role, ref);
      // } else if (role == 'recruiter') {
      //   Map<String, dynamic> messageData = {
      //     'content': content,
      //     'userUid': receiverUid,
      //     'companyUid': senderUid,
      //     'timestamp': timestamp,
      //   };
      //   await FirebaseFirestore.instance.collection('chats').add(messageData);
      //
      //   print('Đã gửi tin nhắn thành công'+senderUid+'&&'+receiverUid);
      //   AddConversation(receiverUid, senderUid, content, timestamp,role);
      // }
    } catch (e) {
      print('Lỗi khi gửi tin nhắn: $e');
    }
  }

  String formattedTimestamp(Timestamp timestamp) {
    DateTime currentTime = DateTime.now();
    DateTime messageTime = timestamp.toDate();
    Duration difference = currentTime.difference(messageTime);
    if (difference.inMinutes < 1) {
      return "Vừa xong";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes} phút trước";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} giờ trước";
    } else {
      return DateFormat.yMd().add_Hm().format(messageTime);
    }
  }

  void AddConversation(String userUid, String companyUid, String content,
      Timestamp timestamp, String role, WidgetRef ref) async {
    CollectionReference conversationCollection =
        FirebaseFirestore.instance.collection('conversation');

    // if(role=='candidate'){
    QuerySnapshot<Object?> existingData = await conversationCollection
        .where('userUid', isEqualTo: userUid)
        .where('companyUid', isEqualTo: companyUid)
        .get();
    if (existingData.docs.isNotEmpty) {
      QueryDocumentSnapshot<Object?> existingDoc = existingData.docs.first;
      await conversationCollection.doc(existingDoc.id).update({
        'userUid': userUid,
        'companyUid': companyUid,
        'content': content,
        'timestamp': timestamp,
      });
    } else {
      Map<String, dynamic> conversationData = {
        'userUid': userUid,
        'companyUid': companyUid,
        'content': content,
        'timestamp': timestamp,
      };
      await conversationCollection.add(conversationData);
      QuerySnapshot<Object?> existingData = await conversationCollection
          .where('userUid', isEqualTo: userUid)
          .where('companyUid', isEqualTo: companyUid)
          .where('timestamp', isEqualTo: timestamp)
          .get();
      if (existingData.docs.isNotEmpty) {
        QueryDocumentSnapshot<Object?> existingDoc = existingData.docs.first;
        ref
            .watch(LoginControllerProvider.notifier)
            .addConverstation(existingDoc.id, userUid, companyUid, content);
      }
    }
    // }else if(role == 'recruiter'){
    //   QuerySnapshot<Object?> existingData = await conversationCollection
    //       .where('userUid', isEqualTo: companyUid)
    //       .where('companyUid', isEqualTo: userUid)
    //       .get();
    //   if (existingData.docs.isNotEmpty) {
    //     QueryDocumentSnapshot<Object?> existingDoc = existingData.docs.first;
    //     await conversationCollection.doc(existingDoc.id).update({
    //       'userUid': companyUid,
    //       'companyUid': userUid,
    //       'content': content,
    //       'timestamp': timestamp,
    //     });
    //   } else {
    //     Map<String, dynamic> conversationData = {
    //       'content': content,
    //       'timestamp': timestamp,
    //     };
    //     await conversationCollection.add(conversationData);
    //   }
    // }
    print('UserId' + userUid + 'companyId' + companyUid);
  }
}

class Conversation extends ConsumerStatefulWidget {
  const Conversation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Conversation();
}

class _Conversation extends ConsumerState<Conversation> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userLoginProvider);
    String? uid = user!.uid;
    String? role = user?.role;
    List<CompanyDetail> listCompany = [];
    List<UserProfileDetail> listUserProfile = [];
    final listCompanyData = ref.watch(listCompanyProvider);

    listCompanyData.when(
      data: (_data) {
        listCompany.addAll(_data);
      },
      error: (error, stackTrace) => null,
      loading: () => const CircularProgressIndicator(),
    );

    final listProfileData = ref.watch(listUserProfilevider);

    listProfileData.when(
      data: (_data) {
        listUserProfile.addAll(_data);
      },
      error: (error, stackTrace) => null,
      loading: () => const CircularProgressIndicator(),
    );

    String formattedTimestamp(Timestamp timestamp) {
      DateTime messageTime = timestamp.toDate();
      return DateFormat.Hm().format(messageTime);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(Keystring.YOUR_INBOX.tr),
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Column(
          children: [
            // GestureDetector(
            //   onTap: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(
            //     //       builder: (context) => SearchScreen()),
            //     // );
            //   },
            //   child: Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //       side: BorderSide(color: Colors.black, width: 1),
            //     ),
            //     elevation: 2,
            //     child: Container(
            //       padding: EdgeInsets.symmetric(vertical: 16),
            //       child: Row(
            //         children: [
            //           SizedBox(
            //             width: 16,
            //           ),
            //           Icon(
            //             Icons.search,
            //             size: 30,
            //           ),
            //           SizedBox(
            //             width: 16,
            //           ),
            //           Text(
            //             Keystring.SEARCH,
            //             style: textNormalHint,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 16),
            Expanded(
                flex: 7,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('conversation')
                      .where('senderUid')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 10,
                          height: MediaQuery.of(context).size.width / 10,
                          child: CircularProgressIndicator(
                            color: appPrimaryColor,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Đã xảy ra lỗi: ${snapshot.error}');
                    } else {
                      List<Map<String, dynamic>> conversations = snapshot
                          .data!.docs
                          .map((DocumentSnapshot<Map<String, dynamic>> doc) {
                        return doc.data()!;
                      }).toList();

                      List<Map<String, dynamic>> filteredconversations =
                          conversations.where((message) {
                        if (role == 'candidate') {
                          return message['userUid'] == uid;
                        } else {
                          return message['companyUid'] == uid;
                        }
                      }).toList();

                      print('filteredconversations' +
                          filteredconversations.length.toString());
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredconversations.length,
                        itemBuilder: (context, index) {
                          String avatar = '';
                          String name = '';
                          if (role == 'candidate') {
                            for (var c in listCompany) {
                              if (filteredconversations[index]['companyUid'] ==
                                  c.uid) {
                                print(
                                    'idid: ${filteredconversations[index]['companyUid']} & ${c.uid}');
                                avatar = c.avatarUrl ?? '';
                                name = c.fullname ?? '';
                              }
                            }
                          } else if (role == 'recruiter') {
                            for (var c in listUserProfile) {
                              if (filteredconversations[index]['userUid'] ==
                                  c.uid) {
                                print(
                                    'idid: ${filteredconversations[index]['userUid']} & ${c.uid}');
                                avatar = c.avatarUrl ?? '';
                                name = c.displayName ?? '';
                              }
                            }
                          }

                          return ListTile(
                            contentPadding: EdgeInsets.all(0),
                            tileColor: Colors.transparent,
                            title: GestureDetector(
                                onTap: () {
                                  if (role == 'candidate') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MessageScreen(
                                              Uid: filteredconversations[index]
                                                      ['companyUid'] ??
                                                  'tùng nà'),
                                        ));
                                  } else if (role == 'recruiter')
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MessageScreen(
                                              Uid: filteredconversations[index]
                                                      ['userUid'] ??
                                                  'tùng nà'),
                                        ));
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        height: 65,
                                        width: 60,
                                        child: Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(32),
                                            child: SizedBox.fromSize(
                                              size: Size.fromRadius(32),
                                              child: avatar.isNotEmpty
                                                  ? Image.network(
                                                      avatar,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Icon(
                                                      Icons.apartment,
                                                      size: 32,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: SizedBox(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    truncateText(
                                                        filteredconversations[
                                                            index]['content'],
                                                        20),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(formattedTimestamp(
                                                      filteredconversations[
                                                          index]['timestamp'])),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          );
                        },
                      );
                    }
                  },
                ))
          ],
        ));
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + '...';
    }
  }
}

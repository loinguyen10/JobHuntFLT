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
import '../../value/keystring.dart';
class MessageScreen extends ConsumerWidget {
  MessageScreen({required this.company, Key? key})
      : super(key: key);
  CompanyDetail company;
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isShowTime = ref.watch(isShowTimeProvider);
    final user = ref.watch(userProfileProvider);
    final avatar = company.avatarUrl??"";
    String? uid = user!.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appPrimaryColor,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox.fromSize(
                size: Size.fromRadius(16),
                child: avatar.isNotEmpty
                    ? Image.network(avatar,
                    fit: BoxFit.cover)
                    : Icon(
                  Icons.apartment,
                  size: 32,
                ),
              ),
            ),
            SizedBox(width: 10), // Để tạo khoảng cách giữa avatar và tiêu đề
            Text(
              company!.fullname.toString(),
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
      body:Column(
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
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Đã xảy ra lỗi: ${snapshot.error}');
                } else {
                  List<Map<String, dynamic>> messages = snapshot.data!.docs
                      .map((DocumentSnapshot<Map<String, dynamic>> doc) {
                    return doc.data()!;
                  }).toList();
                  // Lọc tin nhắn theo điều kiện bạn muốn
                  List<Map<String, dynamic>> filteredMessages = messages.where((message) {
                    return (message['senderUid'] == uid && message['receiverUid'] == company.uid) ||
                        (message['senderUid'] == company.uid && message['receiverUid'] == uid);
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
                            ref.read(isShowTimeProvider.notifier).state = !isShowTime;
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: filteredMessages[index]['senderUid'] == uid
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                decoration: BoxDecoration(
                                  color: filteredMessages[index]['senderUid'] == uid
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
                          formattedTimestamp(filteredMessages[index]['timestamp']),
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )
                            : null,
                      );
                    },
                  );
                }
              },
            )
          ),
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
                          if(!message.isEmpty){
                            sendMessage(message,uid!,company.uid.toString());
                            _messageController.clear();
                          }
                        },
                        icon: Icon(Icons.send,color: appPrimaryColor),
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
  void sendMessage(String content, String senderUid, String receiverUid) async {
    try {
      Timestamp timestamp = Timestamp.now();

      Map<String, dynamic> messageData = {
        'content': content,
        'userUid': senderUid,
        'companyUid': receiverUid,
        'timestamp': timestamp,
      };

      // Gửi dữ liệu tin nhắn lên Firestore
      await FirebaseFirestore.instance
          .collection('chats')
          .add(messageData);

      print('Đã gửi tin nhắn thành công');
      Map<String, dynamic> conversationData = {
        'userUid': senderUid,
        'companyUid': receiverUid,
        'timestamp': timestamp,
      };
      await FirebaseFirestore.instance
          .collection('conversation')
          .add(conversationData);
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
    } else if(difference.inHours<1){
      return "${difference.inMinutes} phút trước";
    }
    else if (difference.inHours < 24) {
      return "${difference.inHours} giờ trước";
    } else {
      return DateFormat.yMd().add_Hm().format(messageTime);
    }
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
    final user = ref.watch(userProfileProvider);

    List<CompanyDetail> listCompany = [];

    final listCompanyData = ref.watch(listCompanyProvider);

    listCompanyData.when(
      data: (_data) {
        listCompany.addAll(_data);
      },
      error: (error, stackTrace) => null,
      loading: () => const CircularProgressIndicator(),
    );

    String? uid = user!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(Keystring.YOUR_INBOX.tr),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body:   Column(
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => SearchScreen()),
              // );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.black, width: 1),
              ),
              elevation: 2,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Icon(
                      Icons.search,
                      size: 30,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      Keystring.SEARCH,
                      style: textNormalHint,
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Đã xảy ra lỗi: ${snapshot.error}');
                  } else {
                    List<Map<String, dynamic>> conversations = snapshot.data!.docs
                        .map((DocumentSnapshot<Map<String, dynamic>> doc) {
                      return doc.data()!;
                    }).toList();
                   
                    List<Map<String, dynamic>> filteredconversations = conversations.where((message) {
                      return (message['userUid'] == uid || message['userUid'] == uid);
                    }).toList();
                    // for(var i in filteredconversations){
                    //   final conversation = ConversationModel(
                    //     companyUid: i['companyUid'],
                    //     userUid: i['userUid'],
                    //     timestamps: i['timestamps'],
                    //     content: i['content'],
                    //   );
                    //   print(conversation.companyUid!+conversation.timestamps.toString());
                    // }

                    print('filteredconversations'+filteredconversations.length.toString());
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredconversations.length,
                      itemBuilder: (context, index) {

                        String avatar = '';
                        String name = '';

                        for(var c in listCompany){
                          if(filteredconversations[index]['companyUid'] == c.uid){
                            print('idid: ${filteredconversations[index]['companyUid']} & ${c.uid}');
                            avatar = c.avatarUrl??'';
                            name = c.fullname??'';
                          }
                        }



                        return ListTile(
                          contentPadding: EdgeInsets.all(0),
                          tileColor: Colors.transparent,
                          title: GestureDetector(

                            onTap: () {

                            },
                            child:Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(16),
                                    child: avatar.isNotEmpty
                                        ? Image.network(avatar,
                                        fit: BoxFit.cover)
                                        : Icon(
                                      Icons.apartment,
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        );
                      },
                    );
                  }
                },
              )
          )
        ],
      )
    );
  }
}

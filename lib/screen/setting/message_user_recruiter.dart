import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/model/user.dart';

import '../../blocs/app_riverpod_object.dart';
import 'package:intl/intl.dart';
class MessageScreen extends ConsumerWidget {
  MessageScreen({required this.companyUid, Key? key})
      : super(key: key);
  String companyUid;
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isShowTime = ref.watch(isShowTimeProvider);
    final user = ref.watch(userProfileProvider);
    final company = ref.watch(companyProfileProvider);
    String? uid = user!.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(company!.avatarUrl.toString()),
            ),
            SizedBox(width: 10), // Để tạo khoảng cách giữa avatar và tiêu đề
            Text(
              company!.fullname.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 18,
            ),
          ),
        ),
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
                    return (message['senderUid'] == uid && message['receiverUid'] == companyUid) ||
                        (message['senderUid'] == companyUid && message['receiverUid'] == uid);
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
                                      ? Colors.blue
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
                            sendMessage(message,uid!,companyUid);
                            _messageController.clear();
                          }
                        },
                        icon: Icon(Icons.send,color: Colors.blue),
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
        'senderUid': senderUid,
        'receiverUid': receiverUid,
        'timestamp': timestamp,
      };

      // Gửi dữ liệu tin nhắn lên Firestore
      await FirebaseFirestore.instance
          .collection('chats')
          .add(messageData);

      print('Đã gửi tin nhắn thành công');
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

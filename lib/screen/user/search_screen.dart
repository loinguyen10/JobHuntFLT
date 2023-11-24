
import 'package:flutter/material.dart';

class UsersSearchScreen extends StatefulWidget {
  const UsersSearchScreen({Key? key}) : super(key: key);

  @override
  State<UsersSearchScreen> createState() =>
      _UsersSearchScreenState();
}

class _UsersSearchScreenState
    extends State<UsersSearchScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.black,
          title: const Text(
            'Search',
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.grey[200], // Màu nền của TextField
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Điều chỉnh giá trị này để bo tròn cạnh
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

import 'package:flutter/material.dart';

import '../value/style.dart';

class AppCompanyCard extends StatefulWidget {
  const AppCompanyCard({
    super.key,
    required this.avatar,
    required this.name,
    required this.province,
    required this.job,
  });

  final String avatar;
  final String name;
  final String province;
  final String job;

  @override
  State<AppCompanyCard> createState() => _AppCompanyCardState();
}

class _AppCompanyCardState extends State<AppCompanyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(width: 8),
          ClipOval(
            child: SizedBox.fromSize(
              size: Size.fromRadius(40), // Image radius
              child: widget.avatar != ''
                  ? Image.network(
                      widget.avatar,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.no_accounts_outlined,
                      size: 80,
                    ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Text(
                  widget.name,
                  overflow: TextOverflow.fade,
                  maxLines: 3,
                  style: textNameVCompany,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        widget.province,
                        overflow: TextOverflow.fade,
                        maxLines: 3,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.green),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        widget.job,
                        overflow: TextOverflow.fade,
                        maxLines: 3,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AppJobCard extends StatefulWidget {
  const AppJobCard({
    super.key,
    required this.avatar,
    required this.name,
    required this.province,
    required this.maxSalary,
  });

  final String avatar;
  final String name;
  final String province;
  final String maxSalary;

  @override
  State<AppJobCard> createState() => _AppJobCardState();
}

class _AppJobCardState extends State<AppJobCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(width: 8),
          ClipOval(
            child: SizedBox.fromSize(
              size: Size.fromRadius(40), // Image radius
              child: widget.avatar != ''
                  ? Image.network(
                      widget.avatar,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.no_accounts_outlined,
                      size: 80,
                    ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Text(
                  widget.name,
                  overflow: TextOverflow.fade,
                  maxLines: 3,
                  style: textNameVCompany,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        widget.province,
                        overflow: TextOverflow.fade,
                        maxLines: 3,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.green),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        widget.maxSalary,
                        overflow: TextOverflow.fade,
                        maxLines: 3,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AppJobSuggestionCard extends StatefulWidget {
  const AppJobSuggestionCard({
    super.key,
    required this.name,
    required this.province,
    required this.maxSalary,
  });

  final String name;
  final String province;
  final String maxSalary;

  @override
  State<AppJobSuggestionCard> createState() => _AppJobSuggestionCardState();
}

class _AppJobSuggestionCardState extends State<AppJobSuggestionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            widget.name,
            overflow: TextOverflow.fade,
            maxLines: 3,
            style: textNormal,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                  widget.province,
                  overflow: TextOverflow.fade,
                  maxLines: 3,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.green),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                  widget.maxSalary,
                  overflow: TextOverflow.fade,
                  maxLines: 3,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

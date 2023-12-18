import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhunt_ftl/model/userprofile.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import '../screen/report/report_user.dart';
import '../value/style.dart';

class AppCompanyCard extends StatefulWidget {
  const AppCompanyCard({
    super.key,
    required this.avatar,
    required this.name,
    required this.province,
    required this.job,
    required this.level,
  });

  final String avatar;
  final String name;
  final String province;
  final String job;
  final String level;

  @override
  State<AppCompanyCard> createState() => _AppCompanyCardState();
}

class _AppCompanyCardState extends State<AppCompanyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border:
            Border.all(width: 1, color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(width: 8),
          Container(
            child: Stack(
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(40), // Image radius
                    child: widget.avatar != ''
                        ? Image.network(
                            widget.avatar,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.apartment,
                            size: 80,
                          ),
                  ),
                ),
                widget.level == 'Premium'
                    ? Positioned(
                        right: 0.0,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 12.0,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow[600],
                              size: 24,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(width: 0),
              ],
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
                          border: Border.all(width: 2, color: appPrimaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        widget.province,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 3),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.green),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Text(
                        widget.job,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
    required this.companyName,
    required this.province,
    required this.money,
    required this.deadline,
  });

  final String avatar;
  final String name;
  final String companyName;
  final String province;
  final String money;
  final String deadline;

  @override
  State<AppJobCard> createState() => _AppJobCardState();
}

class _AppJobCardState extends State<AppJobCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          border: Border.all(
              width: 1, color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(width: 24),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  overflow: TextOverflow.fade,
                  maxLines: 3,
                  style: textNameVCompany,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  widget.companyName,
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  style: textCompanyJView,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.place,
                          color: appPrimaryColor,
                          size: 20,
                        ),
                        Text(
                          widget.province,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: Colors.green,
                          size: 20,
                        ),
                        Text(
                          widget.money,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timelapse,
                      color: Colors.red,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text('${Keystring.Deadline.tr}: ${widget.deadline}'),
                  ],
                ),
              ],
            ),
          ),
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
                  maxLines: 1,
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
                  maxLines: 1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AppFavoriteCard extends StatefulWidget {
  const AppFavoriteCard({
    super.key,
    required this.avatar,
    required this.name,
    required this.nameCompany,
    required this.deadline,
    required this.money,
    this.bgColor = Colors.white,
  });

  final String avatar;
  final String name;
  final String nameCompany;
  final String deadline;
  final String money;
  final Color bgColor;

  @override
  State<AppFavoriteCard> createState() => _AppFavoriteCardState();
}

class _AppFavoriteCardState extends State<AppFavoriteCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: widget.bgColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(width: 8),
          Container(
            width: MediaQuery.of(context).size.width / 4,
            child: Column(
              children: [
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
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.nameCompany,
                  style: textCompanyFView,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  overflow: TextOverflow.fade,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: textNameVCompany,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.green),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        widget.money,
                      ),
                    ),
                    Text(
                      '${Keystring.Deadline.tr}\n${widget.deadline}',
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

class AppCandidateProfileCard extends StatefulWidget {
  const AppCandidateProfileCard({
    super.key,
    required this.candidate,
    required this.province,
  });

  final UserProfileDetail? candidate;
  final String province;

  @override
  State<AppCandidateProfileCard> createState() =>
      _AppCandidateProfileCardState();
}

class _AppCandidateProfileCardState extends State<AppCandidateProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(width: 8),
          ClipOval(
            child: SizedBox.fromSize(
              size: Size.fromRadius(40), // Image radius
              child: widget.candidate!.avatarUrl != ''
                  ? Image.network(
                      widget.candidate!.avatarUrl ?? '',
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.no_accounts_outlined,
                      size: 80,
                    ),
            ),
          ),
          SizedBox(width: 24),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.candidate!.fullName ?? '',
                  style: textNameVCompany,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  '${Keystring.BIRTHDAY.tr}: ${widget.candidate!.birthday}',
                  style: textCompanyJView,
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Text(widget.province),
                ),
                SizedBox(height: 12),
                Text('${Keystring.EMAIL.tr}: ${widget.candidate!.email}'),
                SizedBox(height: 12),
                Text('${Keystring.PHONE.tr}: ${widget.candidate!.phone}'),
              ],
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ReportUserScreen(userDetail: widget.candidate),
                    ));
              },
              child: Icon(
                Icons.report,
                color: Colors.red,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppJobHomeCard extends StatefulWidget {
  const AppJobHomeCard({
    super.key,
    required this.avatar,
    required this.name,
    required this.companyName,
    required this.province,
    required this.money,
    required this.deadline,
  });

  final String avatar;
  final String name;
  final String companyName;
  final String province;
  final String money;
  final String deadline;

  @override
  State<AppJobHomeCard> createState() => _AppJobHomeCardState();
}

class _AppJobHomeCardState extends State<AppJobHomeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
            border: Border.all(
                width: 1, color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
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
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          overflow: TextOverflow.fade,
                          maxLines: 3,
                          style: textNameVCompany,
                        ),
                        SizedBox(height: 12),
                        Text(
                          widget.companyName,
                          overflow: TextOverflow.fade,
                          maxLines: 3,
                          style: textCompanyJView,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.place,
                          color: appPrimaryColor,
                          size: 20,
                        ),
                        Text(
                          widget.province,
                          overflow: TextOverflow.fade,
                          maxLines: 3,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: Colors.green,
                          size: 20,
                        ),
                        Text(
                          widget.money,
                          overflow: TextOverflow.fade,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.timelapse,
                    color: Colors.red,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text('${Keystring.Deadline.tr}: ${widget.deadline}'),
                ],
              ),
            ],
          ),
        ));
  }
}

class AppSquareHomeCard extends StatefulWidget {
  const AppSquareHomeCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    this.width = 185,
    this.bgColor = Colors.black,
  });

  final Color bgColor;
  final String title;
  final String count;
  final IconData icon;
  final double width;

  @override
  State<AppSquareHomeCard> createState() => _AppSquareHomeCardState();
}

class _AppSquareHomeCardState extends State<AppSquareHomeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      shadowColor: Colors.black,
      child: Container(
        width: widget.width,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.bgColor,
              widget.bgColor,
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.background,
            ],
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Text(
                widget.title,
                style: textJobHome,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    widget.icon,
                  ),
                  Text(
                    widget.count,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

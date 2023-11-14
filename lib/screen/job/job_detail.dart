import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhunt_ftl/component/outline_text.dart';
import 'package:jobhunt_ftl/model/job.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import 'package:jobhunt_ftl/value/style.dart';

class JobDetailScreen extends StatelessWidget {
  final JobDetail jobDetail;

  JobDetailScreen({required this.jobDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi Tiết Sản Phẩm"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.26,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.white],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(
                          jobDetail.company?.avatarUrl ?? '',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppOutlineText(
                            text: jobDetail.name ?? '',
                            fontSize: 24,
                            strokeWidth: 3,
                          ),
                          SizedBox(height: 8),
                          Text(
                            jobDetail.company?.fullname ?? '',
                            overflow: TextOverflow.fade,
                            maxLines: 3,
                            style: textCompanyJView,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16),
                ListTile(
                  leading: Icon(Icons.place, color: Colors.blue),
                  title: Text(
                    ' ${jobDetail.address ?? ''}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.monetization_on, color: Colors.blue),
                  title: Text(
                    ' ${jobDetail.minSalary} - ${jobDetail.maxSalary} ${jobDetail.currency}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.star, color: Colors.blue),
                  title: Text(
                    '${jobDetail.yearExperience} ${Keystring.Year_Experience.tr}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                ListTile(
                  leading:
                      Icon(Icons.calendar_month_rounded, color: Colors.blue),
                  title: Text(
                    '${jobDetail.typeJob == 0 ? 'Intern' : (jobDetail.typeJob == 1 ? 'Part Time' : 'Full Time')}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.people_alt_outlined, color: Colors.blue),
                  title: Text(
                    '${jobDetail.numberCandidate} ${Keystring.PERSON.tr}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.timelapse, color: Colors.blue),
                  title: Text(
                    ' ${jobDetail.deadline ?? ''}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '${Keystring.Job_Detail.tr}:',
                  style: TextStyle(
                      color: appPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                SizedBox(height: 8),
                Text(
                  jobDetail.description ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 16),
                Text(
                  '${Keystring.Candidate_Requirement.tr}:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  jobDetail.candidateRequirement ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 16),
                Text(
                  '${Keystring.Job_Benefit.tr}:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  jobDetail.jobBenefit ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 16),
                Text(
                  '${Keystring.Tag.tr}:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  jobDetail.tag ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 16),
                Center(
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(56),
                      child: jobDetail.company?.avatarUrl != ''
                          ? Image.network(
                              jobDetail.company?.avatarUrl ?? '',
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.apartment,
                              size: 96,
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  jobDetail.company?.fullname ?? '',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

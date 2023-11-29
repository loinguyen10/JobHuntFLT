import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhunt_ftl/screen/job/job_screen.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';
import '../user/company_screen.dart';

class JobRecommendUser extends StatelessWidget {
  const JobRecommendUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: Theme.of(context).colorScheme.background == Colors.white
              ? bgGradientColor0
              : bgGradientColor1),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(0, 255, 255, 255),
            title: Text(Keystring.RECOMMEND_JOB.tr),
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: const SingleChildScrollView(
            child: JobRecommendListScreen(),
          ),
        ),
      ),
    );
  }
}

class JobBestAllScreen extends StatelessWidget {
  const JobBestAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: Theme.of(context).colorScheme.background == Colors.white
              ? bgGradientColor0
              : bgGradientColor1),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(0, 255, 255, 255),
            title: Text(Keystring.BEST_JOB.tr),
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: const SingleChildScrollView(
            child: JobBestListScreen(),
          ),
        ),
      ),
    );
  }
}

class CompanyVerifyScreen extends StatelessWidget {
  const CompanyVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: Theme.of(context).colorScheme.background == Colors.white
              ? bgGradientColor0
              : bgGradientColor1),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(0, 255, 255, 255),
            title: Text(Keystring.VERIFIED_COMPANIES.tr),
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: const SingleChildScrollView(
            child: CompanyPremiumScreen(),
          ),
        ),
      ),
    );
  }
}

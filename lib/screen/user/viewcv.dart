import 'package:flutter/material.dart';
// import 'package:jobhunt_ftl/blocs/app_event.dart';
// import 'package:jobhunt_ftl/repository/repository.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// import '../component/loader_overlay.dart';

class ViewCVScreen extends StatelessWidget {
  const ViewCVScreen({super.key, required this.cv});
  final String cv;

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<InsideBloc, InsideState>(
    //   builder: (context, state) {
    // log('profile: ${state.getUserProfileStatus}');
    // if (state.getUserProfileStatus == GetUserProfileStatus.loading) {
    //   Loader.show(context);
    // }

    // if (state.getUserProfileStatus == GetUserProfileStatus.success) {
    //   Loader.hide();
    // }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ScreenViewCV(
        cv: cv,
      ),
    ));
    //   },
    // );
  }
}

class ScreenViewCV extends StatefulWidget {
  const ScreenViewCV({
    super.key,
    required this.cv,
  });
  final String cv;

  @override
  State<ScreenViewCV> createState() => _ScreenViewCV();
}

class _ScreenViewCV extends State<ScreenViewCV> {
  @override
  Widget build(BuildContext context) {
    // Map<String, String> requestHeaders = {
    //   'Content-type': 'application/pdf',
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer ${widget.token}',
    // };
    // log('met header: ${requestHeaders}');
    return Scaffold(
      body: SfPdfViewerTheme(
        data: SfPdfViewerThemeData(
          backgroundColor: Colors.white, //<----
        ),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: SfPdfViewer.network(
                widget.cv,
                // headers: requestHeaders,
                enableDoubleTapZooming: false,
                maxZoomLevel: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:swaraksha/colors.dart';
import 'package:swaraksha/core/issues/application/issues_manager.dart';
import 'package:swaraksha/core/issues/presentation/fullscreen_image_page.dart';
import 'package:swaraksha/data/app_state.dart';
import 'package:swaraksha/globals.dart';
import 'package:swaraksha/models/issue.dart';
import 'package:swaraksha/widgets/action_button.dart';
import 'package:timeago/timeago.dart' as timeago;

class IssueDetailPage extends StatefulWidget {
  final Issue issue;
  const IssueDetailPage({
    super.key,
    required this.issue,
  });

  @override
  State<IssueDetailPage> createState() => _IssueDetailPageState();
}

class _IssueDetailPageState extends State<IssueDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Issue Description"),
      ),
      // body: Text(widget.issue.toJson().toString()),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.issue.images.isNotEmpty)
                      GestureDetector(
                        onTap: () => navigateTo(
                          FullScreenImagePage(imageUrl: widget.issue.images[0]),
                          context,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 30.0),
                          height: 0.35 * getHeight(context),
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              widget.issue.images[0],
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    _getHeading("Title"),
                    _getDescription(widget.issue.title),
                    _getHeading("Description"),
                    _getDescription(widget.issue.description),
                    _getHeading("Posted By"),
                    _getDescription(widget.issue.issuedBy),
                    _getHeading("Department"),
                    _getDescription(widget.issue.departmentName),
                    Text("Posted: ${timeago.format(widget.issue.createdAt)}"),
                    SizedBox(height: 0.2 * getHeight(context)),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1.0,
                    blurRadius: 5.0,
                    offset: Offset.zero,
                  )
                ],
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                children: [
                  if (isAdmin())
                    Expanded(
                      child: ActionButton(
                        text: "Resolve",
                        onPressed: () async {
                          final res = await IssuesManager().updateIssueStatus(
                              widget.issue.id, "in-progress");

                          if (res && mounted)   {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  if (isAdmin()) const SizedBox(width: 10),
                  Expanded(
                    child: ActionButton(
                      color: Colors.grey,
                      text: "Inactive",
                      onPressed: () async {
                        var res = await IssuesManager()
                            .updateIssueStatus(widget.issue.id, "stale");

                        if (res && mounted) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getHeading(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: greyText,
        ),
      ),
    );
  }

  _getDescription(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }
}

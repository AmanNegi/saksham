import 'package:flutter/material.dart';
import 'package:swaraksha/core/issues/application/issues_manager.dart';
import 'package:swaraksha/core/issues/presentation/issue_detail_page.dart';
import 'package:swaraksha/globals.dart';
import 'package:swaraksha/models/issue.dart';
import 'package:swaraksha/widgets/loading_layout.dart';

class MyIssuesPage extends StatefulWidget {
  const MyIssuesPage({super.key});

  @override
  State<MyIssuesPage> createState() => _MyIssuesPageState();
}

class _MyIssuesPageState extends State<MyIssuesPage> {
  List<Issue> issues = [];
  bool isLoading = true;

  @override
  void initState() {
    IssuesManager().getUserIssues().then((value) {
      isLoading = false;
      issues = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Issues"),
        ),
        body: LoadingLayout(
          isLoading: isLoading,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                  children: issues.map((e) {
                return GestureDetector(
                  onTap: (){
                    navigateTo(IssueDetailPage(issue: e), context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0,
                          ),
                          child: Row(children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.title,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    e.description,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Text(e.departmentName),
                                ],
                              ),
                            ),
                            _getChip(e),
                          ]),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                );
              }).toList()),
            ),
          ),
        ));
  }

  Container _getChip(Issue e) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      decoration: BoxDecoration(
        color: _getColor(e.status),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        e.status,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Color _getColor(String status) {
    if (status == "closed") {
      return Colors.red;
    } else if (status == "stale") {
      return Colors.amber;
    } else {
      return Colors.green;
    }
  }
}

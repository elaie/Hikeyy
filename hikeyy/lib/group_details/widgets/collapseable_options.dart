import 'package:flutter/material.dart';
import 'package:hikeyy/widgets/app_colors.dart';

class CollapsibleOptions extends StatefulWidget {
  @override
  _CollapsibleOptionsState createState() => _CollapsibleOptionsState();
}

class _CollapsibleOptionsState extends State<CollapsibleOptions> {
  bool _tripDetailsExpanded = false;
  bool _checkpointsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 30),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.primaryLightColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                trailing: Icon(Icons.arrow_drop_down_outlined),
                title: Text('Trail Details'),
                onTap: () {
                  setState(() {
                    _tripDetailsExpanded = !_tripDetailsExpanded;
                  });
                },
              ),
            ),
          ),
          if (_tripDetailsExpanded)
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    title: Text('Duration'),
                  ),
                  ListTile(
                    title: Text('other details'),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 20),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.primaryLightColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                trailing: Icon(Icons.arrow_drop_down_outlined),
                title: Text('Checkpoints'),
                onTap: () {
                  setState(() {
                    _checkpointsExpanded = !_checkpointsExpanded;
                  });
                },
              ),
            ),
          ),
          if (_checkpointsExpanded)
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    title: Text('this checkpoint'),
                  ),
                  ListTile(
                    title: Text('that checkpoint'),
                  ),
                  ListTile(
                    title: Text('so many checkpoints'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

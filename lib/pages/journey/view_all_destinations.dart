import 'package:flutter/material.dart';
import 'package:tour_me/widgets/card/image_card_list.dart';
import 'package:tour_me/widgets/card/image_card_list2.dart';
import 'package:tour_me/widgets/toggel_button.dart';

class ViewAll extends StatefulWidget {
  const ViewAll({Key? key}) : super(key: key);

  static const String routeName = '/all';

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  bool isList1Visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View All Page'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomToggleButton(
              initialValue: isList1Visible,
              onChanged: (bool isToggled) {
                setState(() {
                  isList1Visible = isToggled;
                });
              },
            ),
          ),
          Expanded(
            child: isList1Visible
                ? ImageCardList()
                : ImageCardList2(),
          ),
        ],
      ),
    );
  }
}

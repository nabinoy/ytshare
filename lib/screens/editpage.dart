import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ytshare/constants/global.dart';

class EditPage extends StatefulWidget {
  static const String routeName = '/editpage';
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  double _widgetSize = 50.0;
  Color _widgetColor = Colors.blue;
  int tabValue = 0;

  GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Edit",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              width: _widgetSize, // Adjust based on the maximum size
              height: _widgetSize, // Adjust based on the maximum size
              child: Container(
                color: _widgetColor,
                child: Text(
                  'Text',
                  style: TextStyle(fontSize: _widgetSize * 0.4),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Size: ${_widgetSize.toInt()}'),
                Slider(
                  value: _widgetSize,
                  min: 50,
                  max: 200,
                  onChanged: (value) {
                    setState(() {
                      _widgetSize = value;
                    });
                  },
                ),
              ],
            ),
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  DefaultTabController(
                    length: 4,
                    child: TabBar(
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: Global.fontRegular),
                      unselectedLabelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w100,
                          fontFamily: Global.fontRegular),
                      physics: const BouncingScrollPhysics(),
                      isScrollable: true,
                      indicatorPadding: const EdgeInsets.symmetric(vertical: 6),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerHeight: 0,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      splashFactory: NoSplash.splashFactory,
                      tabs: [
                        Tab(text: 'Design'),
                        Tab(text: 'Selection'),
                        Tab(text: 'Color'),
                        Tab(text: 'Size'),
                      ],
                      onTap: (value) {
                        setState(() {
                          tabValue = value;
                        });
                      },
                    ),
                  ),
                  TabContent(tabValue),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final int tabName;

  TabContent(this.tabName);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Content for $tabName',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          Text(
            'Selected Tab: $tabName',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

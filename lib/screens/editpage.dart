import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ytshare/constants/global.dart';
import 'package:ytshare/widgets/design0.dart';

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
  int selectedDesign = 0;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (selectedDesign == 0)
                ? Design0(_widgetSize, (value) {
                    setState(() {
                      _widgetSize = value;
                    });
                  })
                : Stack(alignment: Alignment.center, children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: MediaQuery.of(context).size.height * 0.55,
                        width: MediaQuery.of(context).size.width * 0.6),
                    Container(
                      width: _widgetSize, // Adjust based on the maximum size
                      height: _widgetSize, // Adjust based on the maximum size
                      child: Container(
                        color: _widgetColor,
                        child: Text(
                          'Textb',
                          style: TextStyle(fontSize: _widgetSize * 0.4),
                        ),
                      ),
                    )
                  ]),
            Column(
              children: [
                DefaultTabController(
                  length: 4,
                  child: TabBar(
                    tabAlignment: TabAlignment.center,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: Global.fontRegular),
                    unselectedLabelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w100,
                        fontFamily: Global.fontRegular),
                    physics: const BouncingScrollPhysics(),
                    isScrollable: true,
                    indicatorPadding: const EdgeInsets.symmetric(vertical: 10),
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
                      Tab(text: 'Background'),
                      Tab(text: 'Size'),
                    ],
                    onTap: (value) {
                      setState(() {
                        tabValue = value;
                      });
                    },
                  ),
                ),
                TabContent(tabValue, _widgetSize, (value) {
                  setState(() {
                    _widgetSize = value;
                  });
                }, (value) {
                  setState(() {
                    selectedDesign = value;
                  });
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TabContent extends StatefulWidget {
  final int tabName;
  final double widgetSize;
  final ValueChanged<double> onSizeChanged;
  final ValueChanged<int> onDesignChanged;

  const TabContent(
      this.tabName, this.widgetSize, this.onSizeChanged, this.onDesignChanged,
      {super.key});

  @override
  State<TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ((widget.tabName == 0))
          ? Row(children: [
              MaterialButton(
                minWidth: 60,
                height: 60,
                onPressed: () {
                  setState(() {
                    widget.onDesignChanged(0);
                  });
                },
                color: Colors.lightBlue[800],
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  "Design 1",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
              MaterialButton(
                minWidth: 60,
                height: 60,
                onPressed: () {
                  setState(() {
                    widget.onDesignChanged(1);
                  });
                },
                color: Colors.lightBlue[800],
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  "Design 2",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ])
          : (widget.tabName == 3)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Size: ${widget.widgetSize.toInt()}'),
                    Slider(
                      value: widget.widgetSize,
                      min: 50,
                      max: 200,
                      onChanged: (value) {
                        setState(() {
                          widget.onSizeChanged(value);
                        });
                      },
                    ),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Content foreeee ${widget.tabName}',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Selected Tab: ${widget.tabName}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
    );
  }
}

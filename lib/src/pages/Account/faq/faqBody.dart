import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'faq.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';

class FaqBody extends StatefulWidget {
  FaqBody({Key key, this.faqdata}) : super(key: key);
  Faq faqdata;

  @override
  _FaqBodyState createState() => _FaqBodyState();
}

class _FaqBodyState extends State<FaqBody> {
  int _activeInd;
  @override
  void initState() {
    super.initState();
    _activeInd = -1;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.faqdata.context.length,
                  itemBuilder: (BuildContext context, int i) {
                    return ConfigurableExpansionTile(
                      // borderColorStart: Colors.blue,
                      // borderColorEnd: Colors.orange,
                      animatedWidgetFollowingHeader: SizedBox(
                        width: SizeConfig.w * 0.3,
                        child: const Icon(
                          Icons.expand_more,
                          // color: const Color(0xFF707070),
                        ),
                      ),
                      headerExpanded: Flexible(
                        child: Container(
                            width: SizeConfig.w * 0.7,
                            // color: const Color(0xFF707070),
                            padding: const EdgeInsets.only(left: 20.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${i + 1}. " + widget.faqdata.context[i].que,
                              style: Theme.of(context).textTheme.headline6,
                            )),
                      ),
                      header: Flexible(
                        child: Container(
                            margin: EdgeInsets.only(
                                bottom: 15.0, top: i == 0 ? 8 : 0),
                            width: SizeConfig.w * 0.7,
                            // color: const Color(0xFF707070),
                            padding: const EdgeInsets.only(left: 20.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${i + 1}. " + widget.faqdata.context[i].que,
                              style: Theme.of(context).textTheme.headline6,
                            )),
                      ),
                      // headerBackgroundColorStart: Colors.grey,
                      expandedBackgroundColor: Colors.white,
                      headerBackgroundColorEnd: Colors.white,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // Colors.green,
                            // border: Border(
                            //   top: BorderSide(
                            //       width: 1.0,
                            //       color: Colors.grey[400]),
                            // ),
                          ),
                          padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            // Sunt labore qui excepteur adipisicing proident ullamco consequat do cillum veniam id.
                            widget.faqdata.context[i].ans,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ],
                    );

                    // ClipRect(
                    //   child: Theme(
                    //     data: Theme.of(context).copyWith(
                    //       cardColor: Colors.white,
                    //     ),
                    //     child: new ExpansionPanelList(
                    //         expandedHeaderPadding:
                    //             EdgeInsets.fromLTRB(8, 0, 0, 0),
                    //         expansionCallback: (int index, bool status) {
                    //           setState(() {
                    //             _activeInd = _activeInd == i ? null : i;
                    //           });
                    //         },
                    //         children: [
                    //           new ExpansionPanel(
                    //             canTapOnHeader: true,
                    //             isExpanded: _activeInd == i,
                    //             headerBuilder: (BuildContext context,
                    //                     bool isExpanded) =>
                    //                 new Container(
                    //                     margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                    //                     decoration: BoxDecoration(
                    //                       color: Colors.white,
                    //                       borderRadius:
                    //                           BorderRadius.circular(40.0),
                    //                     ),
                    //                     padding:
                    //                         const EdgeInsets.only(left: 20.0),
                    //                     alignment: Alignment.centerLeft,
                    //                     child: Text("${i + 1}. " +
                    //                         widget.faqdata.context[i].que)),
                    //             body: Container(
                    //               decoration: BoxDecoration(
                    //                 color: Colors.white,
                    //                 // border: Border(
                    //                 //   top: BorderSide(
                    //                 //       width: 1.0,
                    //                 //       color: Colors.grey[400]),
                    //                 // ),
                    //               ),
                    //               padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
                    //               alignment: Alignment.centerLeft,
                    //               child: Text(

                    //                   // Sunt labore qui excepteur adipisicing proident ullamco consequat do cillum veniam id.
                    //                   widget.faqdata.context[i].ans),
                    //             ),
                    //           ),
                    //         ]),
                    //   ),
                    // );
                  }),
              SizedBox(height: 20),
            ]),
      ),
    );
  }
}

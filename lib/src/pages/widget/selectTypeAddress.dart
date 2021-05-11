import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:flutter/material.dart';

class SelectTypeAddress extends StatefulWidget {
  SelectTypeAddress({Key key}) : super(key: key);

  @override
  _SelectTypeAddressState createState() => _SelectTypeAddressState();
}

class _SelectTypeAddressState extends State<SelectTypeAddress> {
  int index;
  @override
  void initState() {
    super.initState();
    index = 0;
  }List<String> selectName=["Home","Office","Others"];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return
    //  Container(
    //   // width: SizeConfig.w * 0.7,
    //   padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
    //   // margin: EdgeInsets.only(top: SizeConfig.w * 0.01),

    //   child:
    //   Expanded(
    //     child:
        Container(
          height: 50,
          padding: EdgeInsets.only(left: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context,i){
            return  Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: RoundedButton(
                
                  isBorder: index == i,
                  height: 35,
                  width: SizeConfig.w * 0.2,
                  child:
                   FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(selectName[i],
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: index == i ? Colors.white : Colors.black)),
                    ),
                  //  RaisedButton(
                  //   elevation: 0,
                  //   color: index == 1 ? Theme.of(context).primaryColor : Colors.white,
                    onPressed: () {
                      setState(() {
                        index = i;
                      });
                    },
                  // ),
                ),
            );
          },
          // );
          //  Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     RoundedButton(
          //       isBorder: index == 1,
          //       height: 35,
          //       width: SizeConfig.w * 0.2,
          //       child:
          //        FittedBox(
          //           fit: BoxFit.fitWidth,
          //           child: Text("Home",
          //               style: Theme.of(context).textTheme.headline6.copyWith(
          //                   color: index == 1 ? Colors.white : Colors.black)),
          //         ),
          //       //  RaisedButton(
          //       //   elevation: 0,
          //       //   color: index == 1 ? Theme.of(context).primaryColor : Colors.white,
          //         onPressed: () {
          //           setState(() {
          //             index = 1;
          //           });
          //         },
          //       // ),
          //     ),
          //     RoundedButton(
          //       isBorder: index == 2,
          //       width: SizeConfig.w * 0.2,
          //       height: 35,
          //       child: RaisedButton(
          //         elevation: 0,
          //         color: index == 2 ? Theme.of(context).primaryColor : Colors.white,
          //         onPressed: () {
          //           setState(() {
          //             index = 2;
          //           });
          //         },
          //         child: FittedBox(
          //           fit: BoxFit.fitWidth,
          //           child: Text("Office",
          //               style: Theme.of(context).textTheme.headline6.copyWith(
          //                   color: index == 2 ? Colors.white : Colors.black)),
          //         ),
          //       ),
          //     ),
          //     RoundedButton(
          //       isBorder: index == 3,
          //       height: 35,
          //       width: SizeConfig.w * 0.2,
          //       child: RaisedButton(
          //         elevation: 0,
          //         color: index == 3 ? Theme.of(context).primaryColor : Colors.white,
          //         onPressed: () {
          //           setState(() {
          //             index = 3;
          //           });
          //         },
          //         child: FittedBox(
          //           fit: BoxFit.fitWidth,
          //           child: Text("Others",
          //               style: Theme.of(context).textTheme.headline6.copyWith(
          //                   color: index == 3 ? Colors.white : Colors.black)),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
    // ),
      ),
        );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton({Key key, this.child, 
  this.onPressed,
  this.height, this.width, this.isBorder})
      : super(key: key);
  Widget child;
  double height, width;
  bool isBorder;
  Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: !isBorder
              ? Border.all(width: 1.2, color: Colors.grey)
              : Border.all(width: 0),
          borderRadius: BorderRadius.circular(5),
        ),
        height: height,
        width: width,
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), ),
            elevation: 0,
            color: isBorder ? Theme.of(context).primaryColor : Colors.white,
            onPressed: onPressed,
            child: child));
  }
}

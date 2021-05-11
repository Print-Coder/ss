// import 'package:flutter/material.dart';

// class ProductBottom extends StatefulWidget {
//   ProductBottom({Key key}) : super(key: key);

//   @override
//   _ProductBottomState createState() => _ProductBottomState();
// }

// class _ProductBottomState extends State<ProductBottom> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        child: child,
//     );
//   }
// }
// StatefulBuilder(
//                                           builder: (context, setState) {
//                                         return Wrap(
//                                           children: <Widget>[
//                                             Center(
//                                               child: Container(
//                                                 margin: EdgeInsets.all(8),
//                                                 width: 25,
//                                                 height: 2,
//                                                 color: Colors.grey[400],
//                                               ),
//                                             ),
//                                             Center(
//                                               child: Container(
//                                                 margin: EdgeInsets.all(8),
//                                                 // padding: EdgeInsets.only(left: 8),

//                                                 child: Text(
//                                                   widget.productData.name ??
//                                                       "Name",
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   maxLines: 2,
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .headline5
//                                                       .copyWith(
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           color: Colors.black,
//                                                           fontSize: 14),
//                                                 ),
//                                               ),
//                                             ),
//                                             //  Container(
//                                             //               margin: EdgeInsets.all(5),
//                                             //             // width: SizeConfig.w*0.8,
//                                             //             child:Text(widget
//                                             //                         .productData
//                                             //                         ?.name??"Product")),
//                                             ListView.builder(
//                                                 physics:
//                                                     NeverScrollableScrollPhysics(),
//                                                 shrinkWrap: true,
//                                                 scrollDirection: Axis.vertical,
//                                                 itemCount: widget?.productData
//                                                         ?.variant?.length ??
//                                                     0,
//                                                 itemBuilder:
//                                                     (context, bottomIndex) {
//                                                   return ListTile(
//                                                     dense: true,
//                                                     enabled: false,
//                                                     // activeColor: Theme
//                                                     //         .of(context)
//                                                     //     .primaryColor,
//                                                     // controlAffinity:
//                                                     //     ListTileControlAffinity
//                                                     //         .leading,
//                                                     // value: bottomIndex,
//                                                     // groupValue: value,

//                                                     // print(ind);
//                                                     // setState(() {
//                                                     //   value =
//                                                     //       bottomIndex;
//                                                     //   widget.productData
//                                                     //           .varientIndex =
//                                                     //       bottomIndex;
//                                                     //   selectedQuantity = widget
//                                                     //       ?.productData
//                                                     //       ?.variant[widget
//                                                     //           ?.productData
//                                                     //           ?.varientIndex]
//                                                     //       .prices
//                                                     //       .lastIndexWhere((pri) =>
//                                                     //           widget
//                                                     //               ?.productData
//                                                     //               ?.variant[widget?.productData?.varientIndex]
//                                                     //               .quantity >=
//                                                     //           pri.quantity);
//                                                     // });
//                                                     // print(widget
//                                                     //     ?.productData
//                                                     //     .variant[widget
//                                                     //         ?.productData
//                                                     //         ?.varientIndex]
//                                                     //     .quantity);
//                                                     // Provider.of<ProductListData>(
//                                                     //         context,
//                                                     //         listen:
//                                                     //             false)
//                                                     //     .setVarient(widget
//                                                     //         ?.productData);

//                                                     title: Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               top: 12,
//                                                               bottom: 4),
//                                                       child: Text(
//                                                         widget
//                                                                 .productData
//                                                                 ?.variant[
//                                                                     bottomIndex]
//                                                                 ?.title ??
//                                                             "1 KG",
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .headline5
//                                                             .copyWith(
//                                                                 color: bottomIndex ==
//                                                                         varientIndex
//                                                                     ? Theme.of(
//                                                                             context)
//                                                                         .primaryColor
//                                                                     : Colors
//                                                                         .black),
//                                                       ),
//                                                     ),
//                                                     isThreeLine: true,
//                                                     subtitle: ListView.builder(
//                                                         shrinkWrap: true,
//                                                         physics:
//                                                             NeverScrollableScrollPhysics(),
//                                                         scrollDirection:
//                                                             Axis.vertical,
//                                                         itemCount: widget
//                                                                 ?.productData
//                                                                 ?.variant[
//                                                                     bottomIndex]
//                                                                 .prices
//                                                                 ?.length ??
//                                                             0,
//                                                         itemBuilder: (context,
//                                                             priceIndex) {
//                                                           var subtitle = widget
//                                                               ?.productData
//                                                               ?.variant[
//                                                                   bottomIndex]
//                                                               .prices[priceIndex];
//                                                           return ListTile(
//                                                             leading: Radio(
//                                                               activeColor: Theme
//                                                                       .of(context)
//                                                                   .primaryColor,
//                                                               onChanged: (i) {
//                                                                 setState(() {
//                                                                   varientIndex =
//                                                                       bottomIndex;
//                                                                   selectedQuantity =
//                                                                       priceIndex;
//                                                                   value = i;
//                                                                 });
//                                                                 print("this is on chaged" +
//                                                                     value
//                                                                         .toString());
//                                                               },
//                                                               value: int.parse(
//                                                                   bottomIndex
//                                                                           .toString() +
//                                                                       priceIndex
//                                                                           .toString()),
//                                                               groupValue: value,
//                                                             ),
//                                                             onTap: () {
//                                                               setState(() {
//                                                                 selectedQuantity =
//                                                                     int.parse(bottomIndex.toString() +
//                                                                             priceIndex.toString()) %
//                                                                         10;
//                                                                 value = int.parse(
//                                                                     bottomIndex
//                                                                             .toString() +
//                                                                         priceIndex
//                                                                             .toString());
//                                                               });
//                                                             },
//                                                             title: Text(subtitle
//                                                                         .quantity
//                                                                         .toString() +
//                                                                     "x " +
//                                                                     "each @ " +
//                                                                     subtitle
//                                                                         .price
//                                                                         .toString()
//                                                                 // +(subtitle.quantity>1?"/ 1":"")
//                                                                 ),
//                                                           );
//                                                         }),

//                                                     // bottomIndex ==
//                                                     //         value
//                                                     //     ? widget?.productData.variant[widget?.productData?.varientIndex].quantity ==
//                                                     //             0
//                                                     //         ?
//                                                     //  Container(
//                                                     //     margin: EdgeInsets.only(
//                                                     //         right:
//                                                     //             2),
//                                                     //     color: Colors
//                                                     //         .white,
//                                                     //     alignment:
//                                                     //         Alignment.centerRight,
//                                                     //     child: GestureDetector(
//                                                     //         child: Icon(
//                                                     //           Icons.add_circle,
//                                                     //           size: 36,
//                                                     //           color: Theme.of(context).primaryColor,
//                                                     //         ),
//                                                     //         onTap: () async {
//                                                     //           // setState(() {
//                                                     //           if (widget?.productData.variant[widget?.productData?.varientIndex].quantity == 0) setState(() => widget?.productData.variant[widget?.productData?.varientIndex].quantity = 1);

//                                                     //           Map data = Cart().toMap(
//                                                     //             productId: widget.productData.itemId,
//                                                     //             quantity: 1,
//                                                     //             variantId: widget.productData.variant[bottomIndex].id,
//                                                     //             pincode: userData.currentUser.addresses[0].zip,
//                                                     //           );
//                                                     //           Map res = await ApiServices.postRequestToken(
//                                                     //             json.encode(data),
//                                                     //             cartEndPoint,
//                                                     //           );
//                                                     //           if (res["status"]) {
//                                                     //             widget?.productData?.isCart = true;
//                                                     //             Provider.of<ProductListData>(context, listen: false).setQuantity(widget?.productData, widget?.productData.variant[widget?.productData?.varientIndex].quantity);
//                                                     //           } else {
//                                                     //             widget?.productData?.quantity = 0;

//                                                     //             Fluttertoast.showToast(
//                                                     //               msg: res["message"],
//                                                     //               backgroundColor: Colors.grey[400],
//                                                     //               toastLength: Toast.LENGTH_LONG,
//                                                     //               gravity: ToastGravity.CENTER,
//                                                     //               timeInSecForIosWeb: 2,
//                                                     //             );
//                                                     //           }
//                                                     //         }))
//                                                   );
//                                                 }),
//                                             Spacer(),
//                                             Center(
//                                               child: Container(
//                                                   decoration: BoxDecoration(
//                                                     color: Theme.of(context)
//                                                         .primaryColor,
//                                                     // border: BoxBorder(),
//                                                     borderRadius:
//                                                         BorderRadius.all(
//                                                             Radius.circular(5)),
//                                                   ),
//                                                   margin: EdgeInsets.only(
//                                                       bottom: 20),
//                                                   padding: EdgeInsets.only(
//                                                       left: 5, right: 5),
//                                                   width: SizeConfig.w * 0.92,
//                                                   height: 50.0,
//                                                   child: RawMaterialButton(
//                                                       fillColor:
//                                                           Theme.of(context)
//                                                               .primaryColor,
//                                                       shape: new CircleBorder(),
//                                                       elevation: 0.0,
//                                                       child: Row(
//                                                         children: <Widget>[
//                                                           Container(
//                                                             width:
//                                                                 SizeConfig.w *
//                                                                     0.28,
//                                                             height: 50.0,
//                                                             child: Row(
//                                                               children: <
//                                                                   Widget>[
//                                                                 Text(
//                                                                   // "fhd",
//                                                                   "You Pay: ₹${widget.productData.variant[varientIndex].prices[selectedQuantity].price * widget.productData.variant[varientIndex].prices[selectedQuantity].quantity}",
//                                                                   // overflow: TextOverflow.ellipsis,
//                                                                   maxLines: 2,
//                                                                   style: Theme.of(
//                                                                           context)
//                                                                       .textTheme
//                                                                       .headline6
//                                                                       .copyWith(
//                                                                         fontWeight:
//                                                                             FontWeight.bold,
//                                                                         color: Colors
//                                                                             .white,
//                                                                         fontSize:
//                                                                             14,
//                                                                       ),
//                                                                 ),
//                                                                 // Text(
//                                                                 //   // "fhd",
//                                                                 //   "You Save: ₹${widget.productData.variant[varientIndex].prices[selectedQuantity].price * widget.productData.variant[varientIndex].prices[selectedQuantity].quantity}",
//                                                                 //   // overflow: TextOverflow.ellipsis,
//                                                                 //   maxLines: 2,
//                                                                 //   style: Theme.of(
//                                                                 //           context)
//                                                                 //       .textTheme
//                                                                 //       .headline6
//                                                                 //       .copyWith(
//                                                                 //         fontWeight:
//                                                                 //             FontWeight.bold,
//                                                                 //         color: Colors
//                                                                 //             .white,
//                                                                 //         fontSize:
//                                                                 //             14,
//                                                                 //       ),
//                                                                 // ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                           Spacer(),
//                                                           Text("ADD ITEMS",
//                                                               style: TextStyle(
//                                                                   fontSize: 18,
//                                                                   color: Colors
//                                                                       .white)),
//                                                         ],
//                                                       ),
//                                                       onPressed: () async {
//                                                         // setState(() {

//                                                         Map data = Cart().toMap(
//                                                           productId: widget
//                                                               .productData
//                                                               .itemId,
//                                                           quantity: widget
//                                                               .productData
//                                                               .variant[
//                                                                   varientIndex]
//                                                               .prices[
//                                                                   selectedQuantity]
//                                                               .quantity,
//                                                           variantId: widget
//                                                               .productData
//                                                               .variant[
//                                                                   varientIndex]
//                                                               .id,
//                                                           pincode: userData
//                                                               .currentUser
//                                                               .addresses[0]
//                                                               .zip,
//                                                         );
//                                                         print("data to cart");
//                                                         print(
//                                                             "$varientIndex $selectedQuantity ${data.toString()}");
//                                                         Map res =
//                                                             await ApiServices
//                                                                 .postRequestToken(
//                                                           json.encode(data),
//                                                           cartEndPoint,
//                                                         );
//                                                         if (res["status"]) {
//                                                           widget?.productData
//                                                               ?.isCart = true;
//                                                           Provider.of<ProductListData>(
//                                                                   context,
//                                                                   listen: false)
//                                                               .setQuantity(
//                                                                   widget
//                                                                       ?.productData,
//                                                                   widget
//                                                                       ?.productData
//                                                                       .variant[
//                                                                           varientIndex]
//                                                                       .quantity);
//                                                         } else {
//                                                           widget?.productData
//                                                               ?.quantity = 0;

//                                                           Fluttertoast
//                                                               .showToast(
//                                                             msg: res["message"],
//                                                             backgroundColor:
//                                                                 Colors
//                                                                     .grey[400],
//                                                             toastLength: Toast
//                                                                 .LENGTH_LONG,
//                                                             gravity:
//                                                                 ToastGravity
//                                                                     .CENTER,
//                                                             timeInSecForIosWeb:
//                                                                 2,
//                                                           );
//                                                         }
//                                                       })),
//                                             ),
//                                           ],
//                                         );
//                                       });
//                                     });

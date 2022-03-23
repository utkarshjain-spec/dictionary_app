// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:myshift_admin/customwidgets/custom_edit_text.dart';
// import 'package:myshift_admin/states/user_state.dart';
// import 'package:myshift_admin/ui/auth/home/widgets/business_card.dart';
// import 'package:myshift_admin/ui/auth/home/widgets/business_card_mobile.dart';
// import 'package:myshift_admin/utils/app_color.dart';
// import 'package:myshift_admin/utils/responsive.dart';
// import 'package:myshift_admin/utils/screen_builder.dart';
// import 'package:provider/provider.dart';

// class BusinessUsersList extends StatefulWidget {
//   const BusinessUsersList({Key? key}) : super(key: key);

//   @override
//   BusinessUsersListState createState() => BusinessUsersListState();
// }

// class _BusinessUsersListState extends State<BusinessUsersList> {
//   final ScrollController _scrollController = ScrollController();
//   Timer? _debounce;
//   bool isLoading = false;

//   bool isClickedOnSearch = false;
//   TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     print('initState');

//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels ==
//           _scrollController.position.maxScrollExtent) {
//         var provider = Provider.of<UserState>(context, listen: false);
//         print(provider.businessUsersList.data?.results?.length.toString());
//         if (!isLoading && provider.businessUsersList.data?.next != null) {
//           setState(() {
//             isLoading = true;
//           });
//           print('load more');
//           provider
//               .getNextBuinessUsersList(
//                   url: provider.businessUsersList.data?.next)
//               .then((value) {
//             setState(() {
//               isLoading = false;
//             });
//           });
//         }
//         // Provider.of<UserState>(context, listen: false).getNextUsersList();
//       }
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _debounce?.cancel();
//     super.dispose();
//   }

//   _searchBusinessUser(String query) {
//     if (debounce?.isActive ?? false) debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () {
//       Provider.of<UserState>(context, listen: false)
//           .getBusinessSearchList(query.toString())
//           .then((value) => {if (value.isSuccessed) {}});
//     });
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.only(
//                 top: 15,
//                 bottom: 15,
//                 left: Responsive.isMobile(context) ? 14 : 50,
//                 right: Responsive.isMobile(context) ? 14 : 50),
//             child: Row(
//               children: [
//                 Text(
//                   "Businesses",
//                   style: TextStyle(
//                       fontSize: Responsive.isMobile(context) ? 18 : 36,
//                       color: AppColor.darkBlue,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   width: 19,
//                 ),
//                 if (!isClickedOnSearch)
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         isClickedOnSearch = !isClickedOnSearch;
//                       });
//                     },
//                     child: Row(children: [
//                       Icon(
//                         Icons.search,
//                         color: Color(0xff829cbc),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         "Search",
//                         style: TextStyle(
//                             fontSize: 16,
//                             color: Color(0xff829cbc),
//                             fontWeight: FontWeight.normal),
//                       ),
//                     ]),
//                   ),
//                 if (isClickedOnSearch)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(width: 20),
//                       Container(
//                         width: Responsive.isMobile(context) ? 180 : 300,
//                         child: TextFormFieldWithBorderWidget(
//                           autofocus: true,
//                           height: 55,
//                           onChanged: (value) => _searchBusinessUser(value),
//                           hintText: "Search",
//                           radius: 10,
//                           suffixIcon: InkWell(
//                             onTap: () {
//                               _searchController.clear();
//                               setState(() {
//                                 isClickedOnSearch = !isClickedOnSearch;
//                               });
//                               _searchBusinessUser('');
//                             },
//                             child: Padding(
//                                 padding: const EdgeInsets.only(right: 10),
//                                 child: Icon(Icons.close)),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//           Consumer<UserState>(builder: (context, userState, __) {
//             return Expanded(
//                 child: ScreenBuilder(
//               dataState: userState.businessUsersList.dataState,
//               onSuccessScreen: userState.businessUsersList.data?.count == 0
//                   ? Center(
//                       child: Text('No Data Found',
//                           style: TextStyle(
//                               color: AppColor.darkBlue, fontSize: 17)),
//                     )
//                   : ListView.separated(
//                       scrollDirection: Axis.vertical,
//                       controller: _scrollController,
//                       physics: ScrollPhysics(),
//                       padding: EdgeInsets.symmetric(
//                           vertical: 20,
//                           horizontal: Responsive.isMobile(context) ? 14 : 50),
//                       separatorBuilder: (context, index) {
//                         return const SizedBox(
//                           height: 10,
//                         );
//                       },
//                       itemBuilder: (context, index) {
//                         final user =
//                             userState.businessUsersList.data!.results![index];
//                         if (isLoading &&
//                             index ==
//                                 userState.businessUsersList.data!.results!
//                                         .length -
//                                     1) {
//                           print('loadin');
//                           return Center(child: CircularProgressIndicator());
//                         }
//                         return Responsive(
//                             mobile: BusinessCardMobile(
//                               userDetails: user,
//                               onTap: () {
//                                 _searchController.clear();
//                                 isClickedOnSearch = false;
//                                 setState(() {});
//                               },
//                             ),
//                             desktop: MediaQuery.of(context).size.width > 900 &&
//                                     MediaQuery.of(context).size.width < 1050
//                                 ? BusinessCard(
//                                     onTap: () {
//                                       _searchController.clear();
//                                       isClickedOnSearch = false;
//                                       setState(() {});
//                                     },
//                                     userDetails: user,
//                                   )
//                                 : Column(
//                                     children: [
//                                       BusinessCard(
//                                         onTap: () {
//                                           _searchController.clear();
//                                           isClickedOnSearch = false;
//                                           setState(() {});
//                                         },
//                                         userDetails: user,
//                                       ),
//                                     ],
//                                   ),
//                             tablet: BusinessCard(
//                               onTap: () {
//                                 _searchController.clear();
//                                 isClickedOnSearch = false;
//                                 setState(() {});
//                               },
//                               userDetails: user,
//                             ));
//                       },
//                       itemCount: isLoading
//                           ? userState.businessUsersList.data?.results?.length ??
//                               0
//                           : userState.businessUsersList.data?.results?.length ??
//                               0 + 1,
//                       shrinkWrap: true,
//                     ),
//             ));
//           })
//         ],
//       ),
//     );
//   }
// }